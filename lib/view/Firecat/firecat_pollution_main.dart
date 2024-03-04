import 'dart:collection';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
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
  FirecatPollutionFlameMain(
      {required this.viewMaxSize,
      required this.backgroundImagePath,
      required this.monsterImagePath,
      required this.killedMonsterImagePath});
  int secMax = 180;
  Vector2 worldMaxSize = Vector2(2048, 2048);
  Vector2 viewMaxSize;
  String backgroundImagePath;
  String monsterImagePath;
  String killedMonsterImagePath;

  FirecatPollutionPlayer player = FirecatPollutionPlayer();
  final HashMap<String, FirecatPollutionEnemy> _hashMapEnemy = HashMap();
  int _countEnemy = 20;
  final List<ParallaxComponent> _cloudXLList = [];
  final List<ParallaxComponent> _cloudLList = [];
  final List<ParallaxComponent> _cloudMList = [];
  final List<ParallaxComponent> _cloudSList = [];

  // TextComponent loadingText = TextComponent(
  //     priority: 100,
  //     text: 'Loading...',
  //     textRenderer: TextPaint(
  //       style: TextStyle(
  //         color: BasicPalette.white.color,
  //         fontSize: 36.0,
  //         fontFamily: 'Pretendard',
  //         shadows: const [
  //           Shadow(color: Colors.red, offset: Offset(2, 2), blurRadius: 2),
  //           Shadow(color: Colors.yellow, offset: Offset(4, 4), blurRadius: 4),
  //         ],
  //       ),
  //     ))
  //   ..anchor = Anchor.center;

  TextComponent killedSlimeText = TextComponent(
      priority: 100,
      text: '',
      textRenderer: TextPaint(
        style: TextStyle(
          color: BasicPalette.black.color,
          fontSize: 20.0,
          fontFamily: 'Pretendard',
          shadows: const [
            Shadow(color: Colors.black45, offset: Offset(2, 2), blurRadius: 2),
            Shadow(color: Colors.black26, offset: Offset(4, 4), blurRadius: 4),
          ],
        ),
      ))
    ..position = Vector2(20, 130)
    ..priority = 10;

  TextComponent killedSlimeTimeText = TextComponent(
      priority: 100,
      text: '',
      textRenderer: TextPaint(
        style: TextStyle(
          color: BasicPalette.black.color,
          fontSize: 20.0,
          fontFamily: 'Pretendard',
          shadows: const [
            Shadow(color: Colors.black45, offset: Offset(2, 2), blurRadius: 2),
            Shadow(color: Colors.black26, offset: Offset(4, 4), blurRadius: 4),
          ],
        ),
      ))
    ..position = Vector2(100, 130)
    ..priority = 10;

  final DateTime _startDateTime = DateTime.now();
  double _killedSlimeSec = 0;

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    _killedSlimeSec = (DateTime.now().microsecondsSinceEpoch -
            _startDateTime.microsecondsSinceEpoch) /
        1000000;

    killedSlimeText.textRenderer.render(
        canvas, "Monster : $_countEnemy", Vector2((viewMaxSize.x - 120), 130));

    if (_countEnemy == 0) {
      pauseEngine();
      return;
    }

    if (_killedSlimeSec < secMax) {
      int seconds = secMax - _killedSlimeSec.toInt();
      int minutes = seconds ~/ 60;
      int remainingSeconds = seconds % 60;

      killedSlimeText.textRenderer.render(
          canvas,
          "$minutes:${remainingSeconds.toString().padLeft(2, '0')}",
          Vector2(20, 130));
    } else {
      killedSlimeText.textRenderer
          .render(canvas, "Completed", Vector2(20, 130));
      pauseEngine();
    }
    return;
  }

  // @override
  // void update(double dt) {
  //   super.update(dt);
  // }

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

    List<Vector2> vectorDataList = [];

    debugPrint('worldMaxSize: $worldMaxSize viewMaxSize: $viewMaxSize');

    for (double x = 0; x <= worldMaxSize.x; x += viewMaxSize.x) {
      for (double y = 0; y <= worldMaxSize.y; y += viewMaxSize.y) {
        vectorDataList.add(Vector2(x, y));
      }
    }

    debugPrint('vectorDataList: $vectorDataList');

    for (var element in vectorDataList) {
      ParallaxComponent<FlameGame<World>> elementXL =
          await loadParallaxComponent(
        [
          ParallaxImageData('cloud_XL.png'),
        ],
        baseVelocity: Vector2(-5, -15),
        velocityMultiplierDelta: Vector2(1.8, 1.0),
        repeat: ImageRepeat.repeat,
        position: element,
      );
      world.add(elementXL);
      _cloudXLList.add(elementXL);

      ParallaxComponent<FlameGame<World>> elementL =
          await loadParallaxComponent(
        [
          ParallaxImageData('cloud_L.png'),
        ],
        baseVelocity: Vector2(-20, -10),
        velocityMultiplierDelta: Vector2(1.8, 1.0),
        repeat: ImageRepeat.repeat,
        position: element,
      );
      world.add(elementL);
      _cloudLList.add(elementL);

      ParallaxComponent<FlameGame<World>> elementM =
          await loadParallaxComponent(
        [
          ParallaxImageData('cloud_M.png'),
        ],
        baseVelocity: Vector2(-30, -20),
        velocityMultiplierDelta: Vector2(1.8, 1.0),
        repeat: ImageRepeat.repeat,
        position: element,
      );
      world.add(elementM);
      _cloudMList.add(elementM);

      ParallaxComponent<FlameGame<World>> elementS =
          await loadParallaxComponent(
        [
          ParallaxImageData('cloud_S.png'),
        ],
        baseVelocity: Vector2(-40, -30),
        velocityMultiplierDelta: Vector2(1.8, 1.0),
        repeat: ImageRepeat.repeat,
        position: element,
      );
      world.add(elementS);
      _cloudSList.add(elementS);
    }

    initEnemy();

    world.add(killedSlimeTimeText);
    world.add(killedSlimeText);
    // add(loadingText..anchor = Anchor.center);
    // add(TimerComponent(
    //     period: 2,
    //     repeat: false,
    //     onTick: () {
    //       remove(loadingText);
    //     }));
  }

  Future<void> initEnemy() async {
    for (int i = 0; i < _countEnemy; i++) {
      int moveX = Random().nextInt(worldMaxSize.x.toInt() - 200) + 100;
      int moveY = Random().nextInt(worldMaxSize.y.toInt() - 200) + 200;

      debugPrint('moveX: $moveX moveY: $moveY');

      FirecatPollutionEnemy pollutionEnemy = FirecatPollutionEnemy(
        position: Vector2(moveX.toDouble(), moveY.toDouble()),
        size: Vector2(150, 150),
        enemyId: i.toString(),
        imagePath: monsterImagePath,
        imageSize: Vector2(250.0, 250.0),
        spriteNum: 5,
        spriteSpeed: i % 3 == 0
            ? 0.2
            : i % 3 == 1
                ? 0.2
                : 0.08,
      );

      _hashMapEnemy[i.toString()] = pollutionEnemy;

      world.add(pollutionEnemy
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
          _hashMapEnemy.forEach((key, element) {
            element.move(Vector2(Random().nextInt(120) - 60.toDouble(),
                Random().nextInt(120) - 60.toDouble()));
          });
        }));
  }

  Future<void> delCUEnemy(String idEnemy) async {
    world.add(FirecatPollutionKilledEnemy(
        position: _hashMapEnemy[idEnemy]!.position,
        size: Vector2(150, 150),
        imagePath: killedMonsterImagePath));

    _hashMapEnemy.forEach((key, value) {
      if (key.compareTo(idEnemy) == 0) {
        world.remove(value);
      }
    });

    _hashMapEnemy.remove(idEnemy);
    _countEnemy = _hashMapEnemy.length;

    switch (_countEnemy) {
      case 15:
        debugPrint('countEnemy: $_countEnemy');
        for (var element in _cloudXLList) {
          world.remove(element);
        }

        break;
      case 10:
        for (var element in _cloudLList) {
          world.remove(element);
        }
        debugPrint('countEnemy: $_countEnemy');
        break;
      case 5:
        for (var element in _cloudMList) {
          world.remove(element);
        }
        debugPrint('countEnemy: $_countEnemy');
        break;
      case 0:
        for (var element in _cloudSList) {
          world.remove(element);
        }
        debugPrint('countEnemy: $_countEnemy');
    }
  }

  Future<void> initGun(Vector2 center, Vector2 direction) async {
    world.add(FirecatPollutionBullet(position: center, direction: direction));
  }
}

Widget gameFirecatPollutionMainBuilder(
    Vector2 viewMaxSize,
    String backgroundImagePath,
    String monsterImagePath,
    String killedMonsterImagePath) {
  return GameWidget(
    game: FirecatPollutionFlameMain(
        viewMaxSize: viewMaxSize,
        backgroundImagePath: backgroundImagePath,
        monsterImagePath: monsterImagePath,
        killedMonsterImagePath: killedMonsterImagePath),
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
