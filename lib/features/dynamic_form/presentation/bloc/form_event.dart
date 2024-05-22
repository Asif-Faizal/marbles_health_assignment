import 'package:equatable/equatable.dart';
import '../../domain/entities/component.dart';

abstract class FormEvent extends Equatable {
  const FormEvent();
}

class AddComponentEvent extends FormEvent {
  @override
  List<Object> get props => [];
}

class RemoveComponentEvent extends FormEvent {
  final int index;

  RemoveComponentEvent(this.index);

  @override
  List<Object> get props => [index];
}

class SubmitFormEvent extends FormEvent {
  @override
  List<Object> get props => [];
}

class UpdateComponentEvent extends FormEvent {
  final int index;
  final Component component;

  UpdateComponentEvent(this.index, this.component);

  @override
  List<Object> get props => [index, component];
}
