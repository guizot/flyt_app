import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyt_app/presentation/core/model/static/blood_type.dart';
import 'package:flyt_app/presentation/core/model/static/gender.dart';
import 'package:flyt_app/presentation/core/model/static/marital_status.dart';
import 'package:flyt_app/presentation/core/widget/add_image_item.dart';
import 'package:uuid/uuid.dart';
import '../../../data/models/local/traveler_model.dart';
import '../../../injector.dart';
import '../../core/constant/form_type.dart';
import '../../core/handler/dialog_handler.dart';
import '../../core/widget/drop_down_item.dart';
import '../../core/widget/loading_state.dart';
import '../../core/widget/text_field_item.dart';
import 'cubit/traveler_cubit.dart';
import 'cubit/traveler_state.dart';

class TravelerAddProvider extends StatelessWidget {
  const TravelerAddProvider({super.key, this.id});
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
  TextEditingController birthDateController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController bloodTypeController = TextEditingController();
  TextEditingController maritalStatusController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  Traveler? traveler;
  Uint8List? imagePhoto;

  Map<String, String> populateForm() {
    return {
      'name': nameController.text,
      'birthDate': birthDateController.text,
      'gender': genderController.text,
      'bloodType': bloodTypeController.text,
      'maritalStatus': maritalStatusController.text,
      'nationality': nationalityController.text,
      'phone': phoneController.text,
      'email': emailController.text,
    };
  }

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      traveler = BlocProvider.of<TravelerCubit>(
        context,
      ).getTraveler(widget.id!);
      if (traveler != null) {
        setState(() {
          imagePhoto = traveler!.imageBytes;
          nameController.text = traveler!.name;
          birthDateController.text = traveler!.birthdate;
          genderController.text = traveler!.gender;
          bloodTypeController.text = traveler!.bloodType;
          maritalStatusController.text = traveler!.maritalStatus;
          nationalityController.text = traveler!.nationality;
          phoneController.text = traveler!.phone;
          emailController.text = traveler!.email;
        });
      }
    }
  }

  void validateForm() {
    final formData = populateForm();
    if (imagePhoto == null) {
      DialogHandler.showSnackBar(
        context: context,
        message: "Photo cannot be empty",
      );
      return;
    }
    if (formData['name']!.trim().isEmpty) {
      DialogHandler.showSnackBar(
        context: context,
        message: "Name cannot be empty",
      );
      return;
    }
    if (formData['birthDate']!.trim().isEmpty) {
      DialogHandler.showSnackBar(
        context: context,
        message: "Birth Date cannot be empty",
      );
      return;
    }
    if (formData['gender']!.trim().isEmpty) {
      DialogHandler.showSnackBar(
        context: context,
        message: "Gender cannot be empty",
      );
      return;
    }
    if (formData['bloodType']!.trim().isEmpty) {
      DialogHandler.showSnackBar(
        context: context,
        message: "Blood Type cannot be empty",
      );
      return;
    }
    if (formData['maritalStatus']!.trim().isEmpty) {
      DialogHandler.showSnackBar(
        context: context,
        message: "Marital Status cannot be empty",
      );
      return;
    }
    if (formData['nationality']!.trim().isEmpty) {
      DialogHandler.showSnackBar(
        context: context,
        message: "Nationality cannot be empty",
      );
      return;
    }
    if (formData['phone']!.trim().isEmpty) {
      DialogHandler.showSnackBar(
        context: context,
        message: "Phone cannot be empty",
      );
      return;
    }
    if (formData['email']!.trim().isEmpty) {
      DialogHandler.showSnackBar(
        context: context,
        message: "Email cannot be empty",
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
      await BlocProvider.of<TravelerCubit>(context).saveTraveler(
        Traveler(
          id: widget.id != null ? widget.id! : const Uuid().v4(),
          name: data['name']!,
          birthdate: data['birthDate']!,
          gender: data['gender']!,
          bloodType: data['bloodType']!,
          maritalStatus: data['maritalStatus']!,
          nationality: data['nationality']!,
          phone: data['phone']!,
          email: data['email']!,
          imageBytes: imagePhoto,
          createdAt: widget.id != null ? traveler!.createdAt : DateTime.now(),
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
    await BlocProvider.of<TravelerCubit>(context).deleteTraveler(widget.id!);
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

  Widget travelerInitial(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              AddImageItem(
                title: "Photo",
                onImagePicked: (bytes) {
                  setState(() {
                    imagePhoto = bytes;
                  });
                },
                initialImageBytes: imagePhoto,
              ),
              TextFieldItem(title: "Name", controller: nameController),
              TextFieldItem(
                title: "Birth Date",
                formType: FormType.date,
                controller: birthDateController,
              ),
              DropDownItem(
                title: "Gender",
                controller: genderController,
                items: genders
                    .map((c) => {'title': c.name, 'icon': c.icon})
                    .toList(),
              ),
              DropDownItem(
                title: "Blood Type",
                controller: bloodTypeController,
                items: bloodTypes
                    .map((c) => {'title': c.name, 'icon': c.icon})
                    .toList(),
              ),
              DropDownItem(
                title: "Marital Status",
                controller: maritalStatusController,
                items: maritalStatuses
                    .map((c) => {'title': c.name, 'icon': c.icon})
                    .toList(),
              ),
              TextFieldItem(
                title: "Nationality",
                controller: nationalityController,
              ),
              TextFieldItem(title: "Phone", controller: phoneController),
              TextFieldItem(title: "Email", controller: emailController),
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
        title: Text("${widget.id == null ? "Add" : "Edit"} Traveler"),
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
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: BlocBuilder<TravelerCubit, TravelerCubitState>(
          builder: (blocContext, state) {
            if (state is TravelerInitial) {
              return travelerInitial(context);
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
