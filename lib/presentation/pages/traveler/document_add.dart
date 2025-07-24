import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyt_app/presentation/core/widget/add_image_item.dart';
import 'package:uuid/uuid.dart';
import '../../../data/models/local/document_model.dart';
import '../../../injector.dart';
import '../../core/handler/dialog_handler.dart';
import '../../core/model/arguments/document_add_args.dart';
import '../../core/widget/loading_state.dart';
import '../../core/widget/text_field_item.dart';
import 'cubit/traveler_cubit.dart';
import 'cubit/traveler_state.dart';

class DocumentAddProvider extends StatelessWidget {
  const DocumentAddProvider({super.key, required this.item});
  final DocumentAddArgs item;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TravelerCubit>(),
      child: DocumentAdd(item: item),
    );
  }
}

class DocumentAdd extends StatefulWidget {
  const DocumentAdd({super.key, required this.item});
  final DocumentAddArgs item;
  @override
  State<DocumentAdd> createState() => _DocumentAddState();
}

class _DocumentAddState extends State<DocumentAdd> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  DocumentModel? document;
  Uint8List? imagePhoto;

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
      document = BlocProvider.of<TravelerCubit>(
        context,
      ).getDocument(widget.item.id!);
      if (document != null) {
        setState(() {
          imagePhoto = document!.imageBytes;
          titleController.text = document!.title;
          descController.text = document!.description;
        });
      }
    }
  }

  void validateForm() {
    final formData = populateForm();
    if (formData['title']!.trim().isEmpty) {
      DialogHandler.showSnackBar(
        context: context,
        message: "Title cannot be empty",
      );
      return;
    }
    if (formData['description']!.trim().isEmpty) {
      DialogHandler.showSnackBar(
        context: context,
        message: "Description cannot be empty",
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
      await BlocProvider.of<TravelerCubit>(context).saveDocument(
        DocumentModel(
          id: widget.item.id != null ? widget.item.id! : const Uuid().v4(),
          title: data['title']!,
          description: data['description']!,
          travelerId: widget.item.travelerId,
          imageBytes: imagePhoto,
          createdAt: widget.item.id != null ? document!.createdAt : DateTime.now(),
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
    Navigator.pop(context);
    await BlocProvider.of<TravelerCubit>(context).deleteDocument(widget.item.id!);
    if (context.mounted) {
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

  Widget documentInitial(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              TextFieldItem(title: "Title", controller: titleController),
              TextFieldItem(title: "Description", controller: descController),
              AddImageItem(
                title: "Image Document",
                onImagePicked: (bytes) {
                  setState(() {
                    imagePhoto = bytes;
                  });
                },
                initialImageBytes: imagePhoto,
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
        title: Text("${widget.item.id == null ? "Add" : "Edit"} Document"),
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
      body: Container(
        color: Theme.of(context).colorScheme.surface ,
        child: BlocBuilder<TravelerCubit, TravelerCubitState>(
          builder: (blocContext, state) {
            if (state is TravelerInitial) {
              return documentInitial(context);
            } else if (state is TravelerLoading) {
              return const LoadingState();
            }
            return Container();
          },
        ),
      )
    );
  }
}
