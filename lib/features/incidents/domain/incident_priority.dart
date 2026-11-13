enum IncidentPriority {
  low('low', 'Low'),
  medium('medium', 'Medium'),
  high('high', 'High'),
  critical('critical', 'Critical');

  const IncidentPriority(this.wireValue, this.label);

  final String wireValue;
  final String label;

  static IncidentPriority fromWire(String? value) {
    return IncidentPriority.values.firstWhere(
      (priority) => priority.wireValue == value || priority.name == value,
      orElse: () => IncidentPriority.medium,
    );
  }
}
