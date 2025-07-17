import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:flyt_app/presentation/core/extension/number_extension.dart';
import '../../../data/models/local/event_model.dart';
import '../../../injector.dart';
import '../../core/handler/dialog_handler.dart';
import '../../core/widget/loading_state.dart';
import '../../core/widget/text_field_item.dart';
import 'cubit/event_cubit.dart';
import 'cubit/event_state.dart';

class EventAddProvider extends StatelessWidget {
  const EventAddProvider({super.key, this.id });
  final String? id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<EventCubit>(),
      child: EventAdd(id: id),
    );
  }
}

class EventAdd extends StatefulWidget {
  const EventAdd({super.key, this.id});
  final String? id;
  @override
  State<EventAdd> createState() => _EventAddState();
}

class _EventAddState extends State<EventAdd> {

  TextEditingController titleController = TextEditingController();
  TextEditingController budgetController = TextEditingController();
  TextEditingController descController = TextEditingController();
  Event? event;

  Map<String, String> populateForm() {
    return {
      'title': titleController.text,
      'budget': budgetController.text.toIntFromFormatted().toString(),
      'description': descController.text,
    };
  }

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      event = BlocProvider.of<EventCubit>(context).getEvent(widget.id!);
      if(event != null) {
        setState(() {
          titleController.text = event!.title;
          budgetController.text = int.parse(event!.budget).toCurrencyFormat();
          descController.text = event!.description;
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
      await BlocProvider.of<EventCubit>(context).saveEvent(
        Event(
          id: widget.id != null ? widget.id! : const Uuid().v4(),
          title: data['title']!,
          budget: data['budget']!,
          description: data['description']!,
          createdAt: widget.id != null ? event!.createdAt : DateTime.now(),
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
    await BlocProvider.of<EventCubit>(context).deleteEvent(widget.id!);
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

  Widget eventInitial(BuildContext context) {
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
                    title: "Budget",
                    inputType: TextInputType.number,
                    preText: "Rp",
                    controller: budgetController
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
            title: Text("${widget.id == null ? "Add" : "Edit"} Event"),
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
        body: BlocBuilder<EventCubit, EventCubitState>(
          builder: (blocContext, state) {
            if(state is EventInitial) {
              return eventInitial(context);
            }
            else if(state is EventLoading) {
              return const LoadingState();
            }
            return Container();
          },
        )
    );
  }

}