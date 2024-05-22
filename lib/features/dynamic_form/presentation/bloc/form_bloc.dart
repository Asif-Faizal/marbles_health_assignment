// lib/features/dynamic_form/presentation/bloc/form_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:marble/features/dynamic_form/domain/usecases/add-component.dart';
import '../../domain/usecases/get_components.dart';
import '../../domain/usecases/remove_component.dart';
import 'form_event.dart';
import 'form_state.dart';

class FormBloc extends Bloc<FormEvent, FormState> {
  final GetComponents getComponents;
  final AddComponent addComponent;
  final RemoveComponent removeComponent;

  FormBloc({
    required this.getComponents,
    required this.addComponent,
    required this.removeComponent,
  }) : super(FormState()) {
    on<AddComponentEvent>((event, emit) async {
      addComponent(NoParams());
      emit(state.copyWith(components: await getComponents(NoParams())));
    });

    on<RemoveComponentEvent>((event, emit) async {
      removeComponent(Params(event.index));
      emit(state.copyWith(components: await getComponents(NoParams())));
    });

    on<SubmitFormEvent>((event, emit) async {
      // Handle form submission logic here
      print("Form submitted with components: ${state.components}");
    });
  }
}
