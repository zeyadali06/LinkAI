import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileUpdate());
  static ProfileCubit get(context) => context.read<ProfileCubit>();
  void updateProfile() {
    emit(ProfileUpdate());
  }
}
