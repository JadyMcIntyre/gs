import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMenuCubit extends Cubit<bool> {
  HomeMenuCubit() : super(false);

  void setOpen(bool isOpen) {
    emit(isOpen);
  }
}
