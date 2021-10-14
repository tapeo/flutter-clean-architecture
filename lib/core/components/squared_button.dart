import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/core/components/space.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/core/style/colors.dart';

class SquaredButton extends StatelessWidget {
  final Widget? leading;
  final String text;
  final Color? backgroundColor;
  final Function() click;

  const SquaredButton({
    Key? key,
    required this.text,
    required this.click,
    this.leading,
    this.backgroundColor = primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      child: InkWell(
        onTap: click,
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 60,
                child: Row(
                  children: [
                    _leading(),
                    Expanded(child: Builder(builder: (context) {
                      Color textColor =
                          backgroundColor!.computeLuminance() > 0.5
                              ? Colors.black
                              : Colors.white;

                      return Text(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: textColor,
                        ),
                      );
                    })),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _leading() {
    if (leading != null) {
      return Row(
        children: [
          leading!,
          const Space(),
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
