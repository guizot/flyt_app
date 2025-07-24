import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyt_app/presentation/core/model/static/transport_mode.dart';
import 'package:uuid/uuid.dart';
import '../../../../data/models/local/path_model.dart';
import '../../../../injector.dart';
import '../../../core/handler/dialog_handler.dart';
import '../../../core/model/arguments/common_add_args.dart';
import '../../../core/widget/drop_down_item.dart';
import '../../../core/widget/loading_state.dart';
import '../../../core/widget/text_field_item.dart';
import '../cubit/trip_cubit.dart';
import '../cubit/trip_state.dart';

class PathAddProvider extends StatelessWidget {
  const PathAddProvider({super.key, required this.item });
  final CommonAddArgs item;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TripCubit>(),
      child: PathAdd(item: item),
    );
  }
}

class PathAdd extends StatefulWidget {
  const PathAdd({super.key, required this.item});
  final CommonAddArgs item;
  @override
  State<PathAdd> createState() => _PathAddState();
}

class _PathAddState extends State<PathAdd> {

  TextEditingController formController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController distanceController = TextEditingController();
  TextEditingController estimatedTimeController = TextEditingController();
  TextEditingController transportController = TextEditingController();
  PathModel? path;
  List<Map<String, String>> locationItems = [];

  Map<String, String> populateForm() {
    return {
      'form': formController.text,
      'to': toController.text,
      'distance': distanceController.text,
      'estimatedTime': estimatedTimeController.text,
      'transport': transportController.text,
    };
  }

  String getLocationNameById(String id) {
    final match = locationItems.firstWhere((item) => item['value'] == id, orElse: () => {});
    return match['title'] ?? id;
  }

  @override
  void initState() {
    super.initState();
    final locations = BlocProvider.of<TripCubit>(context).getAllLocation(widget.item.tripId);
    locationItems = locations
        .map((loc) => {'title': loc.name, 'value': loc.id})
        .toList();
    if (widget.item.id != null) {
      path = BlocProvider.of<TripCubit>(context).getPath(widget.item.id!);
      if(path != null) {
        setState(() {
          formController.text = path!.fromLocationId;
          toController.text = path!.toLocationId;
          distanceController.text = path!.distance;
          estimatedTimeController.text = path!.estimatedTime;
          transportController.text = path!.transport;
        });
      }
    }
  }

  void validateForm(BuildContext context) async {
    final formData = populateForm();
    if (formData['form']!.trim().isEmpty) {
      DialogHandler.showSnackBar(context: context, message: "From Location cannot be empty");
      return;
    }
    if (formData['to']!.trim().isEmpty) {
      DialogHandler.showSnackBar(context: context, message: "To Location cannot be empty");
      return;
    }
    if (formData['distance']!.trim().isEmpty) {
      DialogHandler.showSnackBar(context: context, message: "Distance cannot be empty");
      return;
    }
    if (formData['estimatedTime']!.trim().isEmpty) {
      DialogHandler.showSnackBar(context: context, message: "Estimated Time cannot be empty");
      return;
    }
    if (formData['transport']!.trim().isEmpty) {
      DialogHandler.showSnackBar(context: context, message: "Transport cannot be empty");
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
      await BlocProvider.of<TripCubit>(context).savePath(
        PathModel(
          id: widget.item.id != null ? widget.item.id! : const Uuid().v4(),
          fromLocationId: data['form']!,
          toLocationId: data['to']!,
          distance: data['distance']!,
          estimatedTime: data['estimatedTime']!,
          transport: data['transport']!,
          tripId: widget.item.tripId,
          createdAt: widget.item.id != null ? path!.createdAt : DateTime.now(),
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
    await BlocProvider.of<TripCubit>(context).deletePath(widget.item.id!);
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
                DropDownItem(
                  title: "From Location",
                  controller: formController,
                  items: locationItems,
                  useValue: true,
                ),
                DropDownItem(
                  title: "To Location",
                  controller: toController,
                  items: locationItems,
                  useValue: true,
                ),
                TextFieldItem(
                  title: "Distance",
                  controller: distanceController
                ),
                TextFieldItem(
                  title: "Estimated Time",
                  controller: estimatedTimeController
                ),
                DropDownItem(
                  title: "Transport",
                  controller: transportController,
                  items: transportModes
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
          title: Text("${widget.item.id == null ? "Add" : "Edit"} Path"),
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