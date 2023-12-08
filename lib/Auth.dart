import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> regis(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<bool> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners();
      return true;
    } catch (e) {
      // Tangkap dan cetak pesan kesalahan jika login gagal
      return false; // Jika gagal login, kembalikan false
    }
  }

  Future<void> signOut() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear(); // Menghapus semua data lokal
      await _auth.signOut;
      notifyListeners();
    } catch (e) {
      print("Error during sign out: $e");
      // Handle sign-out errors here
      throw e; // Rethrow the exception to propagate it to the caller
    }
  }
}
