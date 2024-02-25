import 'package:flutter/material.dart';
import 'package:pollution/view/component/pollution_typography.dart';

class PollutionTextField extends StatefulWidget {
  const PollutionTextField({
    super.key,
    required this.widthField,
    required this.heightField,
    // required this.fillColor,
    required this.maxLines,
    required this.initialValue,
    required this.hintValue,
    // required this.textStyle,
    required this.onChanged,
  });

  final double widthField;
  final double heightField;
  // final Color fillColor;
  final int maxLines;
  final String initialValue;
  final String hintValue;
  // final TextStyle textStyle;

  final Function(String) onChanged;

  @override
  State<PollutionTextField> createState() => _PollutionTextFieldState();
}

class _PollutionTextFieldState extends State<PollutionTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.widthField,
      height: widget.heightField,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
      ),
      child: TextFormField(
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: widget.hintValue,
          hintStyle: PollutionTextStyle.g16_w400.copyWith(
            color: Colors.grey,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 10,
          ),
          fillColor: Colors.transparent,
          filled: true,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
          ),
        ),
        maxLines: null,
        minLines: 1,
        initialValue: widget.initialValue,
        style: PollutionTextStyle.g16_w400.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}

class PollutionTextBox extends StatefulWidget {
  const PollutionTextBox({
    super.key,
    required this.widthField,
    required this.heightField,
    required this.initialValue,
  });

  final double widthField;
  final double heightField;

  final String initialValue;

  @override
  State<PollutionTextBox> createState() => _PollutionTextBoxState();
}

class _PollutionTextBoxState extends State<PollutionTextBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.widthField,
      height: widget.heightField,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              widget.initialValue,
              softWrap: true,
              style: PollutionTextStyle.g16_w400.copyWith(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
