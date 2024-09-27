import 'package:flutter/material.dart';

import '../Utils/ThemeData/colors.dart';

class CustomTextField extends StatelessWidget {

  final String hintText;
  final TextEditingController? controller;
  final bool isNumber;
  final FormFieldValidator<String>? validator;
  final String? initialText;
  final Icon prefixicon;
  final bool obsecuretext;
  final IconButton? suffix;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChange;

  const CustomTextField({
    Key? key,
    required this.hintText,
    this.controller,
    required this.isNumber,
    this.validator,
    this.initialText,
    this.onSaved,
    required this.prefixicon,
    required this.obsecuretext,
    this.suffix, this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
      child: Center(
        child: TextFormField(
          cursorColor: AppColors.theme['white'],
          onSaved: onSaved,
          onChanged: onChange,
          obscureText: obsecuretext,
          initialValue: initialText,
          keyboardType: isNumber ? TextInputType.number : TextInputType.emailAddress,
          controller: controller,
          decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.theme['white'],
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.theme['white']),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.theme['white'] ),
                borderRadius: BorderRadius.circular(10),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.theme['green'] ),
                borderRadius: BorderRadius.circular(10),
              ),

              hintText: hintText,
              hintStyle: TextStyle(color: AppColors.theme['black'].withOpacity(0.5),fontSize: 14),
              prefixIcon: prefixicon,
              prefixIconColor: AppColors.theme['black'].withOpacity(0.5),
              suffixIcon: suffix,
              suffixIconColor:AppColors.theme['black'].withOpacity(0.5)
          ),
          validator: validator,
        ),
      ),
    );
  }
}