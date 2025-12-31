import 'package:immidart_assignment/features/assignment/data/model/assignment_model.dart';
import 'package:immidart_assignment/features/assignment/data/model/country_model.dart';
import 'package:immidart_assignment/features/assignment/data/repositories/assignment_repository_impl.dart';

class GetCountries {
  final AssignmentRepository repo;
  GetCountries(this.repo);

  Future<List<CountryModel>> call() => repo.getCountries();
}

class CreateAssignment {
  final AssignmentRepository repo;
  CreateAssignment(this.repo);

  Future<void> call(AssignmentModel model) =>
      repo.createAssignment(model);
}
