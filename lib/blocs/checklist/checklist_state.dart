class ChecklistState {
  final String filterChecklist;
  final List<dynamic> checklists;

  ChecklistState({
    required this.filterChecklist,
    required this.checklists,
  });

  factory ChecklistState.initial() {
    return ChecklistState(filterChecklist: '', checklists: []);
  }

  ChecklistState copyWith({
    String? filterChecklist,
    List<dynamic>? checklists,
  }) {
    return ChecklistState(
      filterChecklist: filterChecklist ?? this.filterChecklist,
      checklists: checklists ?? this.checklists,
    );
  }
}
