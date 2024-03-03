import 'package:flutter/material.dart';
import 'package:pollution/view/component/pollution_typography.dart';

class PollutionHomeCard extends StatefulWidget {
  const PollutionHomeCard(
      {super.key, required this.onPress, required this.gridImage});

  final Function() onPress;
  final String gridImage;

  @override
  State<PollutionHomeCard> createState() => _PollutionHomeCardState();
}

class _PollutionHomeCardState extends State<PollutionHomeCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onPress();
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 1 / 3,
        height: MediaQuery.of(context).size.width * 1 / 3,
        decoration: BoxDecoration(
          // color: Colors.white.withOpacity(0.1),
          image: DecorationImage(
            image: AssetImage(
              widget.gridImage,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            '',
            style: PollutionTextStyle.p14_w400.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
