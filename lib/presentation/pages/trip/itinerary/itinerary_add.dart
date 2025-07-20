import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../../../data/models/local/itinerary_model.dart';
import '../../../../injector.dart';
import '../../../core/constant/form_type.dart';
import '../../../core/handler/dialog_handler.dart';
import '../../../core/model/arguments/common_add_args.dart';
import '../../../core/model/static/itinerary_type.dart';
import '../../../core/widget/drop_down_item.dart';
import '../../../core/widget/loading_state.dart';
import '../../../core/widget/text_field_item.dart';
import '../cubit/trip_cubit.dart';
import '../cubit/trip_state.dart';

class ItineraryAddProvider extends StatelessWidget {
  const ItineraryAddProvider({super.key, required this.item });
  final CommonAddArgs item;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TripCubit>(),
      child: ItineraryAdd(item: item),
    );
  }
}

class ItineraryAdd extends StatefulWidget {
  const ItineraryAdd({super.key, required this.item});
  final CommonAddArgs item;
  @override
  State<ItineraryAdd> createState() => _ItineraryAddState();
}

class _ItineraryAddState extends State<ItineraryAdd> {

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController pathController = TextEditingController();
  ItineraryModel? itinerary;
  List<Map<String, String>> locationItems = [];
  List<Map<String, String>> pathItems = [];
  List<Map<String, String>> dateItems = [];

  Map<String, String> populateForm() {
    return {
      'date': dateController.text,
      'time': timeController.text,
      'description': descController.text,
      'type': typeController.text,
      'location': locationController.text,
      'path': pathController.text,
    };
  }

  void initTypeController() {
    typeController.addListener(() {
      locationController.text = '';
      pathController.text = '';
      setState(() {});
    });
  }

  void initTrip() {
    final trip = BlocProvider.of<TripCubit>(context).getTrip(widget.item.tripId);
    if (trip != null) {
      final formatter = DateFormat('dd MMM yyyy');
      final start = formatter.parse(trip.startDate);
      final end = formatter.parse(trip.endDate);

      final dates = <Map<String, String>>[];
      for (var date = start;
      !date.isAfter(end);
      date = date.add(const Duration(days: 1))) {
        final formatted = formatter.format(date);
        dates.add({'title': formatted, 'value': formatted});
      }
      setState(() {
        dateItems = dates;
      });
    }
  }

  void initLocationAndPath() {
    final locations = BlocProvider.of<TripCubit>(context).getAllLocation(widget.item.tripId);
    locationItems = locations
        .map((loc) => {'title': loc.name, 'value': loc.id})
        .toList();
    final paths = BlocProvider.of<TripCubit>(context).getAllPath(widget.item.tripId);
    pathItems = paths
        .map((loc) => {'title': loc.getRouteName(locations), 'value': loc.id})
        .toList();
  }

  @override
  void initState() {
    super.initState();
    initTypeController();
    initTrip();
    initLocationAndPath();
    if (widget.item.id != null) {
      itinerary = BlocProvider.of<TripCubit>(context).getItinerary(widget.item.id!);
      if(itinerary != null) {
        setState(() {
          dateController.text = itinerary!.date;
          timeController.text = itinerary!.time;
          descController.text = itinerary!.description;
          typeController.text = itinerary!.type;
          locationController.text = itinerary!.locationId ?? '';
          pathController.text = itinerary!.pathId ?? '';
        });
      }
    }
  }

  void validateForm(BuildContext context) async {
    final formData = populateForm();
    if (formData['date']!.trim().isEmpty) {
      DialogHandler.showSnackBar(
        context: context,
        message: "Date cannot be empty",
      );
      return;
    }
    if (formData['time']!.trim().isEmpty) {
      DialogHandler.showSnackBar(
        context: context,
        message: "Time cannot be empty",
      );
      return;
    }
    if (formData['description']!.trim().isEmpty) {
      DialogHandler.showSnackBar(context: context, message: "Description cannot be empty");
      return;
    }
    if (formData['type']!.trim().isEmpty) {
      DialogHandler.showSnackBar(context: context, message: "Itinerary Type cannot be empty");
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
      await BlocProvider.of<TripCubit>(context).saveItinerary(
          ItineraryModel(
            id: widget.item.id != null ? widget.item.id! : const Uuid().v4(),
            date: data['date']!,
            time: data['time']!,
            description: data['description']!,
            type: data['type']!,
            locationId: data['location']!,
            pathId: data['path']!,
            tripId: widget.item.tripId,
            createdAt: widget.item.id != null ? itinerary!.createdAt : DateTime.now(),
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
    await BlocProvider.of<TripCubit>(context).deleteItinerary(widget.item.id!);
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
                  title: "Date",
                  controller: dateController,
                  items: dateItems,
                  useValue: true,
                ),
                TextFieldItem(
                  title: "Time",
                  formType: FormType.date,
                  pickerMode: CupertinoDatePickerMode.time,
                  controller: timeController,
                ),
                TextFieldItem(
                    title: "Description",
                    inputType: TextInputType.multiline,
                    controller: descController
                ),
                DropDownItem(
                  title: "Itinerary Type",
                  controller: typeController,
                  items: itineraryTypes
                      .map((c) => {'title': c.name, 'icon': c.icon})
                      .toList(),
                ),
                if (typeController.text == 'Travel')
                  DropDownItem(
                    title: "Travel Path",
                    controller: pathController,
                    items: pathItems,
                    useValue: true,
                  ),
                if (['Activity', 'Meal', 'Rest'].contains(typeController.text))
                  DropDownItem(
                    title: "Location",
                    controller: locationController,
                    items: locationItems,
                    useValue: true,
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
          title: Text("${widget.item.id == null ? "Add" : "Edit"} Itinerary"),
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
        body: BlocBuilder<TripCubit, TripCubitState>(
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
    );
  }

}