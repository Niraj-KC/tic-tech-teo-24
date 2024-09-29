import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teach_assist/API/FirebaseAuthentication/AppFirebaseAuth.dart';
import 'package:teach_assist/Models/Homework.dart';
import 'package:teach_assist/Models/Quiz.dart';
import 'package:teach_assist/Models/Student.dart';
import 'package:teach_assist/Models/Subject.dart';

class StudentService {
  final CollectionReference studentCollection =
  FirebaseFirestore.instance.collection('students');
  final CollectionReference subjectCollection =
  FirebaseFirestore.instance.collection('subjects');

  // Create Student
  Future<bool> addStudent(Student student) async {
    try {
      // Set the student data
      await studentCollection.doc(student.id).set(student.toJson());

      // Save allocated subjects as subcollection
      if (student.allocatedSubjects != null) {
        for (var subject in student.allocatedSubjects!) {
          await studentCollection
              .doc(student.id)
              .collection('allocatedSubjects')
              .doc(subject.id)
              .set(subject.toJson());
        }
      }

      print('Student added successfully!');
      return true;
    } catch (e) {
      print('Error adding student: $e');
      return false;
    }
  }

  Future<String> signUpNewStudent(Student student) async {
    try {
      await AppFirebaseAuth.signUp(
          "${student.rollNo}@abc.com", "12345678", null, student, true);
      print('Student added successfully!');
      return "Student added successfully!";
    } catch (e) {
      print('Error adding student: $e');
      return "Something went wrong.";
    }
  }

  // Read Student by ID
  Future<Student?> getStudentById(String studentId) async {
    try {
      DocumentSnapshot doc = await studentCollection.doc(studentId).get();
      if (doc.exists) {
        Student student = Student.fromJson(doc.data() as Map<String, dynamic>);

        // Fetch allocated subjects from subcollection
        final allocatedSubjectsSnapshot = await studentCollection
            .doc(studentId)
            .collection('allocatedSubjects')
            .get();

        student.allocatedSubjects = allocatedSubjectsSnapshot.docs
            .map((doc) => AllocatedSubjects.fromJson(doc.data() as Map<String, dynamic>))
            .toList();

        return student;
      } else {
        print('Student not found');
        return null;
      }
    } catch (e) {
      print('Error getting student: $e');
      return null;
    }
  }

  // Update Student
  Future<void> updateStudent(Student student) async {
    try {
      await studentCollection.doc(student.id).update(student.toJson());

      // Update allocated subjects
      if (student.allocatedSubjects != null) {
        for (var subject in student.allocatedSubjects!) {
          await studentCollection
              .doc(student.id)
              .collection('allocatedSubjects')
              .doc(subject.id)
              .set(subject.toJson());
        }
      }

      print('Student updated successfully!');
    } catch (e) {
      print('Error updating student: $e');
    }
  }

  // Delete Student
  Future<void> deleteStudent(String studentId) async {
    try {
      // Delete allocated subjects subcollection
      final allocatedSubjectsSnapshot = await studentCollection
          .doc(studentId)
          .collection('allocatedSubjects')
          .get();

      for (var doc in allocatedSubjectsSnapshot.docs) {
        await doc.reference.delete();
      }

      // Now delete the student document
      await studentCollection.doc(studentId).delete();
      print('Student deleted successfully!');
    } catch (e) {
      print('Error deleting student: $e');
    }
  }

  // Get All Students
  Future<List<Student>> getAllStudents() async {
    try {
      QuerySnapshot querySnapshot = await studentCollection.get();
      return querySnapshot.docs
          .map((doc) => Student.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error getting students: $e');
      return [];
    }
  }

  // Get Stream of Subjects for a Student based on AllocatedSubjects IDs
  Stream<List<Subject>> getSubjectsForStudent(Student student) async* {
    try {
      // Get student by ID
      if (student.allocatedSubjects == null) {
        yield [];
        return;
      }

      // Extract AllocatedSubjects IDs
      List<String> subjectIds = student.allocatedSubjects!
          .map((allocatedSubject) => allocatedSubject.id!)
          .toList();

      // Stream of Subjects based on AllocatedSubjects IDs
      yield* subjectCollection
          .where('id', whereIn: subjectIds) // Query subjects by their IDs
          .snapshots()
          .map((snapshot) => snapshot.docs
          .map((doc) => Subject.fromJson(doc.data() as Map<String, dynamic>))
          .toList());
    } catch (e) {
      print('Error getting subjects: $e');
      yield [];
    }
  }

  Future<void> addHomeWork(Student student, Homework homework) async {
    if (student.allocatedSubjects != null) {
      // Update the allocated subject in Firestore
      await studentCollection
          .doc(student.id)
          .collection('allocatedSubjects')
          .doc(homework.courseId)
          .collection("homeworkList")
          .doc()
          .set(homework.toJson());
    } else {
      print('Allocated subject not found for the given homework.');
    }
  }

}
