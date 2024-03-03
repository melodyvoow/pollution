import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pollution/view/Home/pollution_home_view.dart';
import 'package:pollution/view/component/pollution_button.dart';
import 'package:pollution/view/component/pollution_typography.dart';

class PollutionIntroView extends StatefulWidget {
  const PollutionIntroView({super.key});

  @override
  State<PollutionIntroView> createState() => _PollutionIntroViewState();
}

class _PollutionIntroViewState extends State<PollutionIntroView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/map_destroyed_forest.jpg',
            ),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'POLLUTION\nBLASTER',
                textAlign: TextAlign.center,
                style: PollutionTextStyle.g40_w700.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              PollutionButton(
                buttonWidth: MediaQuery.of(context).size.width * 0.8,
                buttonHeight: 70,
                buttonColor: Theme.of(context).colorScheme.primary,
                borderRadius: 40,
                borderColor: Colors.transparent,
                buttonText: 'GAME START',
                buttonTextStyle: PollutionTextStyle.p18_w700.copyWith(
                  color: Colors.white,
                ),
                onPress: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 650),
                      pageBuilder: (context, animation, _) {
                        return FadeTransition(
                          opacity: animation,
                          child: const PollutionHomeView(),
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
