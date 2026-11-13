enum IncidentCategory {
  water('water', 'Water'),
  electricity('electricity', 'Electricity'),
  wifi('wifi', 'Wi-Fi'),
  furniture('furniture', 'Furniture'),
  sanitation('sanitation', 'Sanitation'),
  safety('safety', 'Safety'),
  other('other', 'Other');

  const IncidentCategory(this.wireValue, this.label);

  final String wireValue;
  final String label;

  static IncidentCategory fromWire(String? value) {
    return IncidentCategory.values.firstWhere(
      (category) => category.wireValue == value || category.name == value,
      orElse: () => IncidentCategory.other,
    );
  }
}
