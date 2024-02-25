import 'package:flutter/material.dart';
import 'package:pollution/view/component/pollution_button.dart';
import 'package:pollution/view/component/pollution_colors.dart';
import 'package:pollution/view/component/pollution_typography.dart';

class PollutionInputDialog extends StatefulWidget {
  const PollutionInputDialog(
      {super.key,
      required this.onRegister,
      required this.initialText,
      required this.hintText,
      required this.maxLine});

  final String initialText;
  final String hintText;
  final int maxLine;
  final Function(String) onRegister;

  @override
  State<PollutionInputDialog> createState() => _PollutionInputDialogState();
}

class _PollutionInputDialogState extends State<PollutionInputDialog> {
  String _message = '';

  @override
  void initState() {
    // TODO: implement initState
    _message = widget.initialText;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 680,
        height: widget.maxLine * 50 + 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xff292A2D),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '내용을 입력하세요.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: TextEditingController(text: widget.initialText),
                maxLines: widget.maxLine,
                onChanged: (String value) {
                  _message = value;
                },
                // initialValue: widget.initialText,
                style: PollutionTextStyle.g16_w400.copyWith(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: PollutionTextStyle.g16_w400.copyWith(
                    color: Colors.white,
                  ),
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
                    buttonText: '등록',
                    buttonColor: PollutionColors.purple,
                    borderRadius: 30,
                    onPress: () {
                      widget.onRegister(_message);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
