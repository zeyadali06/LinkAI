import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:linkai/core/models/user_model.dart';

import '../../../../../core/failures/request_result.dart';
import '../../../domain/useCases/addProfileImageUseCase/add_profile_image.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AddProfileImageUseCase _addProfileImageUseCase;

  ProfileCubit(this._addProfileImageUseCase) : super(ProfileUpdate());

  static ProfileCubit get(context) => context.read<ProfileCubit>();

  void updateProfile() {
    emit(ProfileUpdate());
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {

      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        emit(ProfileLoading());
        final result = await _addProfileImageUseCase.call(image);

        if (result is Failed) {
          emit(ProfileImageError(result.data.message));
        } else {
          emit(ProfileImagePicked());
        }
      } else {
        emit(ProfileImageError("No image selected"));
      }
    } catch (e) {
      emit(ProfileImageError("Failed to pick image"));
    }
  }

}
