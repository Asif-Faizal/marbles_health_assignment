import 'package:equatable/equatable.dart';
import '../../domain/entities/component.dart';

class FormState extends Equatable {
  final List<Component> components;

  FormState({List<Component>? components})
      : components = components ?? [Component(0)];

  FormState copyWith({List<Component>? components}) {
    return FormState(components: components ?? this.components);
  }

  @override
  List<Object> get props => [components];
}

class FormSubmittedState extends FormState {
  final List<Component> components;
  FormSubmittedState({required this.components});

  @override
  List<Object> get props => [components];
}
