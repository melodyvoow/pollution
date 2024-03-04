// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'firecat_pollution_enemy.dart';
import 'firecat_pollution_main.dart';

class FirecatPollutionBullet extends SpriteComponent
    with HasGameRef<FirecatPollutionFlameMain>, CollisionCallbacks {
  FirecatPollutionBullet({super.position, super.size, required this.direction});

  late Vector2 direction;

  @override
  Future<void> onLoad() async {
    priority = 2;
    size = Vector2(20, 20);
    sprite = await gameRef.loadSprite("shoot_l.png");
    add(CircleHitbox());
    add(TimerComponent(
        period: 1.5,
        repeat: false,
        onTick: () {
          removeFromParent();
        }));
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.add(direction * dt * 300);
    return;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is FirecatPollutionEnemy) {
      FirecatPollutionEnemy pollutionEnemy = other;
      pollutionEnemy.attack();
      removeFromParent();
      return;
    }
    return;
  }
}
