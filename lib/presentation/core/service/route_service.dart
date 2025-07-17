import 'package:flutter/material.dart';
import 'package:flyt_app/presentation/core/model/arguments/phrases_add_args.dart';
import 'package:flyt_app/presentation/pages/event/event_add.dart';
import 'package:flyt_app/presentation/pages/packing/packing_add.dart';
import 'package:flyt_app/presentation/pages/phrases/language_add.dart';
import 'package:flyt_app/presentation/pages/phrases/phrases_detail.dart';
import 'package:flyt_app/presentation/pages/traveler/traveler_add.dart';
import '../../pages/home.dart';
import '../../pages/phrases/phrases_add.dart';
import '../../pages/setting/setting.dart';
import '../constant/routes_values.dart';

class RouteService {

  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {
      case RoutesValues.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case RoutesValues.travelerAdd:
        var id = settings.arguments as String?;
        return MaterialPageRoute(builder: (_) => TravelerAddProvider(id: id));
      case RoutesValues.packingAdd:
        var id = settings.arguments as String?;
        return MaterialPageRoute(builder: (_) => PackingAddProvider(id: id));
      case RoutesValues.languageAdd:
        var id = settings.arguments as String?;
        return MaterialPageRoute(builder: (_) => LanguageAddProvider(id: id));
      case RoutesValues.phrasesDetail:
        var id = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => PhrasesDetailPageProvider(id: id));
      case RoutesValues.phrasesAdd:
        var args = settings.arguments as PhrasesAddArgs;
        return MaterialPageRoute(builder: (_) => PhrasesAddProvider(item: args));
      case RoutesValues.eventAdd:
        var id = settings.arguments as String?;
        return MaterialPageRoute(builder: (_) => EventAddProvider(id: id));
      case RoutesValues.setting:
        return MaterialPageRoute(builder: (_) => const SettingPage());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            appBar: AppBar(title: const Text("Error")),
            body: const Center(child: Text('Error page')),
          );
        });
    }
  }

}