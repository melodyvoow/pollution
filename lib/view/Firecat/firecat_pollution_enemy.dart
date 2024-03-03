// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import 'package:flame/events.dart';
import 'package:flame/particles.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/painting.dart';

import 'firecat_pollution_main.dart';

class FirecatPollutionEnemy extends SpriteAnimationComponent
    with HasGameRef<FirecatPollutionFlameMain>, TapCallbacks {
  FirecatPollutionEnemy(
      {super.position,
      super.size,
      required this.enemyId,
      required this.imagePath,
      required this.imageSize,
      required this.spriteNum,
      required this.spriteSpeed});

  String enemyId;
  String imagePath;
  Vector2 imageSize;
  int spriteNum;
  double spriteSpeed;
  late Vector2 _dest;
  double _speedX = 0;
  double _speedY = 0;
  int energy = 5;

  late final SpriteAnimation _runAnimation;
  late RectangleComponent enegyComponent;

  Future<void> _setTextCrew() async {
    enegyComponent = RectangleComponent(
        size: Vector2(size.x / 2, 10),
        position: Vector2(size.x / 4, -5),
        anchor: Anchor.topLeft,
        paint: Paint()
          ..shader = const LinearGradient(
            colors: [
              Color(0xffFF557E),
              Color(0xff8583E8),
            ],
            stops: [0.2, 1.0],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(Rect.fromLTWH(0, 0, size.x / 3, 10))
          ..style = PaintingStyle.fill
        //paint: BasicPalette.orange.paint()..style = PaintingStyle.fill,
        );

    add(enegyComponent);
  }

  @override
  Future<void> onLoad() async {
    priority = 2;

    _dest = Vector2(0, 0);

    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load(imagePath),
      srcSize: imageSize,
    );

    _runAnimation = spriteSheet.createAnimation(
      row: 0,
      stepTime: 0.2,
      to: spriteNum,
    );

    animation = _runAnimation;

    add(CircleHitbox());

    _setTextCrew();
  }

  @override
  void update(double dt) {
    super.update(dt);

    // if (_speedX > 0) {
    //   if (position.x + _speedX > _dest.x) {
    //     position.x = _dest.x;
    //   } else {
    //     position.add(Vector2(_speedX, 0));
    //   }
    //   animation = _runLeftAnimation;
    // } else {
    //   if (position.x + _speedX < _dest.x) {
    //     position.x = _dest.x;
    //   } else {
    //     position.add(Vector2(_speedX, 0));
    //   }
    //   animation = _runRightAnimation;
    // }

    if (_speedY > 0) {
      if (position.y + _speedY > _dest.y) {
        position.y = _dest.y;
      } else {
        position.add(Vector2(0, _speedY));
      }
    } else {
      if (position.y + _speedY < _dest.y) {
        position.y = _dest.y;
      } else {
        position.add(Vector2(0, _speedY));
      }
    }
  }

  void move(Vector2 delta) {
    _dest.x = position.x + delta.x;
    _speedX = delta.x / 10;
    _dest.y = position.y + delta.y;
    _speedY = delta.y / 10;

    if (_dest.x < 50) {
      _dest.x = 50;
    }

    if (_dest.x > (gameRef.worldMaxSize.x - size.x).toInt()) {
      _dest.x = gameRef.worldMaxSize.x - size.x * 2;
    }

    if (_dest.y < 150) {
      _dest.y = 150;
    }

    if (_dest.y > (gameRef.worldMaxSize.y - size.y).toInt()) {
      _dest.y = gameRef.worldMaxSize.y - size.y * 2;
    }
  }

  void attack() {
    energy--;

    enegyComponent.size = Vector2(size.x / 2 * (energy / 5), 10);
    if (energy < 0) {
      gameRef.delCUEnemy(enemyId);

      return;
    }
    add(
      // Bind all the particles to a [Component] update
      // lifecycle from the [FlameGame].
      ParticleSystemComponent(
        size: Vector2(400, 400),
        particle: TranslatedParticle(
          lifespan: 0.8,
          offset: size / 2,
          child: SpriteAnimationParticle(
            animation: getBoomAnimation(),
            size: Vector2(128, 128),
          ),
        ),
      ),
    );
  }

  @override
  void onTapDown(TapDownEvent event) {
    double distance = event.parentContext!
        .distanceTo(gameRef.player.position + gameRef.player.size / 2);

    if (distance > 120) {
      return;
    }
  }

  SpriteAnimation getBoomAnimation() {
    const columns = 8;
    const rows = 8;
    const frames = columns * rows;
    final spriteImage = gameRef.images.fromCache('boom.png');
    final spritesheet = SpriteSheet.fromColumnsAndRows(
      image: spriteImage,
      columns: columns,
      rows: rows,
    );
    final sprites = List<Sprite>.generate(frames, spritesheet.getSpriteById);
    return SpriteAnimation.spriteList(sprites, stepTime: 0.1);
  }
}
