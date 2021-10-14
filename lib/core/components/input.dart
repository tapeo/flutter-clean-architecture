import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/core/components/space.dart';
import 'package:flutter_clean_architecture_firebase_phone_auth/core/style/colors.dart';

class Input extends StatefulWidget {
  final String? label;
  final bool password;
  final Function(String)? change;
  final TextInputType textInputType;
  final TextEditingController? controller;
  final TextCapitalization? textCapitalization;
  final Widget? leading;
  final Widget? leadingFixed;
  final Widget? trailing;
  final bool enabled;
  final Function()? click;
  final Function()? clearClick;
  final Function(String)? onSubmitted;
  final bool bold;
  final bool useEnabledStyle;
  final FocusNode? focus;

  // ignore: use_key_in_widget_constructors
  const Input({
    this.label,
    this.change,
    this.password = false,
    this.textInputType = TextInputType.name,
    this.textCapitalization = TextCapitalization.none,
    this.controller,
    this.leading,
    this.leadingFixed,
    this.trailing,
    this.click,
    this.enabled = true,
    this.bold = false,
    this.useEnabledStyle = false,
    this.onSubmitted,
    this.clearClick,
    this.focus,
  });

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  final ValueNotifier<bool> showPassword = ValueNotifier(false);
  final ValueNotifier<bool> showClear = ValueNotifier(false);

  final TextEditingController defaultController = TextEditingController();

  Function()? listener;

  @override
  void initState() {
    if (widget.controller != null) {
      listener = () {
        if (widget.controller!.text.isEmpty) {
          showClear.value = false;
        } else {
          showClear.value = true;
        }
      };

      widget.controller!.addListener(listener!);
    }
    super.initState();
  }

  @override
  void dispose() {
    if (widget.controller != null) {
      widget.controller!.removeListener(listener!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          _buildLeading(),
          _buildLeadingFixed(context),
          Expanded(
            child: InkWell(
              onTap: widget.click,
              child: ValueListenableBuilder(
                valueListenable: showPassword,
                builder: (context, bool showPasswordValue, child) => TextField(
                  controller: widget.controller ?? defaultController,
                  focusNode: widget.focus,
                  enabled: widget.enabled,
                  textAlignVertical: TextAlignVertical.center,
                  obscureText: widget.password && !showPasswordValue,
                  keyboardType: widget.textInputType,
                  textCapitalization: widget.textCapitalization!,
                  style: TextStyle(
                      fontWeight:
                          widget.bold ? FontWeight.bold : FontWeight.normal),
                  onChanged: (value) {
                    if (widget.change != null) widget.change!(value);

                    if (value.isEmpty) {
                      showClear.value = false;
                    } else {
                      showClear.value = true;
                    }
                  },
                  onSubmitted: widget.onSubmitted,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primary),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primary),
                    ),

                    // border: InputBorder.(borderSide: BorderSide(color: primary)),
                    labelText: widget.label,
                    labelStyle: TextStyle(
                      color: primary,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),
          _buildTrailing(),
          _buildClear(),
          showPasswordIcon(),
        ],
      ),
    );
  }

  Widget _buildLeading() {
    if (widget.leading == null) return Container();

    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: widget.leading!,
    );
  }

  Widget _buildClear() {
    return ValueListenableBuilder<bool>(
      valueListenable: showClear,
      builder: (context, value, child) => Visibility(
        visible: value,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                widget.controller?.text = "";
                defaultController.text = "";

                showClear.value = false;

                if (widget.clearClick != null) {
                  widget.clearClick!();
                }
              },
              child: Icon(Icons.close, size: 18),
            ),
            Space(),
          ],
        ),
      ),
    );
  }

  Widget _buildLeadingFixed(BuildContext context) {
    if (widget.leadingFixed == null) return Container();

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: widget.leadingFixed!,
        ),
        Container(
          width: 1,
          color: Theme.of(context).dividerColor,
        )
      ],
    );
  }

  Widget _buildTrailing() {
    if (widget.trailing == null) return Container();

    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: widget.trailing!,
    );
  }

  Widget showPasswordIcon() {
    if (!widget.password) return Container();

    return IconButton(
      icon: Image.asset(
          "assets/graphics/login/see-password-icon/see-password-icon@2x.png"),
      onPressed: () {
        showPassword.value = !showPassword.value;
      },
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
