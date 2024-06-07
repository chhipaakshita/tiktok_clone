import 'package:flutter/material.dart';

class InputTextWidget extends StatelessWidget {
  const InputTextWidget({Key? key,
    required this.textEditingController,
    this.iconData,
    this.assetRefrence,
    required this.labelString,
    required this.isObscure}) : super(key: key);
final TextEditingController textEditingController;
final IconData? iconData;
final String? assetRefrence;
final String labelString;
final bool isObscure;



  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        labelText: labelString,
          prefixIcon : iconData! != null ? Icon(iconData)
          : Padding(
          padding: EdgeInsets.all(8),
          child:Image.asset(assetRefrence!,width:10)
      ),
        labelStyle: TextStyle(
            fontSize:18
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
                color : Colors.grey
            )
        ),
        focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
                color : Colors.grey
            )
        )
      ),
    obscureText: isObscure,
    );
  }
}
