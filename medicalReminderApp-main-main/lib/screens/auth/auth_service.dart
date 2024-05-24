import 'package:firebase_auth/firebase_auth.dart';
import 'package:health/resources/app_keys.dart';
import 'package:health/services/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final SharedPreferences db = getIt<SharedPreferences>();

  Future<String?> registration({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await saveToken(userCredential.additionalUserInfo?.authorizationCode ?? 'token');
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> saveToken(String token) async {
    print("TOKEN IS");
    print(token);
    await db.setString(Keys.token, token);
  }

  Future<void> deleteToken() async {
    await db.remove(Keys.token);
  }

  Future<bool> checkUserRegister() async {
    final token = db.getString(Keys.token);
    print("TOKEN IS");
    print(token);
    if (token == null || token == '') {
      return false;
    }
    return true;
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await saveToken(userCredential.additionalUserInfo?.authorizationCode ?? 'token');
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
