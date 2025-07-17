import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../data/models/local/language_model.dart';
import '../../../injector.dart';
import '../../core/handler/dialog_handler.dart';
import '../../core/model/static/language.dart';
import '../../core/widget/drop_down_item.dart';
import '../../core/widget/loading_state.dart';
import 'cubit/phrases_cubit.dart';
import 'cubit/phrases_state.dart';

class LanguageAddProvider extends StatelessWidget {
  const LanguageAddProvider({super.key, this.id});
  final String? id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PhrasesCubit>(),
      child: LanguageAdd(id: id),
    );
  }
}

class LanguageAdd extends StatefulWidget {
  const LanguageAdd({super.key, this.id});
  final String? id;
  @override
  State<LanguageAdd> createState() => _LanguageAddState();
}

class _LanguageAddState extends State<LanguageAdd> {
  TextEditingController languageController = TextEditingController();
  LanguageModel? phrases;

  Map<String, String> populateForm() {
    return {'language': languageController.text};
  }

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      phrases = BlocProvider.of<PhrasesCubit>(context).getLanguage(widget.id!);
      if (phrases != null) {
        setState(() {
          languageController.text = phrases!.language;
        });
      }
    }
  }

  void validateForm() {
    final formData = populateForm();
    if (formData['language']!.trim().isEmpty) {
      DialogHandler.showSnackBar(
        context: context,
        message: "Language cannot be empty",
      );
      return;
    }
    if (widget.id != null) {
      showSaveDialog(context, formData);
    } else {
      onSubmit(context, formData);
    }
  }

  void onSubmit(BuildContext context, Map<String, String> data) async {
    try {
      await BlocProvider.of<PhrasesCubit>(context).saveLanguage(
        LanguageModel(
          id: widget.id != null ? widget.id! : const Uuid().v4(),
          language: data['language']!,
          createdAt: widget.id != null ? phrases!.createdAt : DateTime.now(),
        ),
      );
      if (context.mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (context.mounted) {
        DialogHandler.showSnackBar(context: context, message: "Error: $e");
      }
    }
  }

  void showSaveDialog(BuildContext context, Map<String, String> data) {
    DialogHandler.showConfirmDialog(
      context: context,
      title: "Confirmation",
      description:
          "We’ll save your updates so everything stays up to date. You can always make changes later.",
      confirmText: "Yes, save",
      onConfirm: () {
        Navigator.pop(context);
        onSubmit(context, data);
      },
    );
  }

  void onDelete(BuildContext context) async {
    await BlocProvider.of<PhrasesCubit>(context).deleteLanguage(widget.id!);
    if (context.mounted) {
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  void showDeleteDialog(BuildContext context) {
    DialogHandler.showConfirmDialog(
      context: context,
      title: "Confirmation",
      description:
          "Deleting this will erase all related data and cannot be undone. Make sure this is what you really want to do.",
      confirmText: "Yes, delete",
      onConfirm: () => onDelete(context),
    );
  }

  Widget phrasesInitial(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              DropDownItem(
                title: "Language",
                controller: languageController,
                items: languages
                    .map((c) => {'title': c.name, 'icon': c.icon})
                    .toList(),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
          width: double.infinity,
          child: FilledButton(
            onPressed: validateForm,
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).iconTheme.color,
              padding: const EdgeInsets.all(16.0),
            ),
            child: Text(widget.id == null ? "Submit" : "Save"),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.id == null ? "Add" : "Edit"} Language"),
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        actions: widget.id == null
            ? null
            : [
                Container(
                  margin: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    icon: const Icon(Icons.delete_forever_rounded),
                    tooltip: 'Delete',
                    onPressed: () => showDeleteDialog(context),
                  ),
                ),
              ],
      ),
      body: BlocBuilder<PhrasesCubit, PhrasesCubitState>(
        builder: (blocContext, state) {
          if (state is PhrasesInitial) {
            return phrasesInitial(context);
          } else if (state is PhrasesLoading) {
            return const LoadingState();
          }
          return Container();
        },
      ),
    );
  }
}
