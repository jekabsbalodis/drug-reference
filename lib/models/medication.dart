class Medication {
  Medication({
    required this.name,
    required this.shortName,
    required this.regNo,
    required this.form,
    required this.substance,
    required this.strength,
    required this.prohibitedOutComp,
    required this.prohibitedInComp,
    required this.prohibitedClass,
    required this.notes,
    required this.prohibitedSportsOutComp,
    required this.prohibitedSportsInComp,
  });

  final String name;
  final String shortName;
  final String regNo;
  final String form;
  final String substance;
  final String strength;
  final String prohibitedOutComp;
  final String prohibitedInComp;
  final String prohibitedClass;
  final String notes;
  final String prohibitedSportsOutComp;
  final String prohibitedSportsInComp;

  factory Medication.fromSupabase(Map<String, dynamic> data) {
    return Medication(
      name: data['medicine_name'] as String,
      shortName: data['short_name'] as String,
      regNo: data['authorisation_no'] as String,
      form: data['pharmaceutical_form_lv'] as String,
      substance: data['active_substance'] as String,
      strength: data['strength_lv'] as String,
      prohibitedOutComp: data['aizliegts_arpus_sacensibam'] as String,
      prohibitedInComp: data['aizliegts_sacensibu_laika'] as String,
      prohibitedClass:
          data['aizliegto_vielu_un_metozu_saraksta_klase'] as String,
      notes: data['piezimes_par_lietosanu'] as String,
      prohibitedSportsOutComp:
          data['sporta_veidi_kuros_aizliegts_arpus_sacensibam'] as String,
      prohibitedSportsInComp:
          data['sporta_veidi_kuros_aizliegts_sacensibu_laika'] as String,
    );
  }
  String get formattedForm {
    return '${form[0].toLowerCase()}${form.substring(1)}';
  }
}
