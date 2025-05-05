
import 'package:flutter/foundation.dart';

@immutable
sealed class UserSignupState {}

final class UserSignupInitial extends UserSignupState {}

final class UserSignupLoading extends UserSignupState {}

final class UserSignupLoaded extends UserSignupState {}

final class UserSignupError extends UserSignupState {}
