import 'package:bloc/bloc.dart';
import 'package:todo_app/src/domain/entities/task.dart';

class SearchTasksCubit extends Cubit<List<Task>> {
  SearchTasksCubit() : super([]);

  List<Task> filteredTasks = [];

  void filterTasks(String filterText, List<Task> unfilteredTasks) {
    emit(unfilteredTasks.where((i) {
      return i.title.toLowerCase().contains(filterText.toLowerCase());
    }).toList());
  }
}
