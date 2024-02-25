// import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:pollution/view/component/pollution_colors.dart';

// class PollutionNavibar extends StatefulWidget {
//   const PollutionNavibar(
//       {super.key, required this.activeIndex, required this.onPress});

//   final int activeIndex;
//   final Function(int index) onPress;

//   @override
//   State<PollutionNavibar> createState() => _PollutionNavibarState();
// }

// class _PollutionNavibarState extends State<PollutionNavibar> {
//   final iconList = <IconData>[
//     Icons.format_list_bulleted,
//     Icons.forum,
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBottomNavigationBar(
//       icons: iconList,
//       activeIndex: widget.activeIndex,
//       leftCornerRadius: 0,
//       rightCornerRadius: 0,
//       gapLocation: GapLocation.center,
//       gapWidth: 0,
//       notchSmoothness: NotchSmoothness.defaultEdge,
//       activeColor: Colors.white,
//       inactiveColor: Colors.white.withOpacity(0.5),
//       backgroundColor: Color.fromARGB(255, 38, 45, 51),
//       elevation: 0,
//       onTap: (index) => setState(
//         () => widget.onPress(index),
//       ),
//       //other params
//     );
//   }
// }
