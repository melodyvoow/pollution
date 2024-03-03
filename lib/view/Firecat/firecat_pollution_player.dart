import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter/rendering.dart';

import 'firecat_pollution_main.dart';

class FirecatPollutionPlayer extends SpriteAnimationComponent
    with
        HasGameRef<FirecatPollutionFlameMain>,
        CollisionCallbacks,
        TapCallbacks {
  // @override
  // bool debugMode = true;

  FirecatPollutionPlayer({super.position}) : super(size: Vector2.all(60));

  String textNickName = "Nayon";
  String chatData = "";
  Vector2 geoPlayer = Vector2(0, 0);
  late TextComponent textNameComponent;
  late TextComponent textChatComponent;

  final _shaded = TextPaint(
    style: TextStyle(
      color: BasicPalette.white.color,
      fontSize: 12.0,
      fontFamily: 'Pretendard',
      shadows: const [
        Shadow(color: Colors.orange, offset: Offset(2, 2), blurRadius: 2),
        Shadow(color: Colors.blue, offset: Offset(4, 4), blurRadius: 4),
      ],
    ),
  );

  Future<void> _setTextPlayer(String textNickName) async {
    textNameComponent = TextComponent(text: textNickName, textRenderer: _shaded)
      ..anchor = Anchor.center
      ..position = Vector2(size.x / 2, size.y + 10);

    add(textNameComponent);

    textChatComponent = TextComponent(text: '', textRenderer: _shaded)
      ..anchor = Anchor.center
      ..position = Vector2(size.x / 2, -15);

    add(textChatComponent);
  }

  Future<void> _setCirclePlayer() async {
    add(CircleHitbox());
    add(
      CircleComponent(
        radius: size.x,
        position: size / 2,
        anchor: Anchor.center,
        paint: BasicPalette.cyan.paint()..style = PaintingStyle.fill,
      )..add(
          GlowEffect(
            20.0,
            EffectController(
              duration: 5,
              infinite: true,
            ),
          ),
        ),
    );
  }

  final random = Random();

  @override
  Future<void> onLoad() async {
    priority = 10;

    // sprite = await gameRef.loadSprite("lume_avatar.png");

    final image = await gameRef.loadSprite("mc_sprite.png");

    animation = SpriteAnimation.fromFrameData(
        image.image,
        SpriteAnimationData.sequenced(
          amount: 4,
          textureSize: Vector2(300, 300),
          stepTime: 2,
          loop: true,
        ));
  }

  static const gridSize = 5.0;
  Vector2 get cellSize => size / gridSize;
  final Random rnd = Random();

  Vector2 randomCellVector2() {
    return (Vector2.random() - Vector2.random())..multiply(cellSize);
  }

  T randomElement<T>(List<T> list) {
    return list[rnd.nextInt(list.length)];
  }

  Particle fireworkParticle() {
    // A palette to paint over the "sky"
    final paints = [
      Colors.amber,
      Colors.amberAccent,
      Colors.red,
      Colors.redAccent,
      Colors.yellow,
      Colors.yellowAccent,
      // Adds a nice "lense" tint
      // to overall effect
      Colors.blue,
    ].map((color) => Paint()..color = color).toList();

    return Particle.generate(
      generator: (i) {
        final initialSpeed = randomCellVector2();
        final deceleration = initialSpeed * -1;
        final gravity = Vector2(0, 40);

        return AcceleratedParticle(
          speed: initialSpeed,
          acceleration: deceleration + gravity,
          child: ComputedParticle(
            renderer: (canvas, particle) {
              final paint = randomElement(paints);
              // Override the color to dynamically update opacity
              paint.color = paint.color.withOpacity(1 - particle.progress);

              canvas.drawCircle(
                Offset.zero,
                // Closer to the end of lifespan particles
                // will turn into larger glaring circles
                rnd.nextDouble() * particle.progress > .6
                    ? rnd.nextDouble() * (50 * particle.progress)
                    : 2 + (3 * particle.progress),
                paint,
              );
            },
          ),
        );
      },
    );
  }

  @override
  void onLongTapDown(TapDownEvent event) {
    debugPrint("FirecatDspotPlayer : onLongTapDown ${event.localPosition}");
    return;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    add(
      ParticleSystemComponent(
        position: Vector2(size.x / 2, -20),
        particle: fireworkParticle(),
      ),
    );
  }
}
