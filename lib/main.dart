import 'package:flutter/material.dart';
import 'package:flyt_app/presentation/core/extension/color_extension.dart';
import 'package:provider/provider.dart';
import 'package:flyt_app/presentation/core/service/route_service.dart';
import 'package:flyt_app/presentation/core/service/theme_service.dart';
import 'package:flyt_app/injector.dart' as di;
import 'data/datasource/local/hive_data_source.dart';
import 'injector.dart';

void main() async {

  /// ENSURE INITIALIZED
  WidgetsFlutterBinding.ensureInitialized();

  /// INIT HIVE LOCAL DATABASE
  await HiveDataSource.init();

  /// INIT DEPENDENCY INJECTION
  await di.init();

  /// RUN APP
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => sl<ThemeService>(),
        )
      ],
      child: Consumer<ThemeService> (
        builder: (context, ThemeService themeService, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flyt',
            // theme: themeService.currentThemeData(ThemeServiceValues.light),
            // darkTheme: themeService.currentThemeData(ThemeServiceValues.dark),
            theme: ThemeData(
              colorScheme: const ColorScheme.light(
                primary: Colors.black,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              textTheme: const TextTheme(
                bodyMedium: TextStyle(color: Colors.black),
              ),
              hoverColor: HexColor('e6e6e6').withValues(alpha: 0.5),
              fontFamily: 'Poppins',
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              colorScheme: const ColorScheme.dark(
                primary: Colors.white,
                onPrimary: Colors.black,
                surface: Colors.black,
                onSurface: Colors.white,
              ),
              scaffoldBackgroundColor: Colors.black,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              textTheme: const TextTheme(
                bodyMedium: TextStyle(color: Colors.white),
              ),
              hoverColor: HexColor('2e2e2e').withValues(alpha: 0.5),
              fontFamily: 'Poppins',
              useMaterial3: true,
            ),
            themeMode: themeService.currentThemeMode,
            onGenerateRoute: RouteService.generate,
          );
        },
      ),
    );

  }

}
