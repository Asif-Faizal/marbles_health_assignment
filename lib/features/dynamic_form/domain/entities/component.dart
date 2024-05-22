import 'package:equatable/equatable.dart';

class Component extends Equatable {
  final int id;

  Component(this.id);

  @override
  List<Object> get props => [id];
}
