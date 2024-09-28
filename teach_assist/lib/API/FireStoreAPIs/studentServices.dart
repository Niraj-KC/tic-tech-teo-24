import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teach_assist/Models/Quiz.dart';
import 'package:teach_assist/Models/Student.dart';
import 'package:teach_assist/Models/Subject.dart';

class StudentService {
  final CollectionReference studentCollection =
  FirebaseFirestore.instance.collection('students');
  final CollectionReference subjectCollection =
  FirebaseFirestore.instance.collection('subjects');

  // Create Student
  Future<void> addStudent(Student student) async {
    try {
      await studentCollection.doc(student.id).set(student.toJson());
      print('Student added successfully!');
    } catch (e) {
      print('Error adding student: $e');
    }
  }

  // Read Student by ID
  Future<Student?> getStudentById(String studentId) async {
    try {
      DocumentSnapshot doc = await studentCollection.doc(studentId).get();
      if (doc.exists) {
        return Student.fromJson(doc.data() as Map<String, dynamic>);
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
      print('Student updated successfully!');
    } catch (e) {
      print('Error updating student: $e');
    }
  }

  // Delete Student
  Future<void> deleteStudent(String studentId) async {
    try {
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


}
