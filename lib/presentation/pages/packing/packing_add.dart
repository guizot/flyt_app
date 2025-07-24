import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../data/models/local/packing_model.dart';
import '../../../injector.dart';
import '../../core/handler/dialog_handler.dart';
import '../../core/model/static/packing_category.dart';
import '../../core/widget/drop_down_item.dart';
import '../../core/widget/loading_state.dart';
import '../../core/widget/text_field_item.dart';
import 'cubit/packing_cubit.dart';
import 'cubit/packing_state.dart';

class PackingAddProvider extends StatelessWidget {
  const PackingAddProvider({super.key, this.id });
  final String? id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PackingCubit>(),
      child: PackingAdd(id: id),
    );
  }
}

class PackingAdd extends StatefulWidget {
  const PackingAdd({super.key, this.id});
  final String? id;
  @override
  State<PackingAdd> createState() => _PackingAddState();
}

class _PackingAddState extends State<PackingAdd> {

  TextEditingController nameController = TextEditingController();
  TextEditingController groupController = TextEditingController();
  Packing? packing;

  Map<String, String> populateForm() {
    return {
      'name': nameController.text,
      'group': groupController.text,
      'groupIcon': groupController.text,
    };
  }

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      packing = BlocProvider.of<PackingCubit>(context).getPacking(widget.id!);
      if(packing != null) {
        setState(() {
          nameController.text = packing!.name;
          groupController.text = packing!.group;
        });
      }
    }
  }

  void validateForm() {
    final formData = populateForm();
    if (formData['name']!.trim().isEmpty) {
      DialogHandler.showSnackBar(context: context, message: "Item Name cannot be empty");
      return;
    }
    if (formData['group']!.trim().isEmpty) {
      DialogHandler.showSnackBar(context: context, message: "Packing Group cannot be empty");
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
      await BlocProvider.of<PackingCubit>(context).savePacking(
          Packing(
            id: widget.id != null ? widget.id! : const Uuid().v4(),
            name: data['name']!,
            group: data['group']!,
            groupIcon: packingCategories.firstWhere((element) => element.name == data['group']!).icon,
            selected: widget.id != null ? packing!.selected : false,
            createdAt: widget.id != null ? packing!.createdAt : DateTime.now(),
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
    await BlocProvider.of<PackingCubit>(context).deletePacking(widget.id!);
    if(context.mounted) {
      Navigator.pop(context);
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

  Widget packingInitial(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                TextFieldItem(
                  title: "Item Name",
                  controller: nameController,
                ),
                DropDownItem(
                  title: "Packing Group",
                  controller: groupController,
                  items: packingCategories
                      .map((c) => {'title': c.name, 'icon': c.icon})
                      .toList(),
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
          title: Text("${widget.id == null ? "Add" : "Edit"} Packing"),
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
        body: Container(
            color: Theme.of(context).colorScheme.surface,
            child: BlocBuilder<PackingCubit, PackingCubitState>(
            builder: (blocContext, state) {
              if(state is PackingInitial) {
                return packingInitial(context);
              }
              else if(state is PackingLoading) {
                return const LoadingState();
              }
              return Container();
            },
          )
        )
    );
  }

}