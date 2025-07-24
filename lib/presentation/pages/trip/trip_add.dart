import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../../data/models/local/trip_model.dart';
import '../../../injector.dart';
import '../../core/constant/form_type.dart';
import '../../core/handler/dialog_handler.dart';
import '../../core/widget/add_image_item.dart';
import '../../core/widget/loading_state.dart';
import '../../core/widget/text_field_item.dart';
import 'cubit/trip_cubit.dart';
import 'cubit/trip_state.dart';

class TripAddProvider extends StatelessWidget {
  const TripAddProvider({super.key, this.id });
  final String? id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TripCubit>(),
      child: TripAdd(id: id),
    );
  }
}

class TripAdd extends StatefulWidget {
  const TripAdd({super.key, this.id});
  final String? id;
  @override
  State<TripAdd> createState() => _TripAddState();
}

class _TripAddState extends State<TripAdd> {

  TextEditingController titleController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TripModel? trip;
  Uint8List? imagePhoto;

  Map<String, String> populateForm() {
    return {
      'title': titleController.text,
      'startDate': startDateController.text,
      'endDate': endDateController.text,
      'description': descController.text,
    };
  }

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      trip = BlocProvider.of<TripCubit>(context).getTrip(widget.id!);
      if(trip != null) {
        setState(() {
          imagePhoto = trip!.photoBytes;
          titleController.text = trip!.title;
          startDateController.text = trip!.startDate;
          endDateController.text = trip!.endDate;
          descController.text = trip!.description;
        });
      }
    }
  }

  void validateForm(BuildContext context) async {
    final formData = populateForm();
    if (imagePhoto == null) {
      DialogHandler.showSnackBar(
        context: context,
        message: "Photo cannot be empty",
      );
      return;
    }
    if (formData['title']!.trim().isEmpty) {
      DialogHandler.showSnackBar(context: context, message: "Title cannot be empty");
      return;
    }
    if (formData['startDate']!.trim().isEmpty) {
      DialogHandler.showSnackBar(
        context: context,
        message: "Start Date Date cannot be empty",
      );
      return;
    }
    if (formData['endDate']!.trim().isEmpty) {
      DialogHandler.showSnackBar(
        context: context,
        message: "End Date Date cannot be empty",
      );
      return;
    }
    if (formData['description']!.trim().isEmpty) {
      DialogHandler.showSnackBar(context: context, message: "Description cannot be empty");
      return;
    }
    try {
      final dateFormat = DateFormat('dd MMM yyyy');
      final startDate = dateFormat.parse(formData['startDate']!);
      final endDate = dateFormat.parse(formData['endDate']!);

      if (endDate.isBefore(startDate)) {
        DialogHandler.showSnackBar(
            context: context,
            message: "End Time cannot be earlier than Start Time");
        return;
      }
    } catch (e) {
      DialogHandler.showSnackBar(context: context, message: "Invalid date format");
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
      await BlocProvider.of<TripCubit>(context).saveTrip(
        TripModel(
          id: widget.id != null ? widget.id! : const Uuid().v4(),
          title: data['title']!,
          description: data['description']!,
          startDate: data['startDate']!,
          endDate: data['endDate']!,
          photoBytes: imagePhoto,
          createdAt: widget.id != null ? trip!.createdAt : DateTime.now(),
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
    await BlocProvider.of<TripCubit>(context).deleteTrip(widget.id!);
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

  Widget eventInitial(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                AddImageItem(
                  title: "Image",
                  onImagePicked: (bytes) {
                    setState(() {
                      imagePhoto = bytes;
                    });
                  },
                  initialImageBytes: imagePhoto,
                ),
                TextFieldItem(
                    title: "Title",
                    controller: titleController
                ),
                TextFieldItem(
                  title: "Start Date",
                  formType: FormType.date,
                  controller: startDateController,
                ),
                TextFieldItem(
                  title: "End Date",
                  formType: FormType.date,
                  controller: endDateController,
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
            title: Text("${widget.id == null ? "Add" : "Edit"} Trip"),
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
          child: BlocBuilder<TripCubit, TripCubitState>(
            builder: (blocContext, state) {
              if(state is TripInitial) {
                return eventInitial(context);
              }
              else if(state is TripLoading) {
                return const LoadingState();
              }
              return Container();
            },
          ),
        )
    );
  }

}