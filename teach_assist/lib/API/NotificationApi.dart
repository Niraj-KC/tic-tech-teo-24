
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart';
import 'package:teach_assist/API/FireStoreAPIs/studentServices.dart';
import 'package:teach_assist/API/FireStoreAPIs/subjectServices.dart';
import 'package:teach_assist/Models/Subject.dart';
import 'package:teach_assist/Models/Teacher.dart';

import '../Models/Student.dart';
import 'FirebaseAPIs.dart';

class NotificationApi{

  static Future<void> getFirebaseMessagingToken(String uid) async {
    try {
      await FirebaseAPIs.fmessaging.requestPermission();

      await FirebaseAPIs.fmessaging.getToken().then((t) async {
        if (t != null) {
          Map<String, dynamic> fields = {"notificationToken": t};
          await StudentService().updateUserProfile(uid, fields);
          log('Push Token: $t');
        }
      });
    } catch (error) {
      log('Error getting Firebase Messaging token: $error');
    }
  }

  static Future<void> notifyStudents(String courseId, Teacher teacher,String msg) async {
    Subject? subject = await SubjectService().getSubjectById(courseId);
    if(subject == null) return;
    subject.studentsEnrolled ??= [];

    for(int i=0; i<subject.studentsEnrolled!.length; i++){
        Student? student = await StudentService().getStudentById(subject.studentsEnrolled![i]);
        if(student != null){
          sendPushNotification(student, teacher, msg);
        }

    }


  }



  static Future<void> sendPushNotification(Student toUser,
      Teacher fromUser, String msg) async {
    try {
      final body = {
        "to": toUser.notificationToken,
        "notification": {"title": fromUser.name, "body": msg},
        "data": {"some_data": "user id : ${fromUser.id}"},
      };

      var res = await post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader:
          ''
        },
        body: jsonEncode(body),
      );
      log('Response status: ${res.statusCode}');
      log('Response body: ${res.body}');
    } catch (e) {
      log('\nsendPushNotificationE: $e');
    }
  }

  static Future<void> sendMassNotificationToAllUsers(String message) async {
    // try {
    //   // List<String> allUserTokens = await getAllUserTokens();
    //   // if (allUserTokens.isEmpty) {
    //   //   log('No user tokens found');
    //   //   return;
    //   // }
    //
    //   // var requestBody = jsonEncode({
    //   //   "registration_ids": allUserTokens,
    //   //   "notification": {
    //   //     "title": "Announcement",
    //   //     "body": message,
    //   //   },
    //   // });
    //
    //   var response = await post(
    //     Uri.parse('https://fcm.googleapis.com/fcm/send'),
    //     headers: {
    //       HttpHeaders.contentTypeHeader: 'application/json',
    //       HttpHeaders.authorizationHeader:
    //       ''
    //     },
    //     body: requestBody,
    //   );
    //
    //   log('Send mass notification response status: ${response.statusCode}');
    //   log('Send mass notification response body: ${response.body}');
    // } catch (error) {
    //   log('Error sending mass notification: $error');
    // }
  }





}