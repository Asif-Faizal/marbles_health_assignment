import 'package:marble/features/dynamic_form/domain/entities/component.dart';

abstract class FormRepository {
  List<Component> getComponents();
  void addComponent();
  void removeComponent(int index);
}
