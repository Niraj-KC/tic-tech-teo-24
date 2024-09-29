import 'package:flutter/material.dart';
import 'package:teach_assist/Components/CustomButton.dart';
import 'package:teach_assist/Components/CustomTextField.dart';

import '../../../Utils/ThemeData/colors.dart';

class GenerateAttendanceLink extends StatefulWidget {
  const GenerateAttendanceLink({super.key});

  @override
  State<GenerateAttendanceLink> createState() => _GenerateAttendanceLinkState();
}

class _GenerateAttendanceLinkState extends State<GenerateAttendanceLink> {
  TextEditingController _subController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  String? _selectedRoom;
  TextEditingController _totalHoursController = TextEditingController();
  TextEditingController _startTimeController = TextEditingController();


  //todo :this is stndard classroom having noted coordinates

  final List<String> _roomNumbers = [
    'Room 101',
    'Room 102',
    'Room 103',
    'Room 104',
    'Room 105',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.theme['offWhite'],
        appBar: AppBar(
          backgroundColor: AppColors.theme['green'],
          title: Text(
            "Class Info",
            style: TextStyle(
                color: AppColors.theme['white'],
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                  child: Text(
                    "Details For Today's Class",
                    style: TextStyle(
                        color: AppColors.theme['black'],
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10,),
                CustomTextField(
                    controller: _subController,
                    prefixicon: Icon(Icons.drive_file_rename_outline_sharp),
                    hintText: "Enter Subject Name",
                    isNumber: false,
                    obsecuretext: false
                ),
                SizedBox(height: 10,),
                CustomTextField(
                    controller: _codeController,
                    prefixicon: Icon(Icons.code),
                    hintText: "Enter Subject Code",
                    isNumber: false,
                    obsecuretext: false
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.transparent),
                      color: Colors.white
                    ),
                    child: DropdownButtonFormField<String>(
                      value: _selectedRoom,
                      hint: Text('Select Room No.'),
                      items: _roomNumbers.map((String room) {
                        return DropdownMenuItem<String>(
                          value: room,
                          child: Text(room),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedRoom = newValue;
                        });
                      },
                      isExpanded: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.numbers_sharp),
                        border: InputBorder.none, // Removes the border
                        contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                      ),
                      style: TextStyle(height: 1.5),
                      dropdownColor: Colors.white,
                      icon: Icon(Icons.arrow_drop_down),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                CustomTextField(
                    controller: _totalHoursController,
                    prefixicon: Icon(Icons.timelapse_outlined),
                    hintText: "Enter Total Lecture Hours.",
                    isNumber: false,
                    obsecuretext: false
                ),
                SizedBox(height: 10,),
                CustomTextField(
                    controller: _startTimeController,
                    prefixicon: Icon(Icons.start),
                    hintText: "Enter Start Time.",
                    isNumber: false,
                    obsecuretext: false
                ),
                SizedBox(height: 40,),
                AuthButton(
                  onpressed: () async {
                    print('Subject: ${_subController.text}');
                    print('Code: ${_codeController.text}');
                    print('Room: $_selectedRoom');
                    print('Total Hours: ${_totalHoursController.text}');
                    print('Start Time: ${_startTimeController.text}');
                  },
                  name: "Generate Link",
                  bcolor: AppColors.theme['green'],
                  tcolor: AppColors.theme['white'],
                  isLoading: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
