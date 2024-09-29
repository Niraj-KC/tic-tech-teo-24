import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teach_assist/API/FireStoreAPIs/homeworkService.dart';
import 'package:teach_assist/Models/Homework.dart';
import 'package:teach_assist/Providers/CurrentUserProvider.dart';
import 'package:teach_assist/Utils/HelperFunctions/date_formation.dart';


import '../Utils/HelperFunctions/HelperFunction.dart';
import '../Utils/ThemeData/colors.dart';
import '../main.dart';
import 'CustomTextField.dart';

class HomeworkCard extends StatefulWidget {
  final Homework homework;
  const HomeworkCard({super.key, required this.homework});

  @override
  State<HomeworkCard> createState() => _HomeworkCardState();
}

class _HomeworkCardState extends State<HomeworkCard> {
  @override
  Widget build(BuildContext context) {

    mq = MediaQuery.of(context).size;


    final int curr = DateTime.now().millisecondsSinceEpoch;

    int submissionCloseDate;
    try {

      submissionCloseDate = widget.homework.timeStampCreated != null
          ? DateTime.parse(widget.homework.timeStampCreated!).millisecondsSinceEpoch
          : 0;
    } catch (e) {
      submissionCloseDate = 0;
      print('Invalid date format: ${widget.homework.timeStampCreated}');
    }

    bool isOverdue = curr < submissionCloseDate;

    return Consumer<CurrentUserProvider>(builder: (context, currentUserProvider, child){
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Container(
          height: 180,
          decoration: BoxDecoration(
            color: AppColors.theme['white'],
            borderRadius: BorderRadius.circular(10),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 3),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        "assets/images/upload_icon.png",
                        height: 50,
                        width: 50,
                      ),
                      Text(
                        widget.homework.courseName ?? "",
                        style: TextStyle(
                            color: AppColors.theme['black'],
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Divider(),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Due Date: " +
                                  (widget.homework.timeStampDueDate != null
                                      ? MyDateUtil.getMessageTime(
                                      context: context,
                                      time: widget.homework.timeStampDueDate!)
                                      : "N/A"),
                              style: TextStyle(
                                  color: AppColors.theme['black'],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Submission Name: " + (widget.homework.title ?? ""),
                              style: TextStyle(
                                  color: AppColors.theme['black'],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 40,
                              width: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: isOverdue
                                    ? Colors.red.withOpacity(0.2)
                                    : AppColors.theme['green'].withOpacity(0.2),
                              ),
                              child: Center(
                                child: Text(
                                  isOverdue ? "Overdue" : "Not Overdue",
                                  style: TextStyle(
                                    color: isOverdue
                                        ? Colors.red
                                        : AppColors.theme['green'],
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (){

                                TextEditingController linkController = TextEditingController();
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: AppColors.theme['offWhite'],
                                      title: Text(
                                        "Upload Course Policy",
                                        style: TextStyle(color: AppColors.theme['black'], fontWeight: FontWeight.bold, fontSize: 20),
                                      ),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "Please Provide The Google Drive Link For The Home Work.",
                                              style: TextStyle(color: AppColors.theme['black'], fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 20),
                                            CustomTextField(
                                              hintText: "Google Drive Link",
                                              isNumber: false,
                                              obsecuretext: false,
                                              controller: linkController,
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            String driveLink = linkController.text;
                                            if (driveLink.isNotEmpty) {
                                              setState(() {
                                                widget.homework.timeStampSubmissionDate = DateTime.now().millisecondsSinceEpoch.toString();
                                                widget.homework.gDriveSubmissionUrl = driveLink;
                                                widget.homework.isSubmitted = true;

                                              });

                                              final res = await HomeworkService().addHomework(widget.homework);

                                              HelperFunction.showToast(res.toString());

                                              Navigator.of(context).pop();
                                            } else {
                                              HelperFunction.showToast("Enter valid link");
                                            }
                                          },
                                          child: Text(
                                            "Upload",
                                            style: TextStyle(color: Colors.blue),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );

                              },
                              child: Container(
                                height: 40,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: AppColors.theme['offWhite'],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(child: Text("Add Submission")),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
