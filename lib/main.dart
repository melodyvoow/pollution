import 'package:firebase_core/firebase_core.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:pollution/firebase_options.dart';

import 'view/Firecat/firecat_pollution_main.dart';

/*
flutter run --web-renderer html canvaskit --dart-define=FLUTTER_WEB_USE_SKIA=true

// firebase init
// flutter build web --web-renderer canvaskit --dart-define=FLUTTER_WEB_USE_SKIA=true

//  --disable-web-security.
 flutter run -d chrome --web-browser-flag "--disable-web-security"
// flutter build web --web-renderer  canvaskit --dart-define=FLUTTER_WEB_USE_SKIA=true --release
// firebase logout
// firebase login
  
// fluttercors --disable
// firebase deploy --only hosting:pollutions
*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pollution Blaster',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          primary: const Color(0xff1B2847),
          background: Colors.white,
        ),
        useMaterial3: true,
        //color for scrollbar
        scrollbarTheme: ScrollbarThemeData(
            thumbVisibility: MaterialStateProperty.all(true),
            thickness: MaterialStateProperty.all(10),
            thumbColor: MaterialStateProperty.all(
              Colors.black.withOpacity(0.3),
            ),
            radius: const Radius.circular(10),
            minThumbLength: 100),
      ),
      home: const MyHomePage(title: 'Pollution Blaster Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width;
    double y = MediaQuery.of(context).size.height;

    return Scaffold(
      body: gameFirecatPollutionMainBuilder(Vector2(x, y)),

      // PollutionIntroView(),
    );
  }
}
