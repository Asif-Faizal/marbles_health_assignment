import 'package:marble/features/dynamic_form/domain/repositiry/form_repositiry.dart';

import '../../domain/entities/component.dart';

class FormRepositoryImpl implements FormRepository {
  List<Component> _components = [
    Component(id: 0, label: '', infoText: '', settings: 'Required')
  ];

  @override
  List<Component> getComponents() => List.unmodifiable(_components);

  @override
  void addComponent() {
    int newId = _components.length;
    _components.add(Component(
      id: newId,
      label: '',
      infoText: '',
      settings: 'Required',
    ));
  }

  @override
  void removeComponent(int index) {
    if (_components.length > 1) {
      _components.removeAt(index);
    }
  }
}
