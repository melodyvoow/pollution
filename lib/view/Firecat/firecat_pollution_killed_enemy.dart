// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'firecat_pollution_main.dart';

class FirecatPollutionKilledEnemy extends SpriteAnimationComponent
    with HasGameRef<FirecatPollutionFlameMain>, TapCallbacks {
  FirecatPollutionKilledEnemy({
    super.position,
    super.size,
    required this.imagePath,
  });

  String imagePath;
  bool isCoin = false;
  @override
  Future<void> onLoad() async {
    priority = 2;

    final image = gameRef.images.fromCache(imagePath);
    animation = SpriteAnimation.fromFrameData(
        image,
        SpriteAnimationData.sequenced(
          amount: 2,
          textureSize: Vector2(200, 200),
          stepTime: 0.4,
        ));

    add(CircleHitbox());

    add(TimerComponent(
        period: 1.5,
        repeat: false,
        onTick: () {
          //        removeFromParent();
          isCoin = true;
          final image = gameRef.images.fromCache('coin.png');
          size = Vector2(80, 80);
          animation = SpriteAnimation.fromFrameData(
              image,
              SpriteAnimationData.sequenced(
                amount: 5,
                textureSize: Vector2(150, 150),
                stepTime: 0.2,
              ));
        }));
  }

  // 170 * 5

  bool getCoin() {
    if (isCoin) {
      removeFromParent();
      return true;
    }
    return false;
  }

  @override
  void update(double dt) {
    super.update(dt);
    return;
  }
}
