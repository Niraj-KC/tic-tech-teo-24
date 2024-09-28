import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teach_assist/Models/Teacher.dart';

import '../../Models/Subject.dart';

class TeacherService {
  final CollectionReference teacherCollection =
  FirebaseFirestore.instance.collection('teachers');
  final CollectionReference subjectCollection =
  FirebaseFirestore.instance.collection('subjects');

  // Create a new teacher document
  Future<void> addTeacher(Teacher teacher) async {
    try {
      await teacherCollection.doc(teacher.id).set(teacher.toJson());
      print('Teacher added successfully!');
    } catch (e) {
      print('Error adding teacher: $e');
    }
  }

  // Read teacher data by ID
  Future<Teacher?> getTeacherById(String id) async {
    try {
      DocumentSnapshot doc = await teacherCollection.doc(id).get();
      if (doc.exists) {
        return Teacher.fromJson(doc.data() as Map<String, dynamic>);
      } else {
        print('Teacher not found');
        return null;
      }
    } catch (e) {
      print('Error getting teacher: $e');
      return null;
    }
  }

  // Update an existing teacher document
  Future<void> updateTeacher(Teacher teacher) async {
    try {
      await teacherCollection.doc(teacher.id).update(teacher.toJson());
      print('Teacher updated successfully!');
    } catch (e) {
      print('Error updating teacher: $e');
    }
  }

  // Delete a teacher document by ID
  Future<void> deleteTeacher(String id) async {
    try {
      await teacherCollection.doc(id).delete();
      print('Teacher deleted successfully!');
    } catch (e) {
      print('Error deleting teacher: $e');
    }
  }

  // Fetch all teachers
  Future<List<Teacher>> getAllTeachers() async {
    try {
      QuerySnapshot querySnapshot = await teacherCollection.get();
      return querySnapshot.docs
          .map((doc) => Teacher.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error getting teachers: $e');
      return [];
    }
  }

  Future<void> addSubject(Teacher teacher, String subjectId) async {
    teacher.subjects ??= [];
    teacher.subjects!.add(subjectId);
    await teacherCollection.doc(teacher.id).update({"subjects": teacher.subjects});
  }

  // Get Stream of Subjects for a Teacher based on AllocatedSubjects IDs
  Stream<List<Subject>> getSubjectsForTeacher(Teacher teacher) async* {
    try {
      // Get student by ID
      if (teacher.subjects == null) {
        yield [];
        return;
      }

      // Extract AllocatedSubjects IDs
      List<String> subjectIds = teacher.subjects!;

      // Stream of Subjects based on AllocatedSubjects IDs
      yield* subjectCollection
          .where('id', whereIn: subjectIds) // Query subjects by their IDs
          .snapshots()
          .map((snapshot) =>
          snapshot.docs
              .map((doc) => Subject.fromJson(doc.data() as Map<String, dynamic>))
              .toList());
    } catch (e) {
      print('Error getting subjects: $e');
      yield [];
    }
  }
}
