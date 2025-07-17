import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyt_app/data/models/local/language_model.dart';
import 'package:flyt_app/data/models/local/phrases_model.dart';
import 'package:flyt_app/presentation/core/model/arguments/phrases_add_args.dart';
import 'package:flyt_app/presentation/pages/phrases/phrases_item.dart';
import '../../../injector.dart';
import '../../core/constant/routes_values.dart';
import '../../core/handler/dialog_handler.dart';
import '../../core/model/static/language.dart';
import '../../core/widget/empty_state.dart';
import '../../core/widget/loading_state.dart';
import 'cubit/phrases_cubit.dart';
import 'cubit/phrases_state.dart';
import 'package:flutter_tts/flutter_tts.dart';

class PhrasesDetailPageProvider extends StatelessWidget {
  const PhrasesDetailPageProvider({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PhrasesCubit>(),
      child: PhrasesDetailPage(id: id),
    );
  }
}

class PhrasesDetailPage extends StatefulWidget {
  const PhrasesDetailPage({super.key, required this.id});
  final String id;
  @override
  State<PhrasesDetailPage> createState() => PhrasesDetailPageState();
}

enum TtsState { playing, stopped, paused, continued }

class PhrasesDetailPageState extends State<PhrasesDetailPage> {
  LanguageModel? language;
  String? searchQuery;
  late FocusNode searchFocusNode;

  late FlutterTts flutterTts;
  TtsState ttsState = TtsState.stopped;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;

  @override
  initState() {
    super.initState();
    refreshData();
    searchFocusNode = FocusNode();
    initTts();
  }

  dynamic initTts() {
    flutterTts = FlutterTts();

    _setAwaitOptions();

    if (isAndroid) {
      _getDefaultEngine();
      _getDefaultVoice();
    }

    flutterTts.setStartHandler(() {
      setState(() {
        print("Playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        print("Cancel");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setPauseHandler(() {
      setState(() {
        print("Paused");
        ttsState = TtsState.paused;
      });
    });

    flutterTts.setContinueHandler(() {
      setState(() {
        print("Continued");
        ttsState = TtsState.continued;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future<void> _getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      print(engine);
    }
  }

  Future<void> _getDefaultVoice() async {
    var voice = await flutterTts.getDefaultVoice;
    if (voice != null) {
      print(voice);
    }
  }

  Future<void> speak(String? message) async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (message != null) {
      if (message.isNotEmpty) {
        await flutterTts.speak(message);
        await _stop();
      }
    }
  }

  Future<void> _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
    String? languageId = languages.firstWhere((lang) => lang.name.toLowerCase() == language!.language.toLowerCase()).id;
    await flutterTts.setLanguage(languageId);
  }

  Future<void> _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  // Future<void> _pause() async {
  //   var result = await flutterTts.pause();
  //   if (result == 1) setState(() => ttsState = TtsState.paused);
  // }

  @override
  void dispose() {
    super.dispose();
    searchFocusNode.dispose();
    flutterTts.stop();
  }

  void refreshData() {
    language = context.read<PhrasesCubit>().getLanguage(widget.id);
    if (searchQuery?.isNotEmpty == true) {
      context.read<PhrasesCubit>().searchPhrases(widget.id, searchQuery!);
    } else {
      context.read<PhrasesCubit>().getAllPhrases(widget.id);
    }
    setState(() {});
  }

  void showDataWarning() {
    DialogHandler.showConfirmDialog(
      context: context,
      title: "Data Protection",
      description:
          "All data is stored locally on your device. Uninstalling or clearing the app will permanently delete it. Be sure to back up anything important.",
      confirmText: "I Understand",
      onConfirm: () => Navigator.pop(context),
      isCancelable: false,
    );
  }

  void navigatePhrasesAdd() {
    Navigator.pushNamed(
      context,
      RoutesValues.phrasesAdd,
      arguments: PhrasesAddArgs(languageId: widget.id),
    ).then((value) => refreshData());
  }

  void navigatePhrasesEdit(String id) {
    Navigator.pushNamed(
      context,
      RoutesValues.phrasesAdd,
      arguments: PhrasesAddArgs(id: id, languageId: widget.id),
    ).then((value) => refreshData());
  }

  Widget phrasesLoaded(List<PhrasesModel> phrases) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: phrases.length,
      itemBuilder: (context, index) {
        final item = phrases[index];
        return PhrasesItem(
            item: item,
            onTap: navigatePhrasesEdit,
            onSpeak: speak
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(language?.language ?? ''),
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(Icons.add_circle_outline_sharp),
              tooltip: 'Add',
              onPressed: navigatePhrasesAdd,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: 16,
            ),
            padding: const EdgeInsets.only(left: 8, right: 20),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(24.0)),
              color: Theme.of(context).hoverColor,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    focusNode: searchFocusNode,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      hintText: 'Search phrases..',
                      hintStyle: TextStyle(
                        color: Theme.of(context).iconTheme.color?.withAlpha(70),
                        fontWeight: FontWeight.normal,
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    onChanged: (query) {
                      searchQuery = query;
                      if (query.isEmpty) {
                        context.read<PhrasesCubit>().getAllPhrases(widget.id);
                      } else {
                        context.read<PhrasesCubit>().searchPhrases(
                          widget.id,
                          query,
                        );
                      }
                    },
                  ),
                ),
                const Icon(Icons.search_rounded, size: 26, weight: 10),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<PhrasesCubit, PhrasesCubitState>(
              builder: (context, state) {
                if (state is PhrasesInitial) {
                  return const SizedBox.shrink();
                } else if (state is PhrasesLoading) {
                  return const LoadingState();
                } else if (state is PhrasesEmpty) {
                  return EmptyState(
                    title: "No Records",
                    subtitle:
                        "You haven’t added any phrase. Once you do, they’ll appear here.",
                    tapText: "Add Phrase +",
                    onTap: navigatePhrasesAdd,
                    onLearn: showDataWarning,
                  );
                } else if (state is PhrasesLoaded) {
                  return phrasesLoaded(state.phrases);
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
