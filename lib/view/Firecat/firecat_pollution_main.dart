import 'dart:collection';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart' hide Route;

import 'firecat_pollution_background.dart';
import 'firecat_pollution_bullet.dart';
import 'firecat_pollution_enemy.dart';
import 'firecat_pollution_killed_enemy.dart';
import 'firecat_pollution_player.dart';

class FirecatPollutionFlameMain extends FlameGame
    with
        HasCollisionDetection,
        ScrollDetector,
        ScaleDetector,
        DoubleTapDetector {
  FirecatPollutionFlameMain({required this.viewMaxSize});
  Vector2 worldMaxSize = Vector2(2048, 2048);
  Vector2 viewMaxSize;

  FirecatPollutionPlayer player = FirecatPollutionPlayer();
  final HashMap<String, FirecatPollutionEnemy> hashMapEnemy = HashMap();
  int countEnemy = 30;

  TextComponent loadingText = TextComponent(
      priority: 100,
      text: 'Loading...',
      textRenderer: TextPaint(
        style: TextStyle(
          color: BasicPalette.white.color,
          fontSize: 36.0,
          fontFamily: 'Pretendard',
          shadows: const [
            Shadow(color: Colors.red, offset: Offset(2, 2), blurRadius: 2),
            Shadow(color: Colors.yellow, offset: Offset(4, 4), blurRadius: 4),
          ],
        ),
      ))
    ..anchor = Anchor.center
    ..position = Vector2(100, 100);

  void clampZoom() {
    camera.viewfinder.zoom = camera.viewfinder.zoom.clamp(0.5, 2.5);
  }

  static const zoomPerScrollUnit = 0.02;

  @override
  void onScroll(PointerScrollInfo info) {
    camera.viewfinder.zoom +=
        info.scrollDelta.global.y.sign * zoomPerScrollUnit;
    clampZoom();
  }

  late double startZoom;

  @override
  void onScaleStart(_) {
    startZoom = camera.viewfinder.zoom;
  }

  @override
  void onScaleUpdate(ScaleUpdateInfo info) {
    final currentScale = info.scale.global;

    Vector2 maxWorldSize = Vector2(worldMaxSize.x, worldMaxSize.y);
    Vector2 maxScreenSize = Vector2(viewMaxSize.x / camera.viewfinder.zoom,
        viewMaxSize.y / camera.viewfinder.zoom);

    Vector2 playerSize = Vector2(player.size.x, player.size.y);
    Vector2 playerPosition = Vector2(player.position.x, player.position.y);

    double cameraX = playerPosition.x - maxScreenSize.x / 2 + playerSize.x / 2;
    double cameraY = playerPosition.y - maxScreenSize.y / 2 + playerSize.y / 2;

    if (cameraX < 0) {
      cameraX = 0;
    } else if (cameraX + maxScreenSize.x > maxWorldSize.x) {
      cameraX = maxWorldSize.x - maxScreenSize.x;
    }

    if (cameraY < 0) {
      cameraY = 0;
    } else if (cameraY + maxScreenSize.y > maxWorldSize.y) {
      cameraY = maxWorldSize.y - maxScreenSize.y;
    }

    if (!currentScale.isIdentity()) {
      camera.moveTo(Vector2(cameraX, cameraY));
      camera.viewfinder.zoom = startZoom * currentScale.y;
      clampZoom();
    } else {
      final delta = info.delta.global * 1.5 / camera.viewfinder.zoom;
      playerPosition += delta;

      if (playerPosition.x < 50) {
        playerPosition.x = 50;
      }
      if (playerPosition.x > (worldMaxSize.x - playerSize.x)) {
        playerPosition.x = (worldMaxSize.x - playerSize.x);
      }
      if (playerPosition.y < 50) {
        playerPosition.y = 50;
      }
      if (playerPosition.y > (worldMaxSize.y - playerSize.y)) {
        playerPosition.y = (worldMaxSize.y - playerSize.y);
      }

      player.position = playerPosition;
      camera.moveTo(Vector2(cameraX + delta.x, cameraY + delta.y));
    }
  }

  @override
  void onScaleEnd(ScaleEndInfo info) {}

  @override
  void onDoubleTapDown(TapDownInfo info) {
    Vector2 clickWorld = camera.viewfinder.position +
        info.eventPosition.global / camera.viewfinder.zoom;

    Vector2 playerCenter = player.position + player.size / 2;
    playerCenter = playerCenter + Vector2(0, -50);

    Vector2 direction = clickWorld - playerCenter;

    initGun(playerCenter, direction.normalized());
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    await images.load('monster1_sprite.png');

    await images.load('coin.png');
    await images.load('boom.png');

    FirecatPollutionBackground background = FirecatPollutionBackground();
    world.add(background..anchor = Anchor.topLeft);
    camera = CameraComponent.withFixedResolution(
      width: viewMaxSize.x,
      height: viewMaxSize.y,
    );
    camera.viewfinder.anchor = Anchor.topLeft;
    camera.viewport.anchor = Anchor.topLeft;
    //camera.viewfinder.position = Vector2(100, 100);
    world.add(player
      ..anchor = Anchor.center
      ..size = Vector2(50, 50)
      ..position = Vector2(300, 300));

//    camera.follow(player);
    // add(TimerComponent(
    //     period: 10,
    //     repeat: false,
    //     onTick: () {
    //       remove(loadingText);
    //     }));

    List<Vector2> vectorDataList = [];
    debugPrint('worldMaxSize: $worldMaxSize viewMaxSize: $viewMaxSize');

    for (double x = 0; x <= worldMaxSize.x; x += viewMaxSize.x) {
      for (double y = 0; y <= worldMaxSize.y; y += viewMaxSize.y) {
        vectorDataList.add(Vector2(x, y));
      }
    }

    debugPrint('vectorDataList: $vectorDataList');

    for (var element in vectorDataList) {
      world.add(await loadParallaxComponent(
        [
          ParallaxImageData('cloud_XL.png'),
        ],
        baseVelocity: Vector2(-5, -15),
        velocityMultiplierDelta: Vector2(1.8, 1.0),
        repeat: ImageRepeat.repeat,
        position: element,
      ));

      world.add(await loadParallaxComponent(
        [
          ParallaxImageData('cloud_L.png'),
        ],
        baseVelocity: Vector2(-20, -10),
        velocityMultiplierDelta: Vector2(1.8, 1.0),
        repeat: ImageRepeat.repeat,
        position: element,
      ));

      world.add(await loadParallaxComponent(
        [
          ParallaxImageData('cloud_M.png'),
        ],
        baseVelocity: Vector2(-30, -20),
        velocityMultiplierDelta: Vector2(1.8, 1.0),
        repeat: ImageRepeat.repeat,
        position: element,
      ));

      world.add(await loadParallaxComponent(
        [
          ParallaxImageData('cloud_S.png'),
        ],
        baseVelocity: Vector2(-40, -30),
        velocityMultiplierDelta: Vector2(1.8, 1.0),
        repeat: ImageRepeat.repeat,
        position: element,
      ));
    }

    initEnemy();
  }

  Future<void> initEnemy() async {
    for (int i = 0; i < countEnemy; i++) {
      int moveX = Random().nextInt(worldMaxSize.x.toInt() - 200) + 100;
      int moveY = Random().nextInt(worldMaxSize.y.toInt() - 200) + 200;

      FirecatPollutionEnemy pollutionEnemy = FirecatPollutionEnemy(
        position: Vector2(moveX.toDouble(), moveY.toDouble()),
        size: Vector2(250, 250),
        enemyId: i.toString(),
        imagePath: 'monster1_sprite.png',
        imageSize: Vector2(200.0, 200.0),
        spriteNum: 5,
        spriteSpeed: i % 3 == 0
            ? 0.2
            : i % 3 == 1
                ? 0.2
                : 0.08,
      );

      hashMapEnemy[i.toString()] = pollutionEnemy;

      add(pollutionEnemy
        ..add(
          OpacityEffect.fadeOut(
            EffectController(
              duration: 1.5,
              reverseDuration: 1.5,
              infinite: false,
            ),
          ),
        ));
    }
    _setCUEnemy();
  }

  Future<void> _setCUEnemy() async {
    add(TimerComponent(
        period: 1,
        repeat: true,
        onTick: () {
          hashMapEnemy.forEach((key, element) {
            element.move(Vector2(Random().nextInt(120) - 60.toDouble(),
                Random().nextInt(120) - 60.toDouble()));
          });
        }));
  }

  Future<void> delCUEnemy(String idEnemy) async {
    add(FirecatPollutionKilledEnemy(
        position: hashMapEnemy[idEnemy]!.position,
        size: Vector2(150, 150),
        imagePath: 'slimekill.png'));

    hashMapEnemy.forEach((key, value) {
      if (key.compareTo(idEnemy) == 0) {
        remove(value);
      }
    });

    hashMapEnemy.remove(idEnemy);
    countEnemy = hashMapEnemy.length;
  }

  Future<void> initGun(Vector2 center, Vector2 direction) async {
    add(FirecatPollutionBullet(position: center, direction: direction));
  }
}

Widget gameFirecatPollutionMainBuilder(Vector2 viewMaxSize) {
  return GameWidget(
    game: FirecatPollutionFlameMain(viewMaxSize: viewMaxSize),
    // overlayBuilderMap: {
    //   'OpenChat': (context, game) {
    //     return Positioned(
    //       bottom: 0,
    //       left: 0,
    //       width: 400,
    //       height: 400,
    //       child: Text('OpenChat'),
    //     );
    //   },
    //   'CloseChat': (context, game) {
    //     return Positioned(
    //       bottom: 0,
    //       left: 0,
    //       width: 400,
    //       height: 50,
    //       child: Text('CloseChat'),
    //     );
    //   },
    // },
  );
}
