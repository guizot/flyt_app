import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyt_app/data/models/local/bookingdetail/accommodation_detail_model.dart';
import 'package:flyt_app/data/models/local/bookingdetail/activity_detail_model.dart';
import 'package:flyt_app/data/models/local/bookingdetail/booking_detail_model.dart';
import 'package:flyt_app/data/models/local/bookingdetail/transportation_detail_model.dart';
import 'package:flyt_app/presentation/core/model/arguments/common_add_args.dart';
import 'package:flyt_app/presentation/core/model/static/accommodation_type.dart';
import 'package:flyt_app/presentation/core/model/static/activity_type.dart';
import 'package:flyt_app/presentation/core/model/static/transportation_type.dart';
import 'package:uuid/uuid.dart';
import '../../../../data/models/local/booking_model.dart';
import '../../../../injector.dart';
import '../../../core/constant/form_type.dart';
import '../../../core/handler/dialog_handler.dart';
import '../../../core/model/static/booking_category.dart';
import '../../../core/widget/drop_down_item.dart';
import '../../../core/widget/loading_state.dart';
import '../../../core/widget/text_field_item.dart';
import '../cubit/trip_cubit.dart';
import '../cubit/trip_state.dart';

class BookingAddProvider extends StatelessWidget {
  const BookingAddProvider({super.key, required this.item });
  final CommonAddArgs item;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TripCubit>(),
      child: BookingAdd(item: item),
    );
  }
}

class BookingAdd extends StatefulWidget {
  const BookingAdd({super.key, required this.item});
  final CommonAddArgs item;
  @override
  State<BookingAdd> createState() => _BookingAddState();
}

class _BookingAddState extends State<BookingAdd> {

  TextEditingController providerNameController = TextEditingController();
  TextEditingController bookingCodeController = TextEditingController();
  TextEditingController bookingTypeController = TextEditingController();

  // TRANSPORTATION
  TextEditingController transportationTypeController = TextEditingController();
  TextEditingController transportationNameController = TextEditingController();
  TextEditingController vehicleNameController = TextEditingController();
  TextEditingController seatNumberController = TextEditingController();
  TextEditingController departureTimeController = TextEditingController();
  TextEditingController arrivalTimeController = TextEditingController();
  TextEditingController pickupPointController = TextEditingController();
  TextEditingController dropOffPointController = TextEditingController();
  TextEditingController departureLocationController = TextEditingController();
  TextEditingController arrivalLocationController = TextEditingController();

  // ACCOMMODATION
  TextEditingController accommodationTypeController = TextEditingController();
  TextEditingController accommodationNameController = TextEditingController();
  TextEditingController accommodationAddressController = TextEditingController();
  TextEditingController roomTypeController = TextEditingController();
  TextEditingController roomNumberController = TextEditingController();
  TextEditingController checkInController = TextEditingController();
  TextEditingController checkOutController = TextEditingController();
  TextEditingController accommodationContactController = TextEditingController();
  TextEditingController accommodationEmailController = TextEditingController();

  // ACTIVITY
  TextEditingController activityTypeController = TextEditingController();
  TextEditingController activityNameController = TextEditingController();
  TextEditingController activityAddressController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController activityContactController = TextEditingController();
  TextEditingController activityGuideNameController = TextEditingController();

  BookingModel? booking;

  Map<String, String> populateForm() {
    return {
      'providerName': providerNameController.text,
      'bookingCode': bookingCodeController.text,
      'bookingType': bookingTypeController.text,
      // TRANSPORTATION
      'transportationType': transportationTypeController.text,
      // ACCOMMODATION
      'accommodationType': accommodationTypeController.text,
      // ACTIVITY
      'activityType': activityTypeController.text,
    };
  }

  @override
  void initState() {
    super.initState();
    bookingTypeController.addListener(() {
      setState(() {});
    });
    if (widget.item.id != null) {
      booking = BlocProvider.of<TripCubit>(context).getBooking(widget.item.id!);
      if(booking != null) {
        setState(() {
          providerNameController.text = booking!.providerName;
          bookingCodeController.text = booking!.bookingCode;
          bookingTypeController.text = booking!.bookingType;
          // TRANSPORTATION
          transportationTypeController.text = (booking!.detail as TransportationDetailModel).transportType;
          // ACCOMMODATION
          accommodationTypeController.text = (booking!.detail as AccommodationDetailModel).accommodationType;
          // ACTIVITY
          activityTypeController.text = (booking!.detail as ActivityDetailModel).activityType;
        });
      }
    }
  }

  void validateForm(BuildContext context) async {
    final formData = populateForm();
    if (formData['providerName']!.trim().isEmpty) {
      DialogHandler.showSnackBar(context: context, message: "Provider Name cannot be empty");
      return;
    }
    if (formData['bookingCode']!.trim().isEmpty) {
      DialogHandler.showSnackBar(context: context, message: "Booking Code cannot be empty");
      return;
    }
    if (formData['bookingType']!.trim().isEmpty) {
      DialogHandler.showSnackBar(context: context, message: "Booking Type cannot be empty");
      return;
    }
    // TRANSPORTATION
    // ACCOMMODATION
    // ACTIVITY
    if(widget.item.id != null) {
      showSaveDialog(context, formData);
    } else {
      onSubmit(context, formData);
    }
  }

  void onSubmit(BuildContext context, Map<String, String> data) async {
    BookingDetailModel detail = BookingDetailModel();
    if(data['bookingType'] == 'Transportation') {
      detail = TransportationDetailModel(
          transportType: 'transportType',
          transportName: 'transportName',
          vehicleName: 'vehicleName',
          seatNumber: 'seatNumber',
          departureTime: DateTime.now(),
          arrivalTime: DateTime.now(),
          pickUpPoint: 'pickUpPoint',
          dropOffPoint: 'dropOffPoint',
          departureLocation: 'departureLocation',
          arrivalLocation: 'arrivalLocation'
      );
    } else if(data['bookingType'] == 'Accommodation') {
      detail = AccommodationDetailModel(
          accommodationType: 'accommodationType',
          accommodationName: 'accommodationName',
          address: 'address',
          roomType: 'roomType',
          roomNumber: 'roomNumber',
          checkIn: DateTime.now(),
          checkOut: DateTime.now(),
          contact: 'contact',
          email: 'email'
      );
    } else if(data['bookingType'] == 'Activity') {
      detail = ActivityDetailModel(
          activityType: 'activityType',
          activityName: 'activityName',
          address: 'address',
          startTime: DateTime.now(),
          endTime: DateTime.now(),
          contact: 'contact',
          guideName: 'guideName'
      );
    }
    try {
      await BlocProvider.of<TripCubit>(context).saveBooking(
          BookingModel(
            id: widget.item.id != null ? widget.item.id! : const Uuid().v4(),
            providerName: data['providerName']!,
            bookingCode: data['bookingCode']!,
            bookingType: data['bookingType']!,
            attachments: [],
            detail: detail,
            tripId: widget.item.tripId,
            createdAt: widget.item.id != null ? booking!.createdAt : DateTime.now(),
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
    await BlocProvider.of<TripCubit>(context).deleteBooking(widget.item.id!);
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

  Widget headerItem(String title) {
    return Container(
        padding: const EdgeInsets.only(top: 8, bottom: 24, left: 8, right: 8),
        child: Row(
          children: [
            const Icon(Icons.circle, size: 18),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
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
                    title: "Provider Name",
                    controller: providerNameController
                ),
                TextFieldItem(
                    title: "Booking Code",
                    inputType: TextInputType.multiline,
                    controller: bookingCodeController
                ),
                DropDownItem(
                  title: "Booking Type",
                  controller: bookingTypeController,
                  items: bookingCategoryTypes
                      .map((c) => {'title': c.name, 'icon': c.icon})
                      .toList(),
                ),
                if (bookingTypeController.text == 'Transportation')
                  Column(
                    children: [
                      headerItem('Transportation Detail'),
                      DropDownItem(
                        title: "Transportation Type",
                        controller: transportationTypeController,
                        items: transportationTypes
                            .map((c) => {'title': c.name, 'icon': c.icon})
                            .toList(),
                      ),
                      TextFieldItem(
                          title: "Transportation Name",
                          controller: transportationNameController
                      ),
                      TextFieldItem(
                          title: "Vehicle Name",
                          controller: vehicleNameController
                      ),
                      TextFieldItem(
                          title: "Seat Number",
                          controller: seatNumberController
                      ),
                      TextFieldItem(
                        title: "Departure Time",
                        formType: FormType.date,
                        controller: departureTimeController,
                      ),
                      TextFieldItem(
                        title: "Arrival Time",
                        formType: FormType.date,
                        controller: arrivalTimeController,
                      ),
                      TextFieldItem(
                          title: "Pickup Point",
                          controller: pickupPointController
                      ),
                      TextFieldItem(
                          title: "Drop off Point",
                          controller: dropOffPointController
                      ),
                      TextFieldItem(
                          title: "Departure Location",
                          controller: departureLocationController
                      ),
                      TextFieldItem(
                          title: "Arrival Location",
                          controller: arrivalLocationController
                      ),
                    ],
                  ),
                if (bookingTypeController.text == 'Accommodation')
                  Column(
                    children: [
                      headerItem('Accommodation Detail'),
                      DropDownItem(
                        title: "Accommodation Type",
                        controller: accommodationTypeController,
                        items: accommodationTypes
                            .map((c) => {'title': c.name, 'icon': c.icon})
                            .toList(),
                      ),
                      TextFieldItem(
                          title: "Accommodation Name",
                          controller: accommodationNameController
                      ),
                      TextFieldItem(
                          title: "Address",
                          controller: accommodationAddressController
                      ),
                      TextFieldItem(
                          title: "Room Type",
                          controller: roomTypeController
                      ),
                      TextFieldItem(
                          title: "Room Number",
                          controller: roomNumberController
                      ),
                      TextFieldItem(
                        title: "Check-In",
                        formType: FormType.date,
                        controller: checkInController,
                      ),
                      TextFieldItem(
                        title: "Check-Out",
                        formType: FormType.date,
                        controller: checkOutController,
                      ),
                      TextFieldItem(
                          title: "Contact",
                          controller: accommodationContactController
                      ),
                      TextFieldItem(
                          title: "Email",
                          controller: accommodationEmailController
                      ),
                    ],
                  ),
                if (bookingTypeController.text == 'Activity')
                  Column(
                    children: [
                      headerItem('Activity Detail'),
                      DropDownItem(
                        title: "Activity Type",
                        controller: activityTypeController,
                        items: activityTypes
                            .map((c) => {'title': c.name, 'icon': c.icon})
                            .toList(),
                      ),
                      TextFieldItem(
                          title: "Activity Name",
                          controller: activityNameController
                      ),
                      TextFieldItem(
                          title: "Address",
                          controller: activityAddressController
                      ),
                      TextFieldItem(
                        title: "Start Time",
                        formType: FormType.date,
                        controller: startTimeController,
                      ),
                      TextFieldItem(
                        title: "End Time",
                        formType: FormType.date,
                        controller: endTimeController,
                      ),
                      TextFieldItem(
                          title: "Contact",
                          controller: activityContactController
                      ),
                      TextFieldItem(
                          title: "Guide Name",
                          controller: activityGuideNameController
                      ),
                    ],
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
          title: Text("${widget.item.id == null ? "Add" : "Edit"} Booking"),
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