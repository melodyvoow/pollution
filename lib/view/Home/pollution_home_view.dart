import 'package:flutter/material.dart';
import 'package:pollution/view/Home/component/pollution_home_card.dart';
import 'package:pollution/view/World/pollution_world_view.dart';

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
    "Mirageflame City",
    "Duskhaven Capital",
    "Starlight Basin",
    "Frostfire Borough",
    "Sunfade City",
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
            height: width,
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(4),
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
                          _viewCharacterDetail(index);
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
