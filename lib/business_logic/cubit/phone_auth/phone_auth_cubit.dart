import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  late String verificationId;
  PhoneAuthCubit() : super(PhoneAuthInitial());

  Future<void> submetPhoneNumber(String phoneNumber) async {
    emit(Loading());
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2$phoneNumber',
      timeout: const Duration(seconds: 14),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  //  sign in method
  Future<void> signIn(PhoneAuthCredential credential) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(phoneOtpVerified());
    } catch (error) {
      emit(ErrorOccured(errorMessage: error.toString()));
    }
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    print('verfication completed');

    await signIn(credential);
  }

  void verificationFailed(FirebaseAuthException error) async {
    print('verificationFailed -> $error');
    emit(ErrorOccured(errorMessage: error.toString()));
  }

  void codeSent(String verificationId, int? resendToken) {
    print('code sent');

    this.verificationId = verificationId;

    emit(PhoneNumberSubmitted());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    print('codeAutoRetrievalTimeout');
  }

  Future<void> submitOTP(String otpCode) async {
    emit(Loading());
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: this.verificationId,
      smsCode: otpCode,
    );

    await signIn(credential);
  }

  Future<void> logOut() async {
    print('the user loggied out !');
    await FirebaseAuth.instance.signOut();
  }

  User getLoggedInUser() {
    User fireBaseUser = FirebaseAuth.instance.currentUser!;
    return fireBaseUser;
  }
}
