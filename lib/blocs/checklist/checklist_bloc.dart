import 'package:flyinsky/blocs/checklist/checklist_state.dart';
import 'package:flyinsky/blocs/checklist/checklist_event.dart';
import 'package:flyinsky/repository/checklist_repository.dart';
import 'package:bloc/bloc.dart';

class ChecklistBloc extends Bloc<ChecklistEvent, ChecklistState>{
  final CheckListRepository checklistrepository;
  ChecklistBloc({required this.checklistrepository}):super(ChecklistState.initial()){
    on<loadChecklists>((event, emit)async{
      try{
        final checklists=await checklistrepository.filter_aircrafts('');
        emit(state.copyWith(checklists: checklists));
      }catch(e){
        print(e);
      }
    });
    on<filteredChecklist>((event, emit)async{
      emit(state.copyWith(filterChecklist: event.query));
      final filtered_checklists=await checklistrepository.filter_aircrafts(state.filterChecklist);
      emit(state.copyWith(checklists: filtered_checklists));
    });
  }
}