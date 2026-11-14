/// Status flow: Submitted -> Under Review -> In Progress -> Resolved.
enum IncidentStatus {
  submitted('submitted', 'Submitted'),
  underReview('under_review', 'Under Review'),
  inProgress('in_progress', 'In Progress'),
  resolved('resolved', 'Resolved');

  const IncidentStatus(this.wireValue, this.label);

  final String wireValue;
  final String label;

  /// List cards in the design say "Pending" for a newly submitted report.
  String get badgeLabel =>
      this == IncidentStatus.submitted ? 'Pending' : label;

  bool get isPending =>
      this == IncidentStatus.submitted || this == IncidentStatus.underReview;

  static IncidentStatus fromWire(String? value) {
    return IncidentStatus.values.firstWhere(
      (status) => status.wireValue == value || status.name == value,
      orElse: () => IncidentStatus.submitted,
    );
  }
}
