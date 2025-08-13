abstract class ChecklistEvent{}

class filteredChecklist extends ChecklistEvent{
  final String query;
  filteredChecklist({required this.query});
}

class loadChecklists extends ChecklistEvent {}