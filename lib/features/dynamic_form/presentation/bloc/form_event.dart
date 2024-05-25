import 'package:equatable/equatable.dart';
import '../../domain/entities/component.dart';

abstract class FormEvent extends Equatable {
  const FormEvent();

  @override
  List<Object> get props => [];
}

class AddComponentEvent extends FormEvent {}

class RemoveComponentEvent extends FormEvent {
  final int index;
  final Component component;

  const RemoveComponentEvent(this.index, this.component);

  @override
  List<Object> get props => [index, component];
}

class SubmitFormEvent extends FormEvent {}

class ResetFormEvent extends FormEvent {}

class UpdateComponentEvent extends FormEvent {
  final int index;
  final Component component;

  const UpdateComponentEvent({required this.index, required this.component});

  @override
  List<Object> get props => [index, component];
}
