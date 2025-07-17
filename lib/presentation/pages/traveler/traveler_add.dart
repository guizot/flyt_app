import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:flyt_app/presentation/core/extension/number_extension.dart';
import '../../../data/models/local/traveler_model.dart';
import '../../../injector.dart';
import '../../core/handler/dialog_handler.dart';
import '../../core/widget/loading_state.dart';
import '../../core/widget/text_field_item.dart';
import 'cubit/traveler_cubit.dart';
import 'cubit/traveler_state.dart';

class TravelerAddProvider extends StatelessWidget {
  const TravelerAddProvider({super.key, this.id });
  final String? id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TravelerCubit>(),
      child: TravelerAdd(id: id),
    );
  }
}

class TravelerAdd extends StatefulWidget {
  const TravelerAdd({super.key, this.id});
  final String? id;
  @override
  State<TravelerAdd> createState() => _TravelerAddState();
}

class _TravelerAddState extends State<TravelerAdd> {
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController budgetController = TextEditingController();
  TextEditingController descController = TextEditingController();
  Traveler? traveler;

  Map<String, String> populateForm() {
    return {
      'name': nameController.text,
      'category': categoryController.text,
      'budget': budgetController.text.toIntFromFormatted().toString(),
      'description': descController.text,
    };
  }

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      traveler = BlocProvider.of<TravelerCubit>(context).getTraveler(widget.id!);
      if(traveler != null) {
        setState(() {
          nameController.text = traveler!.name;
          categoryController.text = traveler!.category;
          budgetController.text = int.parse(traveler!.budget).toCurrencyFormat();
          descController.text = traveler!.description;
        });
      }
    }
  }

  void validateForm() {
    final formData = populateForm();
    if (formData['name']!.trim().isEmpty) {
      DialogHandler.showSnackBar(context: context, message: "Name cannot be empty");
      return;
    }
    if (formData['category']!.trim().isEmpty) {
      DialogHandler.showSnackBar(context: context, message: "Category cannot be empty");
      return;
    }
    if (formData['budget']!.trim().isEmpty) {
      DialogHandler.showSnackBar(context: context, message: "Budget cannot be empty");
      return;
    }
    if (formData['description']!.trim().isEmpty) {
      DialogHandler.showSnackBar(context: context, message: "Description cannot be empty");
      return;
    }
    if(widget.id != null) {
      showSaveDialog(context, formData);
    } else {
      onSubmit(context, formData);
    }
  }

  void onSubmit(BuildContext context, Map<String, String> data) async {
    try {
      await BlocProvider.of<TravelerCubit>(context).saveTraveler(
          Traveler(
            id: widget.id != null ? widget.id! : const Uuid().v4(),
            name: data['name']!,
            category: data['category']!,
            budget: data['budget']!,
            description: data['description']!,
            createdAt: widget.id != null ? traveler!.createdAt : DateTime.now(),
          )
      );
      if(context.mounted) {
        Navigator.pop(context);
      }
    } catch(e) {
      if(context.mounted) {
        DialogHandler.showSnackBar(context: context, message: "Error: $e");
      }
    }
  }

  void showSaveDialog(BuildContext context, Map<String, String> data) {
    DialogHandler.showConfirmDialog(
        context: context,
        title: "Confirmation",
        description: "We’ll save your updates so everything stays up to date. You can always make changes later.",
        confirmText: "Yes, save",
        onConfirm: () {
          Navigator.pop(context);
          onSubmit(context, data);
        }
    );
  }

  void onDelete(BuildContext context) async {
    Navigator.pop(context);
    await BlocProvider.of<TravelerCubit>(context).deleteTraveler(widget.id!);
    if(context.mounted) {
      Navigator.pop(context);
    }
  }

  void showDeleteDialog(BuildContext context) {
    DialogHandler.showConfirmDialog(
        context: context,
        title: "Confirmation",
        description: "Deleting this will erase all related data and cannot be undone. Make sure this is what you really want to do.",
        confirmText: "Yes, delete",
        onConfirm: () => onDelete(context)
    );
  }

  Widget travelerInitial(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                TextFieldItem(
                  title: "Name",
                  controller: nameController,
                ),
                TextFieldItem(
                  title: "Category",
                  controller: categoryController,
                ),
                TextFieldItem(
                  title: "Budget",
                  inputType: TextInputType.number,
                  preText: "Rp",
                  controller: budgetController,
                ),
                TextFieldItem(
                  title: "Description",
                  inputType: TextInputType.multiline,
                  controller: descController
                ),
              ],
            )
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
          title: Text("${widget.id == null ? "Add" : "Edit"} Traveler"),
          backgroundColor: Theme.of(context).colorScheme.surface,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          actions: widget.id == null ? null : [
            Container(
              margin: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: const Icon(Icons.delete_forever_rounded),
                tooltip: 'Delete',
                onPressed: () => showDeleteDialog(context),
              ),
            )
          ],
        ),
        body: BlocBuilder<TravelerCubit, TravelerCubitState>(
          builder: (blocContext, state) {
            if(state is TravelerInitial) {
              return travelerInitial(context);
            }
            else if(state is TravelerLoading) {
              return const LoadingState();
            }
            return Container();
          },
        )
    );
  }
} 