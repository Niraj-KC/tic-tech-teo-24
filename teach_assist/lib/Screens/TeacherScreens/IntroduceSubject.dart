import 'package:flutter/material.dart' ;
import 'package:provider/provider.dart';
import 'package:teach_assist/API/FireStoreAPIs/subjectServices.dart';
import 'package:teach_assist/API/FirebaseAPIs.dart';
import 'package:teach_assist/Components/CustomButton.dart';
import 'package:teach_assist/Components/CustomTextField.dart';
import 'package:teach_assist/Models/Subject.dart';
import 'package:teach_assist/Providers/CurrentUserProvider.dart';
import 'package:teach_assist/Screens/TeacherScreens/TeacherHomeScreen.dart';
import 'package:teach_assist/Transitions/RightToLeft.dart';
import 'package:teach_assist/Utils/HelperFunctions/HelperFunction.dart';
import 'package:teach_assist/Utils/ThemeData/colors.dart';

import '../../main.dart';

class Introducesubject extends StatefulWidget {
  const Introducesubject({super.key});

  @override
  State<Introducesubject> createState() => _IntroducesubjectState();
}

class _IntroducesubjectState extends State<Introducesubject> {

  TextEditingController _courseCodeController = TextEditingController() ;
  TextEditingController _nameController = TextEditingController() ;
  TextEditingController _departNameController = TextEditingController() ;

  bool _isLoading = false ;
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size ;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.theme['offWhite'],
        body: Consumer<CurrentUserProvider>(builder: (context, userProvider, child){
          return Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.0,vertical: mq.height*0.1),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  Center(child: Image.asset("assets/images/subject_introduce.png")) ,
                  Text("Introduce New Course",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
                  SizedBox(height: 10,),
                  CustomTextField(controller: _courseCodeController,hintText: "Enter course code", isNumber: false, obsecuretext: false,prefixicon: Icon(Icons.numbers_outlined),),
                  SizedBox(height: 10,),
                  CustomTextField(controller:_nameController,hintText: "Enter course name", isNumber: false, obsecuretext: false,prefixicon: Icon(Icons.drive_file_rename_outline),),
                  SizedBox(height: 10,),
                  CustomTextField(controller: _departNameController, hintText: "Enter course department name", isNumber: false, obsecuretext: false,prefixicon: Icon(Icons.drive_file_rename_outline_sharp),),
                  SizedBox(height: 50,),
                  AuthButton(onpressed: ()async{
                    Subject subject = Subject(
                        name: _nameController.text,
                        courseCode: _courseCodeController.text,
                        departmentId: _departNameController.text,
                        id: FirebaseAPIs.uuid.v1()
                    );
                    setState(() {
                      _isLoading = true;
                    });

                    final res = await SubjectService().addSubject(subject, userProvider.user);

                    setState(() {
                      _isLoading = false;
                    });

                    HelperFunction.showToast(res);
                    Navigator.pushReplacement(context, RightToLeft(TeacherHomeScreen())) ;

                  }, name: _isLoading ? "Registering..." : "Register", bcolor: AppColors.theme['green'], tcolor: AppColors.theme['white'], isLoading: _isLoading)

                ],
              ),
            ),
          );
        },)

      ),
    );
  }
}
