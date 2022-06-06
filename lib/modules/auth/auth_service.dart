import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:task_list/modules/auth/auth_screen.dart';

class AuthService extends GetxService {
  static AuthService instance = Get.find();
  final _auth = FirebaseAuth.instance;
  RxBool isCreate = false.obs;
  @override
  void onInit() {
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        isCreate.value = false;
        Get.offAll(() => const AuthScreen());
      } else {
        Get.offAndToNamed('/home');
      }
    });

    super.onInit();
  }

  User getUser() {
    return _auth.currentUser!;
  }

  Future<void> onSignIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Notification', 'No user found for that email.',
            snackPosition: SnackPosition.BOTTOM);
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Notification', 'No user found for that email.',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Notification', e.toString(),
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Notification', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  Future<void> onSignUp({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      UserCredential _userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      await _userCredential.user?.updateDisplayName("Nguyen Van Lam");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('Notification', 'The password provided is too weak.',
            snackPosition: SnackPosition.BOTTOM);
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar(
            'Notification', 'The account already exists for that email.',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Notification', e.toString(),
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Notification', e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void onCreate(bool _isCreate) {
    isCreate.value = _isCreate;
  }
}
