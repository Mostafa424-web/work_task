import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUtils {
  static Future<List<String>> getCompletedLevels(String userId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      final data = snapshot.data() as Map<String, dynamic>?;
      return List<String>.from(data?['completedLevels'] ?? []);
    } catch (e) {
      print("Error fetching completed levels: $e");
      return [];
    }
  }

  static Future<Map<String, dynamic>?> getLevelPasswords() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('pwdrole')
          .doc('password_level')
          .get();
      return snapshot.data() as Map<String, dynamic>?;
    } catch (e) {
      print("Error fetching level passwords: $e");
      return null;
    }
  }

  static Future<void> updateCompletedLevels(String userId, String level) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'completedLevels': FieldValue.arrayUnion([level]),
      });
    } catch (e) {
      print("Error updating completed levels: $e");
    }
  }
}
