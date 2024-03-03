import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart' hide Route;

import 'firecat_pollution_background.dart';
import 'firecat_pollution_player.dart';

class FirecatPollutionFlameMain extends FlameGame
    with HasCollisionDetection, ScrollDetector, ScaleDetector {
  FirecatPollutionFlameMain({required this.viewMaxSize});
  Vector2 worldMaxSize = Vector2(2048, 2048);
  Vector2 viewMaxSize;
  FirecatPollutionPlayer player = FirecatPollutionPlayer();

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
  Future<void> onLoad() async {
    super.onLoad();

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
      ..position = Vector2(50, 50));

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
  }
}

Widget gameFirecatPollutionMainBuilder(Vector2 viewMaxSize) {
  return GameWidget(
    game: FirecatPollutionFlameMain(viewMaxSize: viewMaxSize),
    overlayBuilderMap: {
      'OpenChat': (context, game) {
        return Positioned(
          bottom: 0,
          left: 0,
          width: 400,
          height: 400,
          child: Text('OpenChat'),
        );
      },
      'CloseChat': (context, game) {
        return Positioned(
          bottom: 0,
          left: 0,
          width: 400,
          height: 50,
          child: Text('CloseChat'),
        );
      },
    },
  );
}
