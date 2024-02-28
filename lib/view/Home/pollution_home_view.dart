import 'package:flutter/material.dart';
import 'package:pollution/view/Home/component/pollution_home_card.dart';
import 'package:pollution/view/Home/pollution_home_detail_view.dart';
import 'package:pollution/view/World/pollution_world_view.dart';
import 'package:pollution/view/component/pollution_button.dart';
import 'package:pollution/view/component/pollution_colors.dart';
import 'package:pollution/view/component/pollution_input_dialog.dart';
import 'package:pollution/view/component/pollution_typography.dart';

class PollutionHomeView extends StatefulWidget {
  const PollutionHomeView({super.key});

  @override
  State<PollutionHomeView> createState() => _PollutionHomeViewState();
}

class _PollutionHomeViewState extends State<PollutionHomeView> {
  void _makeNewCharacter() {}

  void _viewCharacterDetail() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PollutionWorldView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/pollution_bg.jpeg',
            ),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Center(
          child: Container(
            width: width,
            height: width,
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.all(4),
                  sliver: SliverGrid.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 1,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return PollutionHomeCard(
                        onPress: () {
                          _viewCharacterDetail();
                        },
                      );
                    },
                    itemCount: 9,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
