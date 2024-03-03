import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'firecat_pollution_main.dart';

class FirecatPollutionBackground extends SpriteComponent
    with HasGameRef<FirecatPollutionFlameMain> {
  @override
  Future<void> onLoad() async {
    sprite = await game.loadSprite('map_cleaned_city.jpg');
    Rectangle bounds = Rectangle.fromLTRB(0, 0, 2048, 2048);
    game.camera.setBounds(bounds);
    game.worldMaxSize = Vector2(2048, 2048);
    priority = 0;

    // for (int i = 1; i <= 11; i++) {
    //   add(FirecatPollutionPlace(linkCafe: '${'cafe_$i'}.png')
    //     ..anchor = Anchor.center
    //     ..position = Vector2(Random().nextInt(3000).toDouble(),
    //         Random().nextInt(1600).toDouble()));
    // }
  }
}

// class FirecatPollutionPlace extends SpriteComponent
//     with HasGameRef<FirecatPollutionFlameMain> {
//   FirecatPollutionPlace({required this.linkCafe});
//   Vector2 worldMaxSize = Vector2(0, 0);
//   String linkCafe;
//   @override
//   Future<void> onLoad() async {
//     sprite = await game.loadSprite(linkCafe);

//     add(FirecatPollutionLight()
//       ..anchor = Anchor.center
//       ..position = Vector2(50, 50));
//     priority = 10;
//   }
// }
