import 'package:get_it/get_it.dart';
import 'package:flyt_app/data/repositories/hive_repo_impl.dart';
import 'package:flyt_app/domain/repositories/hive_repo.dart';
import 'package:flyt_app/presentation/core/service/theme_service.dart';
import 'package:flyt_app/presentation/pages/trip/cubit/trip_cubit.dart';
import 'package:flyt_app/presentation/pages/packing/cubit/packing_cubit.dart';
import 'package:flyt_app/presentation/pages/phrases/cubit/phrases_cubit.dart';
import 'package:flyt_app/presentation/pages/traveler/cubit/traveler_cubit.dart';
import 'data/datasource/local/hive_data_source.dart';
import 'data/datasource/shared/shared_preferences_data_source.dart';
import 'domain/usecases/trip_usecases.dart';
import 'domain/usecases/packing_usecases.dart';
import 'domain/usecases/phrases_usecases.dart';
import 'domain/usecases/traveler_usecases.dart';

final sl = GetIt.I;

Future<void> init() async {

  /// SERVICES
  sl.registerLazySingleton(
    () => ThemeService(
      sharedPreferenceDataSource: sl(),
    ),
  );

  /// PRESENTATION LAYER
  sl.registerFactory(
    () => TripCubit(
      tripUseCases: sl(),
    ),
  );
  sl.registerFactory(
    () => TravelerCubit(
      travelerUseCases: sl(),
    ),
  );
  sl.registerFactory(
    () => PackingCubit(
      packingUseCases: sl(),
    ),
  );
  sl.registerFactory(
    () => PhrasesCubit(
      phrasesUseCases: sl(),
    ),
  );

  /// DOMAIN LAYER
  sl.registerLazySingleton(
    () => TripUseCases(
      hiveRepo: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => TravelerUseCases(
      hiveRepo: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => PackingUseCases(
      hiveRepo: sl(),
    ),
  );
  sl.registerLazySingleton(
    () => PhrasesUseCases(
      hiveRepo: sl(),
    ),
  );

  /// DATA LAYER
  sl.registerLazySingleton<HiveRepo>(
    () => HiveRepoImpl(
      hiveDataSource: sl()
    ),
  );

  /// MAIN INJECTOR & EXTERNAL LIBRARY
  sl.registerLazySingleton(() => HiveDataSource());
  sl.registerLazySingleton(() => SharedPreferenceDataSource());

}