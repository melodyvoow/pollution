import 'package:flutter/material.dart';

class PollutionInputTitleDetailDialog extends StatefulWidget {
  const PollutionInputTitleDetailDialog(
      {super.key, required this.onRegister, required this.maxLine});
  final int maxLine;
  final Function(String title, String detail) onRegister;

  @override
  State<PollutionInputTitleDetailDialog> createState() =>
      _PollutionInputTitleDetailDialogState();
}

class _PollutionInputTitleDetailDialogState
    extends State<PollutionInputTitleDetailDialog> {
  String _eeTitle = '';
  String _eeDetail = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('제목과 내용을 입력하세요.'),
      content: Column(
        children: [
          SizedBox(
            width: 300,
            height: 50.0,
            child: TextField(
              controller: TextEditingController(),
              maxLines: widget.maxLine,
              onChanged: (String value) {
                _eeTitle = value;
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 300,
            height: 50.0 * widget.maxLine,
            child: TextField(
              controller: TextEditingController(),
              maxLines: widget.maxLine,
              onChanged: (String value) {
                _eeDetail = value;
              },
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          child: const Text('확인'),
          onPressed: () {
            widget.onRegister(_eeTitle, _eeDetail);
          },
        ),
        const SizedBox(
          width: 10,
        ),
        ElevatedButton(
          child: const Text('취소'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
