// homework_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teach_assist/Models/Homeworks.dart';

class HomeworkService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create (Add) Homework
  Future<void> addHomework(Homework homework) async {
    try {
      await _firestore.collection('homework').add(homework.toJson());
    } catch (e) {
      throw Exception('Failed to add homework: $e');
    }
  }

  // Read (Get) Homework
  Stream<List<Homework>> getHomeworks() {
    return _firestore.collection('homework').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Homework.fromJson(doc.data() as Map<String, dynamic>)..title = doc.id; // Set the document ID
      }).toList();
    }).handleError((e) {
      throw Exception('Failed to get homeworks: $e');
    });
  }

  // Update Homework
  Future<void> updateHomework(String docId, Homework homework) async {
    try {
      await _firestore.collection('homework').doc(docId).update(homework.toJson());
    } catch (e) {
      throw Exception('Failed to update homework: $e');
    }
  }

  // Delete Homework
  Future<void> deleteHomework(String docId) async {
    try {
      await _firestore.collection('homework').doc(docId).delete();
    } catch (e) {
      throw Exception('Failed to delete homework: $e');
    }
  }
}