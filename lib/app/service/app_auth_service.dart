import 'package:get/get.dart';
import 'package:panda_technician/app/service/app_storage_service.dart';
import 'package:panda_technician/core/constants/storage_keys.dart';
import 'package:panda_technician/models/auth/account.dart';

enum AuthStatus { authenticated, unauthenticated, blocked }

class AppAuthService extends GetxService {
  final AppStorageService _storageService = Get.find<AppStorageService>();
  // late AppAuthRepository _authRepository;

  AuthStatus authStatus = AuthStatus.unauthenticated;

  UserAccount? user;
  String? authToken;

  // void setRepository(AppAuthRepository appAuthRepository) {
  //   _authRepository = appAuthRepository;
  // }

  Future<void> init() async {
    var userMap = _storageService.readMap(StorageKeys.currentUserKey);
    if (userMap != null) {
      user = UserAccount.fromMap(userMap);
    }
    authToken = _storageService.read(StorageKeys.tokenKey);

    if (authToken != null) authStatus = AuthStatus.authenticated;
  }

  Future<void> signup(String fullName, String email, String password) async {
    // user = await _authRepository.signUp(fullName, email, password);
    // await writeToLocal(user, user!.token, user!.refreshToken);
  }

  Future<void> writeToLocal(
      UserAccount user, String authToken, String refreshToken) async {
    _storageService.write(StorageKeys.currentUserKey, user.toMap());
    _storageService.write(StorageKeys.tokenKey, authToken);
    _storageService.write(StorageKeys.refreshTokenKey, refreshToken);
  }

  Future<void> signin(data, String token) async {
    try {
      // user = await _authRepository.signIn(email, password);
      user = UserAccount.fromMap(data);
      authToken = token;
      await writeToLocal(user!, token, token);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await _storageService.delete(StorageKeys.currentUserKey);
  }

  // Future<void> requestOTP(String email) async {
  //   await _authRepository.requestOTP(email);
  // }

  // Future<void> resendOtp(String email) async {
  //   await _authRepository.resendOtp(email);
  // }

  // Future<String> verifyOtp(String email, String otp) async {
  //   return await _authRepository.verifyOtp(email, otp);
  // }

  // Future<String> resetPassword(
  //     String token, String newpassword, String confirmPassword) async {
  //   return await _authRepository.resetPassword(
  //       token, newpassword, confirmPassword);
  // }
}
