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
              colorScheme: ColorScheme.light(
                primary: Colors.black,
                onPrimary: Colors.white,
                surface: HexColor('f6f6f6'),
                onSurface: Colors.black,
                shadow: HexColor('e6e6e7')
              ),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              textTheme: const TextTheme(
                bodyMedium: TextStyle(color: Colors.black),
              ),
              hoverColor: HexColor('ffffff'),
              fontFamily: 'Poppins',
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.dark(
                primary: Colors.white,
                onPrimary: Colors.black,
                surface: HexColor('0e0e0e'),
                onSurface: Colors.white,
                shadow: HexColor('272729')
              ),
              scaffoldBackgroundColor: Colors.black,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              textTheme: const TextTheme(
                bodyMedium: TextStyle(color: Colors.white),
              ),
              hoverColor: HexColor('1a1a1a'),
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
