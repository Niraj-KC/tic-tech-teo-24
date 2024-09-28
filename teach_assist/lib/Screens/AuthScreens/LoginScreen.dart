import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teach_assist/API/FirebaseAuthentication/AppFirebaseAuth.dart';
import 'package:teach_assist/Models/Student.dart';
import 'package:teach_assist/Models/Teacher.dart';
import 'package:teach_assist/Providers/CurrentUserProvider.dart';
import 'package:teach_assist/Screens/StudentScreens/StudentHomeScreen.dart';
import 'package:teach_assist/Screens/TeacherScreens/TeacherHomeScreen.dart';
import 'package:teach_assist/Transitions/LeftToRight.dart';
import 'package:teach_assist/Utils/HelperFunctions/HelperFunction.dart';
import 'package:teach_assist/Screens/StudentScreens/StudentHomeScreen.dart';
import 'package:teach_assist/Transitions/LeftToRight.dart';
import 'package:teach_assist/Utils/ThemeData/colors.dart';

import '../../Components/CustomButton.dart';
import '../../Components/CustomTextField.dart';
import '../../main.dart';
import '../TeacherScreens/TeacherHomeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  TextEditingController _usernameController = TextEditingController(text: "22bce197@abc.com");
  TextEditingController _passwordController = TextEditingController(text: "12345678");

  // Checkbox state
  bool _isStudent = false;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.theme['offWhite'],
        body: Consumer<CurrentUserProvider>(builder: (context, userProvider, child){
          return Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: mq.width * .13),
              child: Container(
                height: 400, // Adjusted height to fit checkbox
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
                      controller: _usernameController,
                    ),
                    CustomTextField(
                      hintText: 'Enter Password',
                      isNumber: false,
                      prefixicon: Icon(Icons.password_outlined),
                      obsecuretext: true,
                      controller: _passwordController,
                      suffix: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.remove_red_eye),
                      ),
                    ),
                    SizedBox(height: 10),
                    // Checkbox for "Student"
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            activeColor: AppColors.theme['green'],
                            value: _isStudent,
                            onChanged: (bool? newValue) {
                              setState(() {
                                _isStudent = newValue ?? false;
                              });
                            },
                          ),
                          Text("Login as Student",style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    AuthButton(
                      onpressed: () async {

                        // Log in  details
                        print('Username: ${_usernameController.text}');
                        print('Password: ${_passwordController.text}');
                        print('Student: ${_isStudent ? "Yes" : "No"}');
                        setState(() {
                          _isLoading = true;
                        });
                        dynamic res = await AppFirebaseAuth.signIn(_usernameController.text, _passwordController.text, _isStudent);
                        print("#res-type ${res.runtimeType}");
                        if(res.runtimeType == Teacher){
                          print("Navigating to teacher home page: uid : ${res.id}");
                          userProvider.setCurrent(res, false);
                          HelperFunction.showToast("Successfully login");
                          Navigator.pushReplacement(context, LeftToRight(TeacherHomeScreen()));
                        }
                        else if(res.runtimeType == Student){
                          print("Navigating to student home page");
                          userProvider.setCurrent(res, true);
                          HelperFunction.showToast("Successfully login");
                          Navigator.pushReplacement(context, LeftToRight(StudentHomeScreen())) ;
                        }
                        else{
                          print("Error: $res");
                          HelperFunction.showToast(res);
                        }

                        setState(() {
                          _isLoading = false;
                        });
                      },
                      name: _isLoading ? 'Logging in...' : "Login",
                      bcolor: AppColors.theme['green'],
                      tcolor: AppColors.theme['white'],
                      isLoading: _isLoading,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },)
      ),
    );
  }
}
