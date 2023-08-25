import 'package:flutter/material.dart';

class InputTextBox extends StatefulWidget {
  final String inputTextLabelValue;
  final String? inputTextValue;
  final Color? allColorAttributes;
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final bool? autocorrect;
  final bool? obscureTextEnabled;
  final bool? enabled;
  final TextInputType? keyboardType;
  const InputTextBox({
    Key? key,
    required this.inputTextLabelValue,
    this.inputTextValue,
    this.allColorAttributes,
    required this.onChanged,
    this.validator,
    this.autocorrect,
    this.obscureTextEnabled,
    this.enabled,
    this.keyboardType,
  }) : super(key: key);

  @override
  State<InputTextBox> createState() => _InputTextBoxState();
}

class _InputTextBoxState extends State<InputTextBox> {
  bool? obscureTextEnabled;
  @override
  void initState() {
    obscureTextEnabled = widget.obscureTextEnabled;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _toggleObscureText() {
      //* toggle
      setState(() {
        if (obscureTextEnabled == true)
          obscureTextEnabled = false;
        else
          obscureTextEnabled = true;
      });
    }

    return TextFormField(
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      cursorColor: widget.allColorAttributes ?? Colors.white,
      autocorrect: widget.autocorrect ?? false,
      enabled: widget.enabled ?? true,
      obscureText: obscureTextEnabled ?? false,
      initialValue: widget.inputTextValue,
      decoration: InputDecoration(
        labelText: widget.inputTextLabelValue,
        focusColor: widget.allColorAttributes ?? Colors.white,
        enabledBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: widget.allColorAttributes ?? Colors.white),
        ),
        suffixIcon: widget.obscureTextEnabled ?? false
            ? InkWell(
                onTap: _toggleObscureText,
                child: Icon(
                  obscureTextEnabled ?? false
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
              )
            : Ink(),
        // border: const OutlineInputBorder(
        //   borderRadius: BorderRadius.all(
        //     Radius.circular(11),
        //   ),
        //   borderSide: BorderSide(
        //     width: 5,
        //     color: Colors.white,
        //   ),
        // ),
        // //*TextField boder
        // enabledBorder: const OutlineInputBorder(
        //   borderRadius: BorderRadius.all(Radius.circular(5)),
        //   borderSide: BorderSide(
        //     color: Colors.white,
        //   ),
        // ),
        labelStyle: TextStyle(
          color: widget.allColorAttributes ?? Colors.white,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: widget.allColorAttributes ?? Colors.white,
          ),
        ),
      ),
      style: TextStyle(
        color: widget.allColorAttributes ?? Colors.white,
      ),
      onChanged: widget.onChanged,
    );
  }
}
