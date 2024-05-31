class Medication {
  Medication({
    required this.name,
    required this.shortName,
    required this.regNo,
    required this.form,
    required this.substance,
    this.prohibitedOutComp,
    this.prohibitedInComp,
    this.prohibitedClass,
    this.notes,
    this.prohibitedSportsOutComp,
    this.prohibitedSportsInComp,
  });

  final String name;
  final String shortName;
  final String regNo;
  final String form;
  final String substance;
  final String? prohibitedOutComp;
  final String? prohibitedInComp;
  final String? prohibitedClass;
  final String? notes;
  final String? prohibitedSportsOutComp;
  final String? prohibitedSportsInComp;

  factory Medication.fromSupabase(Map<String, dynamic> data) {
    return Medication(
      name: data['medicine_name'] as String,
      shortName: data['short_name'] as String,
      regNo: data['authorisation_no'] as String,
      form: data['pharmaceutical_form_lv'] as String,
      substance: data['active_substance'] as String,
      prohibitedOutComp: data['Aizliegts ārpus sacensībām'] as String,
      prohibitedInComp: data['Aizliegts sacensību laikā'] as String,
      prohibitedClass:
          data['Aizliegto vielu un metožu saraksta klase'] as String,
      notes: data['Piezīmes par lietošanu'] as String,
      prohibitedSportsOutComp:
          data['Sporta veidi, kuros aizliegts ārpus sacensībām'] as String,
      prohibitedSportsInComp:
          data['Sporta veidi, kuros aizliegts sacensību laikā'] as String,
    );
  }
  String get formattedForm {
    return '${form[0].toLowerCase()}${form.substring(1)}';
  }
}
