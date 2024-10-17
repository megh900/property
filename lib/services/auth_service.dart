import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to get the current user's UID
  Future<String?> getCurrentUserUid() async {
    User? user = _auth.currentUser;
    return user?.uid; // Return UID or null if user is not signed in
  }

  // Method to log in the user
  Future<User?> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user; // Return the logged-in user
    } catch (e) {
      print('Login failed: $e');
      return null; // Return null if login fails
    }
  }

  // Method to log out the user
  Future<void> logoutUser() async {
    await _auth.signOut();
    print('User signed out');
  }

  // Method to register a new user
  Future<User?> registerUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user; // Return the newly registered user
    } catch (e) {
      print('Registration failed: $e');
      return null; // Return null if registration fails
    }
  }
}
