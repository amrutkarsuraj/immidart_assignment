import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:immidart_assignment/core/network/dio_client.dart';
import 'package:immidart_assignment/features/assignment/data/datasources/assignment_remote_ds.dart';
import 'package:immidart_assignment/features/assignment/data/model/assignment_model.dart';
import 'package:immidart_assignment/features/assignment/data/repositories/assignment_repository_impl.dart';
import 'package:immidart_assignment/features/assignment/domain/usecases/get_countries.dart';

final dioProvider = Provider((ref) => DioClient());

final repositoryProvider = Provider<AssignmentRepository>(
      (ref) => AssignmentRepositoryImpl(
    AssignmentRemoteDS(
      ref.read(dioProvider),
    ),
  ),
);

final showVisaProvider = StateProvider<bool>((ref) => false);


final countriesProvider = FutureProvider((ref) {
  return GetCountries(ref.read(repositoryProvider)).call();
});

final assignmentSubmitProvider =
StateNotifierProvider<AssignmentNotifier, AsyncValue<void>>(
      (ref) => AssignmentNotifier(ref.read(repositoryProvider)),
);

class AssignmentNotifier extends StateNotifier<AsyncValue<void>> {
  final AssignmentRepository repo;

  AssignmentNotifier(this.repo) : super(const AsyncData(null));

  Future<void> submit(AssignmentModel model) async {
    state = const AsyncLoading();
    try {
      await repo.createAssignment(model);
      state = const AsyncData(null);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
