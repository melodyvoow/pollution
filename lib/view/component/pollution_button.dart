import 'package:flutter/material.dart';
import 'package:pollution/view/component/pollution_typography.dart';

class PollutionButton200 extends StatelessWidget {
  const PollutionButton200({
    super.key,
    required this.buttonText,
    required this.buttonColor,
    required this.onPress,
  });

  final String buttonText;
  final Color buttonColor;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: buttonColor,
        ),
        child: Center(
          child: Text(
            buttonText,
            style: PollutionTextStyle.g20_w400.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class PollutionButton extends StatelessWidget {
  const PollutionButton({
    super.key,
    required this.buttonWidth,
    required this.buttonHeight,
    required this.buttonColor,
    required this.borderRadius,
    required this.borderColor,
    required this.buttonText,
    required this.buttonTextStyle,
    required this.onPress,
  });

  final double buttonWidth;
  final double buttonHeight;
  final Color buttonColor;
  final double borderRadius;
  final Color borderColor;
  final String buttonText;
  final TextStyle buttonTextStyle;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPress();
      },
      child: Container(
        width: buttonWidth,
        height: buttonHeight,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: buttonTextStyle,
          ),
        ),
      ),
    );
  }
}

class PollutionButtonText extends StatelessWidget {
  const PollutionButtonText({
    super.key,
    required this.buttonWidth,
    required this.buttonHeight,
    required this.buttonText,
    required this.buttonColor,
    required this.borderRadius,
    required this.onPress,
  });

  final double buttonWidth;
  final double buttonHeight;
  final String buttonText;
  final Color buttonColor;
  final double borderRadius;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPress();
      },
      child: Container(
        width: buttonWidth,
        height: buttonHeight,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: PollutionTextStyle.g16_w400.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class PollutionButtonBorder extends StatelessWidget {
  const PollutionButtonBorder({
    super.key,
    required this.buttonWidth,
    required this.buttonHeight,
    required this.buttonColor,
    required this.borderColor,
    required this.borderRadius,
    required this.icon,
    required this.buttonText,
    required this.onPress,
  });

  final double buttonWidth;
  final double buttonHeight;
  final Color buttonColor;
  final Color borderColor;
  final double borderRadius;
  final IconData icon;
  final String buttonText;

  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Container(
        width: buttonWidth,
        height: buttonHeight,
        decoration: BoxDecoration(
          color: buttonColor,
          border: Border.all(
            color: borderColor,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                buttonText,
                style: PollutionTextStyle.g14_w400.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PollutionButtonCircle extends StatefulWidget {
  const PollutionButtonCircle({
    super.key,
    required this.icon,
    required this.onPress,
  });

  final IconData icon;
  final Function() onPress;

  @override
  State<PollutionButtonCircle> createState() => _PollutionButtonCircleState();
}

class _PollutionButtonCircleState extends State<PollutionButtonCircle> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onPress();
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.1),
        ),
        child: Center(
          child: Icon(
            widget.icon,
            size: 24,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class PollutionButtonOval extends StatefulWidget {
  const PollutionButtonOval({
    super.key,
    required this.onPress,
    required this.width,
    required this.height,
    required this.buttonRadius,
    required this.buttonColor,
    required this.icon,
    required this.iconSize,
    required this.iconColor,
    required this.buttonWidget,
  });

  final Function() onPress;
  final double width;
  final double height;
  final double buttonRadius;
  final Color buttonColor;
  final IconData icon;
  final double iconSize;
  final Color iconColor;
  final Widget buttonWidget;

  @override
  State<PollutionButtonOval> createState() => _PollutionButtonOvalState();
}

class _PollutionButtonOvalState extends State<PollutionButtonOval> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onPress();
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.buttonColor,
          borderRadius: BorderRadius.circular(widget.buttonRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.icon,
              size: widget.iconSize,
              color: widget.iconColor,
            ),
            const SizedBox(
              width: 4,
            ),
            widget.buttonWidget,
          ],
        ),
      ),
    );
  }
}
