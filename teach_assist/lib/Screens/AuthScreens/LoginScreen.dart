import 'package:flutter/material.dart';
import 'package:teach_assist/Utils/ThemeData/colors.dart';

import '../../Components/CustomButton.dart';
import '../../Components/CustomTextField.dart';
import '../../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    mq  = MediaQuery.of(context).size ;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.theme['offWhite'],
        body: Center(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: mq.width*.13),
            child: Container(
              height: 330,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.theme['green']?.withOpacity(0.04),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Text(
                    "L O G I N",
                    style: TextStyle(
                      color: AppColors.theme['green'],
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    hintText: 'Enter Username',
                    isNumber: false,
                    prefixicon: Icon(Icons.mail_lock_outlined),
                    obsecuretext: false,
                  ),
                  CustomTextField(
                    hintText: 'Enter Password',
                    isNumber: false,
                    prefixicon: Icon(Icons.password_outlined),
                    obsecuretext: true,
                    suffix: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.remove_red_eye),
                    ),
                  ),
                  SizedBox(height: 20),
                  AuthButton(
                    onpressed: () async {},
                    name: _isLoading ? 'Logining...' : "Login",
                    bcolor: AppColors.theme['green'],
                    tcolor: AppColors.theme['white'],
                    isLoading: _isLoading,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
