import 'package:equatable/equatable.dart';

class Component extends Equatable {
  final int id;
  final String label;
  final String infoText;
  final String settings;

  const Component({
    required this.id,
    required this.label,
    required this.infoText,
    required this.settings,
  });

  @override
  List<Object> get props => [id, label, infoText, settings];

  Component copyWith({
    int? id,
    String? label,
    String? infoText,
    String? settings,
  }) {
    return Component(
      id: id ?? this.id,
      label: label ?? this.label,
      infoText: infoText ?? this.infoText,
      settings: settings ?? this.settings,
    );
  }
}
