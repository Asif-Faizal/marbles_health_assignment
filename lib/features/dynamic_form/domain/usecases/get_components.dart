import 'package:marble/core/usecases/usecase.dart';
import 'package:marble/features/dynamic_form/domain/repositiry/form_repositiry.dart';
import '../entities/component.dart';

class GetComponents implements UseCase<List<Component>, NoParams> {
  final FormRepository repository;

  GetComponents(this.repository);

  @override
  Future<List<Component>> call(NoParams params) async {
    return repository.getComponents();
  }
}

class NoParams {}
