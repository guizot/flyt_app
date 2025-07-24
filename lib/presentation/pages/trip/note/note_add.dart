import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyt_app/data/models/local/note_model.dart';
import 'package:uuid/uuid.dart';
import '../../../../injector.dart';
import '../../../core/handler/dialog_handler.dart';
import '../../../core/model/arguments/common_add_args.dart';
import '../../../core/widget/loading_state.dart';
import '../../../core/widget/text_field_item.dart';
import '../cubit/trip_cubit.dart';
import '../cubit/trip_state.dart';

class NoteAddProvider extends StatelessWidget {
  const NoteAddProvider({super.key, required this.item });
  final CommonAddArgs item;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TripCubit>(),
      child: NoteAdd(item: item),
    );
  }
}

class NoteAdd extends StatefulWidget {
  const NoteAdd({super.key, required this.item});
  final CommonAddArgs item;
  @override
  State<NoteAdd> createState() => _NoteAddState();
}

class _NoteAddState extends State<NoteAdd> {

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  NoteModel? note;

  Map<String, String> populateForm() {
    return {
      'title': titleController.text,
      'description': descController.text,
    };
  }

  @override
  void initState() {
    super.initState();
    if (widget.item.id != null) {
      note = BlocProvider.of<TripCubit>(context).getNote(widget.item.id!);
      if(note != null) {
        setState(() {
          titleController.text = note!.title;
          descController.text = note!.description;
        });
      }
    }
  }

  void validateForm(BuildContext context) async {
    final formData = populateForm();
    if (formData['title']!.trim().isEmpty) {
      DialogHandler.showSnackBar(context: context, message: "Title cannot be empty");
      return;
    }
    if (formData['description']!.trim().isEmpty) {
      DialogHandler.showSnackBar(context: context, message: "Description cannot be empty");
      return;
    }
    if(widget.item.id != null) {
      showSaveDialog(context, formData);
    } else {
      onSubmit(context, formData);
    }
  }

  void onSubmit(BuildContext context, Map<String, String> data) async {
    try {
      await BlocProvider.of<TripCubit>(context).saveNote(
        NoteModel(
          id: widget.item.id != null ? widget.item.id! : const Uuid().v4(),
          title: data['title']!,
          description: data['description']!,
          tripId: widget.item.tripId,
          createdAt: widget.item.id != null ? note!.createdAt : DateTime.now(),
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
    await BlocProvider.of<TripCubit>(context).deleteNote(widget.item.id!);
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

  Widget bookingInitial(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                TextFieldItem(
                    title: "Title",
                    controller: titleController
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
            onPressed: () => validateForm(context),
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
          title: Text("${widget.item.id == null ? "Add" : "Edit"} Note"),
          backgroundColor: Theme.of(context).colorScheme.surface,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          actions: widget.item.id == null ? null : [
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
          child: BlocBuilder<TripCubit, TripCubitState>(
            builder: (blocContext, state) {
              if(state is TripInitial) {
                return bookingInitial(context);
              }
              else if(state is TripLoading) {
                return const LoadingState();
              }
              return Container();
            },
          )
        )
    );
  }

}