import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/note_model.dart';

class NotesRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _userId => _auth.currentUser!.uid;

  Future<List<Note>> fetchNotes() async {
    try {
      final querySnapshot = await _firestore
          .collection('notes')
          .where('userId', isEqualTo: _userId)
          .orderBy('updatedAt', descending: true)
          .get();

      return querySnapshot.docs.map((doc) => Note.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Failed to fetch notes: $e');
    }
  }

  Future<void> addNote(String text) async {
    try {
      final now = DateTime.now();
      final note = Note(
        id: '', // Firestore will generate the ID
        text: text,
        createdAt: now,
        updatedAt: now,
        userId: _userId,
      );

      await _firestore.collection('notes').add(note.toFirestore());
    } catch (e) {
      throw Exception('Failed to add note: $e');
    }
  }

  Future<void> updateNote(String id, String text) async {
    try {
      await _firestore.collection('notes').doc(id).update({
        'text': text,
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      throw Exception('Failed to update note: $e');
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      await _firestore.collection('notes').doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete note: $e');
    }
  }
}