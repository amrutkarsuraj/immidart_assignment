class AssignmentModel {
  final String employeeName;
  final String country;
  final String startDate;
  final String? visaType;

  AssignmentModel({
    required this.employeeName,
    required this.country,
    required this.startDate,
    this.visaType,
  });

  Map<String, dynamic> toJson() => {
    "employeeName": employeeName,
    "country": country,
    "startDate": startDate,
    "visaType": visaType,
  };
}
