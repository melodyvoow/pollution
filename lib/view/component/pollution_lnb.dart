import 'package:flutter/material.dart';
import 'package:pollution/view/component/pollution_typography.dart';

class PollutionLNB extends StatefulWidget {
  const PollutionLNB({
    super.key,
    required this.activeIndex,
    required this.onPress,
  });

  final int activeIndex;
  final Function(int index) onPress;

  @override
  State<PollutionLNB> createState() => _PollutionLNBState();
}

class _PollutionLNBState extends State<PollutionLNB> {
  bool isSelect = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: MediaQuery.of(context).size.height,
      color: const Color(0xff171D22),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            // Row(
            //   children: [
            //     const CircleAvatar(
            //       backgroundImage: AssetImage(
            //         'assets/images/Pollutionavatar.png',
            //       ),
            //       radius: 20,
            //     ),
            //     const SizedBox(
            //       width: 12,
            //     ),
            //     Text(
            //       '사용자아이디',
            //       style: PollutionTextStyle.p14_SemiBold.copyWith(
            //         color: Colors.white,
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(
            //   height: 32,
            // ),
            InkWell(
              onTap: () {
                widget.onPress(0);
                setState(() {});
              },
              child: Container(
                width: 270,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: widget.activeIndex == 0
                      ? Colors.white.withOpacity(0.1)
                      : Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    '학습 자료(벡터DB) 리스트',
                    style: PollutionTextStyle.g16_w400.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                widget.onPress(1);
                setState(() {});
              },
              child: Container(
                width: 270,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: widget.activeIndex == 1
                      ? Colors.white.withOpacity(0.1)
                      : Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    '대화 내역 리스트',
                    style: PollutionTextStyle.g16_w400.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                widget.onPress(2);
                setState(() {});
              },
              child: Container(
                width: 270,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: widget.activeIndex == 2
                      ? Colors.white.withOpacity(0.1)
                      : Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    '라이브러리',
                    style: PollutionTextStyle.g16_w400.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
