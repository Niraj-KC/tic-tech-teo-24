import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teach_assist/Models/Quiz.dart';

class QuizService {
  final CollectionReference quizCollection =
  FirebaseFirestore.instance.collection('quizzes');

  // Create a new quiz document
  Future<void> addQuiz(Quiz quiz) async {
    try {
      await quizCollection.doc(quiz.courseCode).collection(quiz.id??"").doc(quiz.studentId).set(quiz.toJson());
      print('Quiz added successfully!');
    } catch (e) {
      print('Error adding quiz: $e');
    }
  }

  // Read quiz data by ID
  Future<Quiz?> getQuizById(String id) async {
    try {
      DocumentSnapshot doc = await quizCollection.doc(id).get();
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
    try {
      await quizCollection.doc(quiz.id).update(quiz.toJson());
      print('Quiz updated successfully!');
    } catch (e) {
      print('Error updating quiz: $e');
    }
  }

  // Delete a quiz document by ID
  Future<void> deleteQuiz(String id) async {
    try {
      await quizCollection.doc(id).delete();
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
