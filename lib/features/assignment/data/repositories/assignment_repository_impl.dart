import 'package:immidart_assignment/features/assignment/data/datasources/assignment_remote_ds.dart';
import 'package:immidart_assignment/features/assignment/data/model/assignment_model.dart';
import 'package:immidart_assignment/features/assignment/data/model/country_model.dart';

abstract class AssignmentRepository {
  Future<List<CountryModel>> getCountries();
  Future<void> createAssignment(AssignmentModel model);
}

class AssignmentRepositoryImpl implements AssignmentRepository {
  final AssignmentRemoteDS remoteDS;

  AssignmentRepositoryImpl(this.remoteDS);

  @override
  Future<List<CountryModel>> getCountries() {
    return remoteDS.getCountries();
  }

  @override
  Future<void> createAssignment(AssignmentModel model) {
    return remoteDS.createAssignment(model);
  }
}
