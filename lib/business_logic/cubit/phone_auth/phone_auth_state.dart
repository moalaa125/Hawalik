part of 'phone_auth_cubit.dart';

@immutable
sealed class PhoneAuthState {}

final class PhoneAuthInitial extends PhoneAuthState {}

class Loading extends PhoneAuthState {}

class ErrorOccured extends PhoneAuthState {
  final String errorMessage;

  ErrorOccured({required this.errorMessage});
}

class PhoneNumberSubmitted extends PhoneAuthState {}

class phoneOtpVerified extends PhoneAuthState {}
