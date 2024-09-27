import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teach_assist/Models/Quiz.dart';

class QuizService {
  final CollectionReference quizCollection =
  FirebaseFirestore.instance.collection('quizzes');
  final CollectionReference studentCollection =
  FirebaseFirestore.instance.collection('student');

  // Create a new quiz document
  Future<void> addQuiz(Quiz quiz) async {
    final quizDocRef = quizCollection
        .doc(quiz.courseCode)
        .collection(quiz.id ?? "")
        .doc(quiz.studentId);

    final studentQuizDocRef = studentCollection
        .doc(quiz.studentId)
        .collection("quizList")
        .doc(quiz.id);

    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        // Add quiz to quizCollection
        transaction.set(quizDocRef, quiz.toJson());

        // Add quiz to student's quizList in studentCollection
        transaction.set(studentQuizDocRef, quiz.toJson());
      });

      print('Quiz added successfully!');
    } catch (e) {
      print('Error adding quiz: $e');
    }
  }

  // Read quiz data by ID
  Future<Quiz?> getQuizById(String courseCode, String quizId, String studentId) async {
    final quizDocRef = quizCollection
        .doc(courseCode)
        .collection(quizId)
        .doc(studentId);

    try {
      DocumentSnapshot doc = await quizDocRef.get();
      if (doc.exists) {
        return Quiz.fromJson(doc.data() as Map<String, dynamic>);
      } else {
        print('Quiz not found');
        return null;
      }
    } catch (e) {
      print('Error getting quiz: $e');
      return null;
    }
  }

  // Update an existing quiz document
  Future<void> updateQuiz(Quiz quiz) async {
    final quizDocRef = quizCollection
        .doc(quiz.courseCode)
        .collection(quiz.id ?? "")
        .doc(quiz.studentId);

    final studentQuizDocRef = studentCollection
        .doc(quiz.studentId)
        .collection("quizList")
        .doc(quiz.id);

    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        // Update quiz in quizCollection
        transaction.update(quizDocRef, quiz.toJson());

        // Update quiz in student's quizList in studentCollection
        transaction.update(studentQuizDocRef, quiz.toJson());
      });

      print('Quiz updated successfully!');
    } catch (e) {
      print('Error updating quiz: $e');
    }
  }

  // Delete a quiz document by ID
  Future<void> deleteQuiz(String courseCode, String quizId, String studentId) async {
    final quizDocRef = quizCollection
        .doc(courseCode)
        .collection(quizId)
        .doc(studentId);

    final studentQuizDocRef = studentCollection
        .doc(studentId)
        .collection("quizList")
        .doc(quizId);

    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        // Delete quiz from quizCollection
        transaction.delete(quizDocRef);

        // Delete quiz from student's quizList in studentCollection
        transaction.delete(studentQuizDocRef);
      });

      print('Quiz deleted successfully!');
    } catch (e) {
      print('Error deleting quiz: $e');
    }
  }

  // Fetch all quizzes
  Future<List<Quiz>> getAllQuizzes() async {
    try {
      QuerySnapshot querySnapshot = await quizCollection.get();
      return querySnapshot.docs
          .map((doc) => Quiz.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error getting quizzes: $e');
      return [];
    }
  }
}
