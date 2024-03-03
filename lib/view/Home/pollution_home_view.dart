import 'package:flutter/material.dart';
import 'package:pollution/view/Home/component/pollution_home_card.dart';
import 'package:pollution/view/World/pollution_world_view.dart';
import 'package:pollution/view/component/pollution_colors.dart';
import 'package:pollution/view/component/pollution_typography.dart';

class PollutionHomeView extends StatefulWidget {
  const PollutionHomeView({super.key});

  @override
  State<PollutionHomeView> createState() => _PollutionHomeViewState();
}

class _PollutionHomeViewState extends State<PollutionHomeView> {
  List<String> cityTitle = [
    "Neonshadow Harbor",
    "Silentpeak Valley",
    "Twilightforge Metropolis",
    "Echofall Enclave",
  ];

  List<String> gridImage = [
    "assets/images/grid_1.png",
    "assets/images/grid_2.png",
    "assets/images/grid_3.png",
    "assets/images/grid_4.png",
  ];

  void _makeNewCharacter() {}

  void _viewCharacterDetail(index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PollutionWorldView(
          appBarTitle: cityTitle.elementAt(index),
        ),
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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/pollution_bg.jpeg',
            ),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Center(
          child: SizedBox(
            width: width,
            height: height,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 40,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Center(
                    child: Stack(
                      children: <Widget>[
                        // Stroked text
                        Text(
                          'POLLUTION\nBLASTER',
                          textAlign: TextAlign.center,
                          style: PollutionTextStyle.g40_w700.copyWith(
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 2
                              ..color = PollutionColors.black,
                          ),
                        ),
                        // Solid text
                        Text(
                          'POLLUTION\nBLASTER',
                          textAlign: TextAlign.center,
                          style: PollutionTextStyle.g40_w700.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 16,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Text(
                    'Make Clean Each Maps\nwith Earth Protector',
                    textAlign: TextAlign.center,
                    style: PollutionTextStyle.g14_w700.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 16,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Image.asset(
                    'assets/images/mc_home.png',
                    height: 150,
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(1),
                  sliver: SliverGrid.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      // crossAxisSpacing: 1,
                      // mainAxisSpacing: 1,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return PollutionHomeCard(
                        onPress: () {
                          _viewCharacterDetail(index);
                        },
                        gridImage: gridImage.elementAt(index),
                      );
                    },
                    itemCount: 4,
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
