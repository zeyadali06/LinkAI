part of 'profile_cubit.dart';

sealed class ProfileState {}

final class ProfileUpdate extends ProfileState {}
final class ProfileLoading extends ProfileState {}

class ProfileImagePicked extends ProfileState {

}

class ProfileImageError extends ProfileState {
  final String errorMessage;

  ProfileImageError(this.errorMessage);
}
