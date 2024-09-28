import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teach_assist/Models/Submission.dart';

class SubmissionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create Submission
  Future<void> createSubmission(Submission submission) async {
    await _firestore.collection('submissions').add(submission.toJson());
  }

  // Read Submissions
  Future<List<Submission>> fetchSubmissions() async {
    final snapshot = await _firestore.collection('submissions').get();
    return snapshot.docs
        .map((doc) => Submission.fromJson(doc.data()))
        .toList();
  }

  // Update Submission
  Future<void> updateSubmission(String id, Submission submission) async {
    await _firestore.collection('submissions').doc(id).update(submission.toJson());
  }

  // Delete Submission
  Future<void> deleteSubmission(String id) async {
    await _firestore.collection('submissions').doc(id).delete();
  }
}