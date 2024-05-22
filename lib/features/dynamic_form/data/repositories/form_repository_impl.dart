import 'package:marble/features/dynamic_form/domain/repositiry/form_repositiry.dart';
import '../../domain/entities/component.dart';

class FormRepositoryImpl implements FormRepository {
  List<Component> _components = [Component(0)];

  @override
  List<Component> getComponents() => List.unmodifiable(_components);

  @override
  void addComponent() {
    _components.add(Component(_components.length));
  }

  @override
  void removeComponent(int index) {
    if (_components.length > 1) {
      _components.removeAt(index);
    }
  }
}
