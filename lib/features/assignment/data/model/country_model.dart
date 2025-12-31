class CountryModel {
  final String name;
  final bool isInternational;

  CountryModel({required this.name, required this.isInternational});

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      name: json['name'],
      isInternational: json['isInternational'],
    );
  }
}
