import 'package:flutter/material.dart';
import 'package:pollution/view/Firecat/firecat_pollution_main.dart';
import 'package:flame/components.dart';
import 'package:pollution/view/component/pollution_appbar.dart';
import 'package:pollution/view/component/pollution_colors.dart';
import 'package:pollution/view/component/pollution_typography.dart';

class PollutionWorldView extends StatefulWidget {
  const PollutionWorldView(
      {super.key,
      required this.appBarTitle,
      required this.backgroundImagePath,
      required this.monsterImagePath,
      required this.killedMonsterImagePath});

  final String appBarTitle;
  final String backgroundImagePath;
  final String monsterImagePath;
  final String killedMonsterImagePath;

  @override
  State<PollutionWorldView> createState() => _PollutionWorldViewState();
}

class _PollutionWorldViewState extends State<PollutionWorldView> {
  Widget _buildBanner() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 56,
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 16,
          ),
          const Icon(
            Icons.campaign,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(
            width: 8,
          ),
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (bounds) => const LinearGradient(
              colors: [
                Color(0xffFF99B8),
                Color(0xff9FE8FF),
                Color(0xffFF99B8),
              ],
              stops: [0.1, 0.5, 0.99],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ).createShader(bounds),
            child: const Text('Kill the Monster as Many as Possible',
                style: PollutionTextStyle.p16_w700),
          ),
        ],
      ),
    );
  }

  Widget _buildTimer(displayTime) {
    return Stack(
      children: <Widget>[
        // Stroked text
        Text(
          displayTime,
          style: PollutionTextStyle.p32_w700.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 2
              ..color = PollutionColors.purple,
          ),
        ),
        // Solid text
        Text(
          displayTime,
          style: PollutionTextStyle.p32_w700.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildCount() {
    return Container(
      width: 100,
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.black.withOpacity(0.2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Monster : ',
            style: PollutionTextStyle.p16_w400.copyWith(
              color: Colors.white,
            ),
          ),
          Text(
            '23',
            style: PollutionTextStyle.p16_w400.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width;
    double y = MediaQuery.of(context).size.height;
    //String displayTime = '03:00';

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PollutionAppbarBackground(
        appBarActions: const [],
        appBarTitle: widget.appBarTitle,
        appBarHeight: 56,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.blueGrey.withOpacity(0.3),
        ),
        child: Stack(
          children: [
            gameFirecatPollutionMainBuilder(
                Vector2(x, y),
                widget.backgroundImagePath,
                widget.monsterImagePath,
                widget.killedMonsterImagePath),
            Positioned(
              top: 56,
              child: _buildBanner(),
            ),
            // Positioned(
            //   top: 120,
            //   left: 16,
            //   child: _buildTimer(displayTime),
            // ),
            // Positioned(
            //   top: 130,
            //   right: 16,
            //   child: _buildCount(),
            // ),
          ],
        ),
      ),
    );
  }
}
