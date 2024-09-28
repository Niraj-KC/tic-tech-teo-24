import 'package:flutter/material.dart' ;
import 'package:teach_assist/Components/CustomButton.dart';
import 'package:teach_assist/Components/CustomTextField.dart';
import 'package:teach_assist/Utils/ThemeData/colors.dart';

class Introducesubject extends StatefulWidget {
  const Introducesubject({super.key});

  @override
  State<Introducesubject> createState() => _IntroducesubjectState();
}

class _IntroducesubjectState extends State<Introducesubject> {

  TextEditingController _codeController = TextEditingController() ;
  TextEditingController _nameController = TextEditingController() ;
  TextEditingController _depnameControlle = TextEditingController() ;

  final bool _isLoading = false ;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.theme['offWhite'],
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height: 50,),
              Center(child: Image.asset("assets/images/subject_introduce.png")) ,
              Text("Introduce new course",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),),
              SizedBox(height: 10,),
              CustomTextField(hintText: "Enter course code", isNumber: false, obsecuretext: false,prefixicon: Icon(Icons.numbers_outlined),),
              SizedBox(height: 10,),
              CustomTextField(hintText: "Enter course name", isNumber: false, obsecuretext: false,prefixicon: Icon(Icons.drive_file_rename_outline),),
              SizedBox(height: 10,),
              CustomTextField(hintText: "Enter course department name", isNumber: false, obsecuretext: false,prefixicon: Icon(Icons.drive_file_rename_outline_sharp),),
              SizedBox(height: 50,),
              AuthButton(onpressed: ()async{}, name: _isLoading ? "Registering..." : "Register", bcolor: AppColors.theme['green'], tcolor: AppColors.theme['white'], isLoading: _isLoading)

            ],
          ),
        ),

      ),
    );
  }
}
