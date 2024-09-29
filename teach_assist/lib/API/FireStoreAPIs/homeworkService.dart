import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teach_assist/API/FireStoreAPIs/studentServices.dart';
import 'package:teach_assist/API/FireStoreAPIs/subjectServices.dart';
import 'package:teach_assist/Models/Homework.dart';
import 'package:teach_assist/Models/Student.dart';
import 'package:teach_assist/Models/Subject.dart';

class HomeworkService {
  // Firestore collection reference
  final CollectionReference homeworkCollection =
  FirebaseFirestore.instance.collection('homeworks');
  final CollectionReference subjectCollection =
  FirebaseFirestore.instance.collection('subjects');
  final CollectionReference studentCollection =
  FirebaseFirestore.instance.collection('students');

  // Add a new Homework to Firestore
  Future<String> addHomework(Homework homework) async {
    try {

      print("#hw-add: ${homework.courseId}");

      Subject? subject = await SubjectService().getSubjectById(homework.courseId!);


      if(subject != null && subject.studentsEnrolled != null && (subject.studentsEnrolled?.isNotEmpty ?? true)){
        List<String> sids = subject.studentsEnrolled!;

        StudentService studentService = StudentService();
        for(int i=0; i<sids.length; i++){
          Student? student = await studentService.getStudentById(sids[i]);
          print("#std: $student");
          if(student != null) studentService.addHomeWork(student, homework);
        }

      }
      return ("Homework added successfully.");
    } catch (e) {
      return ("Failed to add homework: ");
    }
  }

  // Fetch all Homework entries from Firestore
  Stream<List<Homework>> getHomeworks() {
    return homeworkCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Homework.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // Fetch a single Homework entry by ID from Firestore
  Future<Homework?> getHomeworkById(String id) async {
    try {
      DocumentSnapshot doc = await homeworkCollection.doc(id).get();
      if (doc.exists) {
        return Homework.fromJson(doc.data() as Map<String, dynamic>);
      } else {
        print("Homework not found.");
        return null;
      }
    } catch (e) {
      print("Failed to get homework: $e");
      return null;
    }
  }

  // Update an existing Homework in Firestore
  Future<void> updateHomework(Homework homework) async {
    try {
      await homeworkCollection.doc(homework.id).update(homework.toJson());
      print("Homework updated successfully.");
    } catch (e) {
      print("Failed to update homework: $e");
    }
  }

  // Delete a Homework from Firestore by ID
  Future<void> deleteHomework(String id) async {
    try {
      await homeworkCollection.doc(id).delete();
      print("Homework deleted successfully.");
    } catch (e) {
      print("Failed to delete homework: $e");
    }
  }
}
