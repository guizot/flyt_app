import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyt_app/data/models/local/phrases_model.dart';
import 'package:flyt_app/presentation/core/widget/text_field_item.dart';
import 'package:uuid/uuid.dart';
import '../../../injector.dart';
import '../../core/handler/dialog_handler.dart';
import '../../core/model/arguments/phrases_add_args.dart';
import '../../core/widget/loading_state.dart';
import 'cubit/phrases_cubit.dart';
import 'cubit/phrases_state.dart';

class PhrasesAddProvider extends StatelessWidget {
  const PhrasesAddProvider({super.key, required this.item});
  final PhrasesAddArgs item;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PhrasesCubit>(),
      child: PhrasesAdd(item: item),
    );
  }
}

class PhrasesAdd extends StatefulWidget {
  const PhrasesAdd({super.key, required this.item});
  final PhrasesAddArgs item;
  @override
  State<PhrasesAdd> createState() => _PhrasesAddState();
}

class _PhrasesAddState extends State<PhrasesAdd> {
  TextEditingController myLanguageController = TextEditingController();
  TextEditingController theirLanguageController = TextEditingController();
  TextEditingController romanizationController = TextEditingController();
  PhrasesModel? phrases;

  Map<String, String> populateForm() {
    return {
      'myLanguage': myLanguageController.text,
      'theirLanguage': theirLanguageController.text,
      'romanization': romanizationController.text,
    };
  }

  @override
  void initState() {
    super.initState();
    if (widget.item.id != null) {
      phrases = BlocProvider.of<PhrasesCubit>(context).getPhrases(widget.item.id!);
      if (phrases != null) {
        setState(() {
          myLanguageController.text = phrases!.myLanguage;
          theirLanguageController.text = phrases!.theirLanguage;
          romanizationController.text = phrases!.romanization ?? '';
        });
      }
    }
  }

  void validateForm() {
    final formData = populateForm();
    if (formData['myLanguage']!.trim().isEmpty) {
      DialogHandler.showSnackBar(
        context: context,
        message: "My Language cannot be empty",
      );
      return;
    }
    if (formData['theirLanguage']!.trim().isEmpty) {
      DialogHandler.showSnackBar(
        context: context,
        message: "Their Language cannot be empty",
      );
      return;
    }
    if (widget.item.id != null) {
      showSaveDialog(context, formData);
    } else {
      onSubmit(context, formData);
    }
  }

  void onSubmit(BuildContext context, Map<String, String> data) async {
    try {
      await BlocProvider.of<PhrasesCubit>(context).savePhrases(
        PhrasesModel(
          id: widget.item.id != null ? widget.item.id! : const Uuid().v4(),
          myLanguage: data['myLanguage']!,
          theirLanguage: data['theirLanguage']!,
          romanization: data['romanization'],
          languageId: widget.item.languageId,
          createdAt: widget.item.id != null ? phrases!.createdAt : DateTime.now(),
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
    await BlocProvider.of<PhrasesCubit>(context).deletePhrases(widget.item.id!);
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
              TextFieldItem(
                title: "My Language",
                controller: myLanguageController,
              ),
              TextFieldItem(
                title: "Their Language",
                controller: theirLanguageController,
              ),
              TextFieldItem(
                title: "Romanization",
                controller: romanizationController,
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
            child: Text(widget.item.id == null ? "Submit" : "Save"),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.item.id == null ? "Add" : "Edit"} Phrases"),
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        actions: widget.item.id == null
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
