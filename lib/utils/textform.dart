import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_check/utils/colors.dart';

class MyTextForm extends StatelessWidget {
  const MyTextForm(
      {Key? key,
      required this.textController,
      required FocusNode node,
      this.type,
      this.labelText,
      this.hintText,
      this.header,
      this.area,
      this.readOnly = false,
      this.obscureText = false})
      : _node = node,
        super(key: key);

  final TextEditingController textController;
  final FocusNode _node;
  final TextInputType? type;
  final String? labelText;
  final String? hintText;
  final String? header;
  final bool obscureText;
  final bool readOnly;
  final int? area;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10.0,
        ),
        TextFormField(
          maxLines: area,
          controller: textController,
          focusNode: _node,
          readOnly: readOnly,
          textInputAction: TextInputAction.next,
          keyboardType: type,
          autocorrect: false,
          style: TextStyle(fontSize: 17.0, color: darkerPurple),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10.0),
            focusedBorder: UnderlineInputBorder(
              borderSide: const BorderSide(color: darkPink, width: 1),
            ),
            fillColor: Colors.white,
            filled: true,
            labelText: labelText,
            hintText: hintText,
            hintStyle: TextStyle(
              color: darkPurple.withOpacity(0.30),
              fontSize: 13.0,
            ),
            labelStyle: TextStyle(fontSize: 13.0, color: darkPink),
            enabledBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: darkerPurple.withOpacity(0.30), width: 0.0),
            ),
          ),
          obscureText: obscureText,
        ),
      ],
    );
  }
}

class MyTextForm2 extends StatelessWidget {
  const MyTextForm2(
      {Key? key,
      required this.textController,
      required FocusNode node,
      this.type,
      this.labelText,
      this.header,
      this.area,
      this.obscureText = false,
      this.prefix,
      this.suffix,
      this.hintText,
      this.fillColor = Colors.white,
      //this.onChanged,
      this.readOnly,
      this.height = 10.0,
      this.filterRegex = true})
      : _node = node,
        super(key: key);

  final TextEditingController textController;
  final FocusNode _node;
  final TextInputType? type;
  final String? labelText;
  final String? header;
  final bool obscureText;
  final int? area;
  final Widget? prefix;
  final Widget? suffix;
  final String? hintText;
  //final Function? onChanged;
  final bool? readOnly;
  final Color? fillColor;
  final bool? filterRegex;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height,
        ),
        TextFormField(
          readOnly: readOnly ?? false,
          maxLines: area,
          controller: textController,
          focusNode: _node,
          textInputAction: TextInputAction.next,
          // onChanged: (_) {
          //   onChanged!(_);
          // },
          keyboardType: type,
          autocorrect: false,
          style: TextStyle(
            fontSize: 17.0,
            color: darkerPurple,
          ),
          inputFormatters: filterRegex!
              ? [FilteringTextInputFormatter.deny(RegExp('[ ]'))]
              : [FilteringTextInputFormatter.deny(RegExp(''))],
          decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 6.0, vertical: 10.0),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: darkPink, width: 1),
              ),
              fillColor: fillColor,
              filled: true,
              hintText: hintText,
              hintStyle: TextStyle(
                color: darkPurple.withOpacity(0.3),
                fontSize: 13.0,
              ),
              labelText: labelText,
              labelStyle: TextStyle(
                  fontSize: 17.0,
                  color:
                      _node.hasFocus ? darkPink : darkPurple.withOpacity(0.3)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: darkerPurple.withOpacity(0.3), width: 0.0),
              ),
              suffixIcon: suffix ??
                  SizedBox(
                    height: 0,
                  ),
              prefix: prefix ??
                  SizedBox(
                    height: 0,
                  )),
          obscureText: obscureText,
        ),
      ],
    );
  }
}
