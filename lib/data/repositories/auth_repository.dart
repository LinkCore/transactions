import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_transaction/common/app_constants/app_constants.dart';

class AuthRepository {
  static final AuthRepository _userRepository = AuthRepository._internal();

  factory AuthRepository() {
    return _userRepository;
  }

  AuthRepository._internal();

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    await _saveToLocalDb(email: email, password: password);
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await _saveToLocalDb(email: email, password: password);
  }

  Future<bool> allowAutoLogin() async {
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    final password =
        await secureStorage.read(key: AppConstants.storagePasswordKey);
    final email = await secureStorage.read(key: AppConstants.storageEmailKey);
    return email != null &&
        password != null &&
        FirebaseAuth.instance.currentUser != null &&
        FirebaseAuth.instance.currentUser!.email == email;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await _clearLocalDb();
  }

  Future<void> _saveToLocalDb({
    required String email,
    required String password,
  }) async {
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    await secureStorage.write(key: AppConstants.storageEmailKey, value: email);
    await secureStorage.write(
        key: AppConstants.storagePasswordKey, value: password);
  }

  Future<void> _clearLocalDb() async {
    FlutterSecureStorage secureStorage = const FlutterSecureStorage();
    await secureStorage.delete(key: AppConstants.storageEmailKey);
    await secureStorage.delete(key: AppConstants.storagePasswordKey);
  }
}
