import 'package:flutter/material.dart';
import 'package:pollution/view/component/pollution_button.dart';
import 'package:pollution/view/component/pollution_colors.dart';
import 'package:pollution/view/component/pollution_typography.dart';

class PollutionDialog extends StatefulWidget {
  const PollutionDialog(
      {super.key, required this.dialogText, required this.onConfirm});

  final String dialogText;
  final Function() onConfirm;

  @override
  State<PollutionDialog> createState() => _PollutionDialogState();
}

class _PollutionDialogState extends State<PollutionDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 680,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xff292A2D),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.dialogText,
            style: PollutionTextStyle.g16_w400.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PollutionButtonText(
                buttonWidth: 250,
                buttonHeight: 55,
                buttonText: '취소',
                buttonColor: Colors.white.withOpacity(0.1),
                borderRadius: 30,
                onPress: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                width: 16,
              ),
              PollutionButtonText(
                buttonWidth: 250,
                buttonHeight: 55,
                buttonText: '확인',
                buttonColor: PollutionColors.purple,
                borderRadius: 30,
                onPress: () {
                  widget.onConfirm();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PollutionDialogForm extends StatefulWidget {
  const PollutionDialogForm(
      {super.key,
      required this.dialogText,
      required this.onConfirm,
      required this.confirmText});

  final String dialogText;
  final String confirmText;
  final Function() onConfirm;

  @override
  State<PollutionDialogForm> createState() => _PollutionDialogFormState();
}

class _PollutionDialogFormState extends State<PollutionDialogForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 680,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xff292A2D),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.dialogText,
            style: PollutionTextStyle.g16_w400.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PollutionButtonText(
                buttonWidth: 250,
                buttonHeight: 55,
                buttonText: '취소',
                buttonColor: Colors.white.withOpacity(0.1),
                borderRadius: 30,
                onPress: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                width: 16,
              ),
              PollutionButtonText(
                buttonWidth: 250,
                buttonHeight: 55,
                buttonText: widget.confirmText,
                buttonColor: PollutionColors.purple,
                borderRadius: 30,
                onPress: () {
                  widget.onConfirm();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
