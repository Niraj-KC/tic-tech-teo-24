import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teach_assist/API/FireStoreAPIs/studentServices.dart';
import 'package:teach_assist/API/FireStoreAPIs/teacherServices.dart';
import 'package:teach_assist/API/FirebaseAPIs.dart';
import 'package:teach_assist/Models/Student.dart';
import 'package:teach_assist/Models/Subject.dart';
import 'package:teach_assist/Models/Teacher.dart';

class SubjectService {
  final CollectionReference subjectCollection =
  FirebaseFirestore.instance.collection('subjects');
  final CollectionReference studentsCollection =
  FirebaseFirestore.instance.collection('students');

  // Create Subject
  Future<String> addSubject(Subject subject, Teacher teacher) async {
    try {
      await subjectCollection.doc(subject.id).set(subject.toJson());
      await TeacherService().addSubject(teacher, subject.id!);
      print('Subject added successfully!');
      return 'Subject added successfully!';
    } catch (e) {
      print('Error adding subject: $e');
      return 'Something went wrong';
    }
  }

  // Read Subject by ID
  Future<Subject?> getSubjectById(String subjectId) async {
    try {
      DocumentSnapshot doc = await subjectCollection.doc(subjectId).get();
      if (doc.exists) {
        return Subject.fromJson(doc.data() as Map<String, dynamic>);
      } else {
        print('Subject not found');
        return null;
      }
    } catch (e) {
      print('Error getting subject: $e');
      return null;
    }
  }

  // Update Subject
  Future<void> updateSubject(Subject subject) async {
    try {
      await subjectCollection.doc(subject.id).update(subject.toJson());
      print('Subject updated successfully!');
    } catch (e) {
      print('Error updating subject: $e');
    }
  }

  // Delete Subject
  Future<void> deleteSubject(String subjectId) async {
    try {
      await subjectCollection.doc(subjectId).delete();
      print('Subject deleted successfully!');
    } catch (e) {
      print('Error deleting subject: $e');
    }
  }

  // Get All Subjects
  Future<List<Subject>> getAllSubjects() async {
    try {
      QuerySnapshot querySnapshot = await subjectCollection.get();
      return querySnapshot.docs
          .map((doc) => Subject.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error getting subjects: $e');
      return [];
    }
  }

  Future<void> enrollStudents(Subject subject, List<String> students) async {
    try{
      subject.studentsEnrolled ??= [];
      subject.studentsEnrolled!.addAll(students);
      print("#se: ${subject.studentsEnrolled}");
      subjectCollection.doc(subject.id).set({"studentsEnrolled": subject.studentsEnrolled});

      StudentService studentService = StudentService();
      students.forEach((element) async {
        Student? student = await studentService.getStudentById(element);
        if(student != null){
          student.allocatedSubjects?.add(AllocatedSubjects(id: subject.id));
          studentService.updateStudent(student);
        }
      });

      print("Student enrollment successful.");
    }
    catch (e){
      print("Error while enrolling students");
    }
  }

  Future<void> updateCoursePolicy(String id, String url) async {
    try{
      subjectCollection.doc(id).set({"coursePolicy": url});
      print("Course policy updated successfully.");
    }
    catch (e){
      print("Error updating Course policy");
    }
  }

  Future<void> updateMaterial(Subject subject) async {
    try{
      subjectCollection.doc(subject.id).set({"materials": subject.materials});
      print("Course policy updated successfully.");
    }
    catch (e){
      print("Error updating Course policy");
    }
  }

}


Future<void> subjectTest() async {
  SubjectService service = SubjectService();

  Subject subject = Subject(
    courseCode: "CN",
    departmentId: "CSE",
    name: "Computer Networking",
    id: FirebaseAPIs.uuid.v1()
  );

  // service.addSubject(subject);

  service.enrollStudents(subject, ["c1pJgYokjGYAz12IMl66fhp3t0u1"]);



}
