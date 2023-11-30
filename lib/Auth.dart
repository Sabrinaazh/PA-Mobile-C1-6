import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> regis(String email, String password) async {
    final user = await _auth.createUserWithEmailAndPassword(
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
      return true; // Jika berhasil login, kembalikan true
    } catch (e) {
      // Tangkap dan cetak pesan kesalahan jika login gagal
      return false; // Jika gagal login, kembalikan false
    }
  }
}
