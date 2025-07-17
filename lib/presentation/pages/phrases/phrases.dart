import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyt_app/presentation/pages/phrases/language_item.dart';

import '../../../data/models/local/language_model.dart';
import '../../../injector.dart';
import '../../core/constant/routes_values.dart';
import '../../core/handler/dialog_handler.dart';
import '../../core/widget/empty_state.dart';
import '../../core/widget/loading_state.dart';
import 'cubit/phrases_cubit.dart';
import 'cubit/phrases_state.dart';

class PhrasesPageProvider extends StatelessWidget {
  const PhrasesPageProvider({super.key, this.pageKey});
  final Key? pageKey;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PhrasesCubit>(),
      child: PhrasesPage(key: pageKey),
    );
  }
}

class PhrasesPage extends StatefulWidget {
  const PhrasesPage({super.key});
  @override
  State<PhrasesPage> createState() => PhrasesPageState();
}

class PhrasesPageState extends State<PhrasesPage> {
  @override
  void initState() {
    super.initState();
    context.read<PhrasesCubit>().getAllLanguage();
  }

  void refreshData() {
    context.read<PhrasesCubit>().getAllLanguage();
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
      RoutesValues.languageAdd,
    ).then((value) => refreshData());
  }

  void navigatePhrasesDetail(String id) {
    Navigator.pushNamed(
      context,
      RoutesValues.phrasesDetail,
      arguments: id,
    ).then((value) => refreshData());
  }

  Widget phrasesLoaded(List<LanguageModel> phrases) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: phrases.length,
      itemBuilder: (context, index) {
        final item = phrases[index];
        return Dismissible(
          key: Key(item.id),
          direction: DismissDirection.endToStart,
          background: Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            // Match the vertical spacing between items
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(24.0)),
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: const Icon(Icons.delete, color: Colors.white, size: 32),
          ),
          confirmDismiss: (direction) async {
            final result = await DialogHandler.showConfirmBottomSheet(
              context: context,
              title: 'Confirmation',
              description:
                  'Are you sure you want to delete this language? This action cannot be undone.',
              confirmText: 'Delete',
              cancelText: 'Cancel',
            );
            return result == true;
          },
          onDismissed: (direction) async {
            await context.read<PhrasesCubit>().deleteLanguage(item.id);
            if (context.mounted) {
              DialogHandler.showSnackBar(
                context: context,
                message: "Language deleted",
              );
            }
            refreshData();
          },
          child: LanguageItem(item: item, onTap: navigatePhrasesDetail),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhrasesCubit, PhrasesCubitState>(
      builder: (context, state) {
        if (state is PhrasesInitial) {
          return const SizedBox.shrink();
        } else if (state is PhrasesLoading) {
          return const LoadingState();
        } else if (state is PhrasesEmpty) {
          return EmptyState(
            title: "No Records",
            subtitle:
                "You haven’t added any language. Once you do, they’ll appear here.",
            tapText: "Add Language +",
            onTap: navigatePhrasesAdd,
            onLearn: showDataWarning,
          );
        } else if (state is LanguageLoaded) {
          return phrasesLoaded(state.languages);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
