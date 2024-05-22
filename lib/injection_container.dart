// lib/injection_container.dart
import 'package:get_it/get_it.dart';
import 'package:marble/features/dynamic_form/domain/repositiry/form_repositiry.dart';
import 'package:marble/features/dynamic_form/domain/usecases/add-component.dart';
import 'features/dynamic_form/data/repositories/form_repository_impl.dart';
import 'features/dynamic_form/domain/usecases/get_components.dart';
import 'features/dynamic_form/domain/usecases/remove_component.dart';
import 'features/dynamic_form/presentation/bloc/form_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Repository
  sl.registerLazySingleton<FormRepository>(() => FormRepositoryImpl());

  // Use cases
  sl.registerLazySingleton(() => GetComponents(sl()));
  sl.registerLazySingleton(() => AddComponent(sl()));
  sl.registerLazySingleton(() => RemoveComponent(sl()));

  // Bloc
  sl.registerFactory(() => FormBloc(
        getComponents: sl(),
        addComponent: sl(),
        removeComponent: sl(),
      ));
}
