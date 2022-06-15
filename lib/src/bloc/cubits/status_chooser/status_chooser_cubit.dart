import 'package:bloc/bloc.dart';

class StatusChooserCubit extends Cubit<String> {
  StatusChooserCubit(this.initStatus) : super(initStatus);

  final String initStatus;

  void changeStatus(String status) {
    emit(status);
  }
}
