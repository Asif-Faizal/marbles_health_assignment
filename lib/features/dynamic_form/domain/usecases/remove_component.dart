import 'package:marble/core/usecases/usecase.dart';
import 'package:marble/features/dynamic_form/domain/entities/component.dart';
import 'package:marble/features/dynamic_form/domain/repositiry/form_repositiry.dart';

class RemoveComponent implements UseCase<void, Params> {
  final FormRepository repository;

  RemoveComponent(this.repository);

  @override
  Future<void> call(Params params) async {
    repository.removeComponent(params.index);
  }
}

class Params {
  final int index;

  Params(this.index, Component component);
}
