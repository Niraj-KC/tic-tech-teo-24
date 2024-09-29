import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teach_assist/API/FireStoreAPIs/studentServices.dart';
import 'package:teach_assist/API/FireStoreAPIs/subjectServices.dart';
import 'package:teach_assist/Models/Homework.dart';
import 'package:teach_assist/Models/Student.dart';
import 'package:teach_assist/Models/Subject.dart';
import 'package:teach_assist/Models/Teacher.dart';

class HomeworkService {
  // Firestore collection reference
  final CollectionReference homeworkCollection =
  FirebaseFirestore.instance.collection('homeworks');

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
        return Homework.fromJson(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  // Fetch a single Homework entry by ID from Firestore
  Future<Homework?> getHomeworkById(String id) async {
    try {
      DocumentSnapshot doc = await homeworkCollection.doc(id).get();
      if (doc.exists) {
        return Homework.fromJson(doc.data() as Map<String, dynamic>, doc.id);
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


  // Get Stream of Homework for a Student grouped by Course
  Stream<Map<String, List<Homework>>> getHomeworkListForStudentGroupedByCourse(
      Student student) async* {
    try {
      // Query homework for a specific student
      Stream<QuerySnapshot> snapshotStream = homeworkCollection
          .where('studentId', isEqualTo: student.id)
          .snapshots();

      await for (var snapshot in snapshotStream) {
        List<Homework> homeworkList = snapshot.docs.map((doc) {
          return Homework.fromJson(doc.data() as Map<String, dynamic>, doc.id);
        }).toList();

        // Group homework by courseId
        Map<String, List<Homework>> groupedByCourse = {};
        for (var homework in homeworkList) {
          if (groupedByCourse.containsKey(homework.courseId)) {
            groupedByCourse[homework.courseId]!.add(homework);
          } else {
            groupedByCourse[homework.courseId!] = [homework];
          }
        }

        // Yield the grouped data
        yield groupedByCourse;
      }
    } catch (e) {
      print('Error getting homework list: $e');
      yield {};
    }
  }

  // Get Stream of Homework for a Teacher based on the courses they teach
  Stream<Map<String, List<Homework>>> getHomeworkListForTeacherGroupedByCourse(
      Teacher teacher) async* {
    try {
      // Query homework for the courses taught by the teacher (in the subjects list)
      Stream<QuerySnapshot> snapshotStream = homeworkCollection
          .where('courseId', whereIn: teacher.subjects)
          .snapshots();

      await for (var snapshot in snapshotStream) {
        List<Homework> homeworkList = snapshot.docs.map((doc) {
          return Homework.fromJson(doc.data() as Map<String, dynamic>, doc.id);
        }).toList();

        // Group homework by courseId
        Map<String, List<Homework>> groupedByCourse = {};
        for (var homework in homeworkList) {
          if (groupedByCourse.containsKey(homework.courseId)) {
            groupedByCourse[homework.courseId]!.add(homework);
          } else {
            groupedByCourse[homework.courseId!] = [homework];
          }
        }

        // Yield the grouped data
        yield groupedByCourse;
      }
    } catch (e) {
      print('Error getting homework list for teacher: $e');
      yield {};
    }
  }



  // Post homework for each student enrolled in a course
  Future<void> postHomeworkForCourse(Homework homeworkTemplate) async {
    try {
      Subject? subject = await SubjectService().getSubjectById(homeworkTemplate.courseId!);

      if(subject == null) return;

      // Fetch students enrolled in the subject (course)
      List<String> studentsEnrolled = subject.studentsEnrolled ?? [];

      // Iterate over each student enrolled in the course and add a homework entry for each student
      for (String studentId in studentsEnrolled) {
        // Create a new Homework object for each student
        Homework studentHomework = Homework(
          id: FirebaseFirestore.instance.collection('homework').doc().id, // Generate a unique ID
          title: homeworkTemplate.title,
          courseId: subject.id,
          courseName: subject.name,
          studentId: studentId, // Associate homework with the student
          gDriveQuestionUrl: homeworkTemplate.gDriveQuestionUrl,
          gDriveReferenceAnswerUrl: homeworkTemplate.gDriveReferenceAnswerUrl,
          timeStampCreated: homeworkTemplate.timeStampCreated,
          timeStampDueDate: homeworkTemplate.timeStampDueDate,
          isSubmitted: false, // By default, homework is not submitted
        );

        // Add the homework to Firestore for the student
        await homeworkCollection.add(studentHomework.toJson());
      }

      print("Homework posted successfully for all students in the course: ${subject.name}");
    } catch (e) {
      print('Error posting homework: $e');
    }
  }

  // Student submits homework
  Future<void> submitHomework(String studentId, String homeworkId, String submissionUrl) async {
    try {
      // Reference to the specific homework document for the student
      DocumentReference homeworkDoc = homeworkCollection.doc(homeworkId);

      // Fetch the homework to ensure it exists and belongs to the student
      DocumentSnapshot snapshot = await homeworkDoc.get();

      if (snapshot.exists) {
        Homework homework = Homework.fromJson(snapshot.data() as Map<String, dynamic>, homeworkId);

        if (homework.studentId == studentId) {
          // Update the homework with submission details
          await homeworkDoc.update({
            'gDriveSubmissionUrl': submissionUrl,
            'timeStampSubmissionDate': DateTime.now().toString(), // Record submission time
            'isSubmitted': true, // Mark as submitted
          });
          print("Homework submitted successfully by student: $studentId");
        } else {
          print("Homework does not belong to this student.");
        }
      } else {
        print("Homework not found.");
      }
    } catch (e) {
      print('Error submitting homework: $e');
    }
  }



}
