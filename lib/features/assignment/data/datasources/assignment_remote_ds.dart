import 'package:immidart_assignment/core/network/dio_client.dart' show DioClient;
import 'package:immidart_assignment/features/assignment/data/model/assignment_model.dart';
import 'package:immidart_assignment/features/assignment/data/model/country_model.dart';

class AssignmentRemoteDS {
  Future<List<CountryModel>> getCountries() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      CountryModel(name: 'India', isInternational: false),
      CountryModel(name: 'USA', isInternational: true),
      CountryModel(name: 'Germany', isInternational: true),
      CountryModel(name: 'Australia', isInternational: true),
    ];
  }

  Future<void> createAssignment(AssignmentModel model) async {
    await Future.delayed(const Duration(seconds: 1));
    return;
  }
}

