import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyt_app/presentation/core/model/static/location_types.dart';
import 'package:uuid/uuid.dart';
import '../../../../data/models/local/location_model.dart';
import '../../../../injector.dart';
import '../../../core/handler/dialog_handler.dart';
import '../../../core/model/arguments/common_add_args.dart';
import '../../../core/widget/add_image_item.dart';
import '../../../core/widget/drop_down_item.dart';
import '../../../core/widget/loading_state.dart';
import '../../../core/widget/text_field_item.dart';
import '../cubit/trip_cubit.dart';
import '../cubit/trip_state.dart';

class LocationAddProvider extends StatelessWidget {
  const LocationAddProvider({super.key, required this.item });
  final CommonAddArgs item;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TripCubit>(),
      child: LocationAdd(item: item),
    );
  }
}

class LocationAdd extends StatefulWidget {
  const LocationAdd({super.key, required this.item});
  final CommonAddArgs item;
  @override
  State<LocationAdd> createState() => _LocationAddState();
}

class _LocationAddState extends State<LocationAdd> {

  TextEditingController nameController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  LocationModel? location;
  Uint8List? imagePhoto;

  Map<String, String> populateForm() {
    return {
      'name': nameController.text,
      'type': typeController.text,
      'address': addressController.text,
      'phone': phoneController.text,
      'email': emailController.text,
      'website': websiteController.text,
      'url': urlController.text,
      'note': noteController.text,
    };
  }

  @override
  void initState() {
    super.initState();
    if (widget.item.id != null) {
      location = BlocProvider.of<TripCubit>(context).getLocation(widget.item.id!);
      if(location != null) {
        setState(() {
          imagePhoto = location!.photoBytes;
          nameController.text = location!.name;
          typeController.text = location!.type;
          addressController.text = location!.address;
          phoneController.text = location!.phone;
          emailController.text = location!.email;
          websiteController.text = location!.website;
          urlController.text = location!.mapUrl;
          noteController.text = location!.note ?? '';
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
    if (formData['name']!.trim().isEmpty) {
      DialogHandler.showSnackBar(context: context, message: "Location Name cannot be empty");
      return;
    }
    if (formData['type']!.trim().isEmpty) {
      DialogHandler.showSnackBar(context: context, message: "Location Type cannot be empty");
      return;
    }
    if (formData['address']!.trim().isEmpty) {
      DialogHandler.showSnackBar(context: context, message: "Address cannot be empty");
      return;
    }
    if (formData['phone']!.trim().isEmpty) {
      DialogHandler.showSnackBar(context: context, message: "Phone cannot be empty");
      return;
    }
    if (formData['email']!.trim().isEmpty) {
      DialogHandler.showSnackBar(context: context, message: "Email cannot be empty");
      return;
    }
    if (formData['website']!.trim().isEmpty) {
      DialogHandler.showSnackBar(context: context, message: "Eebsite cannot be empty");
      return;
    }
    if (formData['url']!.trim().isEmpty) {
      DialogHandler.showSnackBar(context: context, message: "Google Maps URL cannot be empty");
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
      await BlocProvider.of<TripCubit>(context).saveLocation(
        LocationModel(
          id: widget.item.id != null ? widget.item.id! : const Uuid().v4(),
          name: data['name']!,
          type: data['type']!,
          address: data['address']!,
          phone: data['phone']!,
          email: data['email']!,
          website: data['website']!,
          mapUrl: data['url']!,
          note: data['note']!,
          tripId: widget.item.tripId,
          photoBytes: imagePhoto,
          createdAt: widget.item.id != null ? location!.createdAt : DateTime.now(),
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
    await BlocProvider.of<TripCubit>(context).deleteLocation(widget.item.id!);
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

  Widget bookingInitial(BuildContext context) {
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
                    title: "Location Name",
                    controller: nameController
                ),
                DropDownItem(
                  title: "Location Type",
                  controller: typeController,
                  items: locationTypes
                      .map((c) => {'title': c.name, 'icon': c.icon})
                      .toList(),
                ),
                TextFieldItem(
                    title: "Address",
                    inputType: TextInputType.multiline,
                    controller: addressController
                ),
                TextFieldItem(
                    title: "Phone",
                    controller: phoneController
                ),
                TextFieldItem(
                    title: "Email",
                    controller: emailController
                ),
                TextFieldItem(
                    title: "Website",
                    controller: websiteController
                ),
                TextFieldItem(
                    title: "Google Maps URL",
                    inputType: TextInputType.multiline,
                    controller: urlController
                ),
                TextFieldItem(
                    title: "Notes",
                    inputType: TextInputType.multiline,
                    controller: noteController
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
          title: Text("${widget.item.id == null ? "Add" : "Edit"} Location"),
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