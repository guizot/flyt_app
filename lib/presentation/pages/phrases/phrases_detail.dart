import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flyt_app/data/models/local/language_model.dart';
import 'package:flyt_app/data/models/local/phrases_model.dart';
import 'package:flyt_app/presentation/core/model/arguments/phrases_add_args.dart';
import 'package:flyt_app/presentation/pages/phrases/phrases_item.dart';
import '../../../injector.dart';
import '../../core/constant/routes_values.dart';
import '../../core/handler/dialog_handler.dart';
import '../../core/widget/empty_state.dart';
import '../../core/widget/loading_state.dart';
import 'cubit/phrases_cubit.dart';
import 'cubit/phrases_state.dart';

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

class PhrasesDetailPageState extends State<PhrasesDetailPage> {

  LanguageModel? language;
  String? searchQuery;
  late FocusNode searchFocusNode;

  late FlutterTts flutterTts;
  bool _isTtsInitialized = false;

  @override
  void initState() {
    super.initState();
    searchFocusNode = FocusNode();
    refreshData();
  }

  void refreshData() {
    language = context.read<PhrasesCubit>().getLanguage(widget.id);
    if (searchQuery?.isNotEmpty == true) {
      context.read<PhrasesCubit>().searchPhrases(widget.id, searchQuery!);
    } else {
      context.read<PhrasesCubit>().getAllPhrases(widget.id);
    }
  }

  Future<void> initTextToSpeech(String languageId) async {
    flutterTts = FlutterTts();

    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.setLanguage(languageId);

    if (!kIsWeb && Platform.isAndroid) {
      _getDefaultEngine();
      _getDefaultVoice();
    }

    flutterTts.setStartHandler(() {
      debugPrint("Playing");
    });

    flutterTts.setCompletionHandler(() {
      debugPrint("Complete");
    });

    flutterTts.setCancelHandler(() {
      debugPrint("Cancel");
    });

    flutterTts.setPauseHandler(() {
      debugPrint("Paused");
    });

    flutterTts.setContinueHandler(() {
      debugPrint("Continued");
    });

    flutterTts.setErrorHandler((msg) {
      debugPrint("error: $msg");
    });
  }

  Future<void> _getDefaultEngine() async {
    final engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      debugPrint(engine);
    }
  }

  Future<void> _getDefaultVoice() async {
    final voice = await flutterTts.getDefaultVoice;
    if (voice != null) {
      debugPrint(voice.toString());
    }
  }

  Future<void> speak(String? message) async {
    if (!_isTtsInitialized) {
      await initTextToSpeech(language!.languageId);
      _isTtsInitialized = true;
    }

    await flutterTts.setVolume(0.5);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1.0);

    if (message?.isNotEmpty == true) {
      await flutterTts.speak(message!);
    }
  }

  Future<void> stopTextToSpeech() async {
    try {
      await flutterTts.stop();
    } catch(e) {
      debugPrint(e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    stopTextToSpeech();
    searchFocusNode.dispose();
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
            onSpeak: (message) => speak(message)
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
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Column(
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
                border: Border.all(
                  color: Theme.of(context).colorScheme.shadow,
                  width: 1,
                ),
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
        )
      ),
    );
  }
}
