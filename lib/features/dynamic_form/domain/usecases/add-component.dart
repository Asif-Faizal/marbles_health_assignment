import 'package:marble/core/usecases/usecase.dart';
import 'package:marble/features/dynamic_form/domain/repositiry/form_repositiry.dart';
import 'package:marble/features/dynamic_form/domain/usecases/get_components.dart';

class AddComponent implements UseCase<void, NoParams> {
  final FormRepository repository;

  AddComponent(this.repository);

  @override
  Future<void> call(NoParams params) async {
    repository.addComponent();
  }
}
