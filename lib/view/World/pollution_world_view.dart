import 'package:flutter/material.dart';
import 'package:pollution/view/component/pollution_appbar.dart';

class PollutionWorldView extends StatefulWidget {
  const PollutionWorldView({super.key});

  @override
  State<PollutionWorldView> createState() => _PollutionWorldViewState();
}

class _PollutionWorldViewState extends State<PollutionWorldView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PollutionAppbarBackground(
        appBarActions: [],
        appBarTitle: 'Pollution',
        appBarHeight: 60,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.background,
              Theme.of(context).colorScheme.onBackground,
            ],
            stops: const [0.1, 0.6],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(),
            Card(),
          ],
        ),
      ),
    );
  }
}
