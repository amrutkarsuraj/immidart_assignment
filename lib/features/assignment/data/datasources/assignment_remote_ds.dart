import '../../../../core/network/dio_client.dart';
import '../model/country_model.dart';
import '../model/assignment_model.dart';

class AssignmentRemoteDS {
  final DioClient dioClient;

  AssignmentRemoteDS(this.dioClient);

  Future<List<CountryModel>> getCountries() async {
    final response = await dioClient.dio.get('/countries');

    return (response.data as List)
        .map((e) => CountryModel.fromJson(e))
        .toList();
  }

  Future<void> createAssignment(AssignmentModel model) async {
    await dioClient.dio.post(
      '/assignment',
      data: model.toJson(),
    );
  }
}

