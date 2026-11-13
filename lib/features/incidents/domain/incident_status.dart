/// Status flow: Submitted -> Under Review -> In Progress -> Resolved.
enum IncidentStatus {
  submitted('submitted', 'Submitted'),
  underReview('under_review', 'Under Review'),
  inProgress('in_progress', 'In Progress'),
  resolved('resolved', 'Resolved');

  const IncidentStatus(this.wireValue, this.label);

  final String wireValue;
  final String label;

  static IncidentStatus fromWire(String? value) {
    return IncidentStatus.values.firstWhere(
      (status) => status.wireValue == value || status.name == value,
      orElse: () => IncidentStatus.submitted,
    );
  }
}
