import 'package:flutter/material.dart';

class NumPadButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final bool haveBorder;
  final Function? onPressed;

  const NumPadButton(
      {Key? key, this.text, this.icon, this.haveBorder = true, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle buttonStyle =
        TextStyle(color: Colors.greenAccent, fontSize: 24, height: 1);

    Widget label = icon != null
        ? Icon(
            icon,
            color: Colors.greenAccent,
            size: 20.0,
          )
        : Text(
            text ?? '',
            style: buttonStyle,
          );
    return GestureDetector(
      onTap: () => onPressed?.call(),
      child: Container(
          height: 90,
          width: 90,
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: haveBorder
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.greenAccent),
                  )
                : null,
            child: Center(child: label),
          )),
    );
  }
}

class Dot extends StatelessWidget {
  final bool isActive;

  const Dot({Key? key, this.isActive = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Container(
        width: 15.0,
        height: 15.0,
        decoration: BoxDecoration(
          color: isActive ? Colors.greenAccent : Colors.transparent,
          border: Border.all(width: 1.0, color: Colors.greenAccent),
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}

class Preview extends StatelessWidget {
  final int length;
  final String text;

  const Preview({Key? key, required this.length, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> previewLength = [];
    for (var i = 0; i < length; i++) {
      previewLength.add(Dot(isActive: text.length >= i + 1));
    }
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Wrap(children: previewLength));
  }
}
