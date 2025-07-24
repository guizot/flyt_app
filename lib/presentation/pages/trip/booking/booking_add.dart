import 'package:flutter/cupertino.dart';
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
import 'dart:typed_data';
import '../../../../data/models/local/booking_model.dart';
import '../../../../injector.dart';
import '../../../core/constant/form_type.dart';
import '../../../core/handler/dialog_handler.dart';
import '../../../core/model/static/booking_category.dart';
import '../../../core/widget/add_multiple_image_item.dart';
import '../../../core/widget/drop_down_item.dart';
import '../../../core/widget/loading_state.dart';
import '../../../core/widget/text_field_item.dart';
import '../cubit/trip_cubit.dart';
import '../cubit/trip_state.dart';

class BookingAddProvider extends StatelessWidget {
  const BookingAddProvider({super.key, required this.item});
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
  TextEditingController accommodationAddressController =
      TextEditingController();
  TextEditingController roomTypeController = TextEditingController();
  TextEditingController roomNumberController = TextEditingController();
  TextEditingController checkInController = TextEditingController();
  TextEditingController checkOutController = TextEditingController();
  TextEditingController accommodationContactController =
      TextEditingController();
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
  List<Uint8List> attachments = [];

  Map<String, String> populateForm() {
    return {
      'providerName': providerNameController.text,
      'bookingCode': bookingCodeController.text,
      'bookingType': bookingTypeController.text,
      // TRANSPORTATION
      'transportationType': transportationTypeController.text,
      'transportationName': transportationNameController.text,
      'vehicleName': vehicleNameController.text,
      'seatNumber': seatNumberController.text,
      'departureTime': departureTimeController.text,
      'arrivalTime': arrivalTimeController.text,
      'pickupPoint': pickupPointController.text,
      'dropOffPoint': dropOffPointController.text,
      'departureLocation': departureLocationController.text,
      'arrivalLocation': arrivalLocationController.text,
      // ACCOMMODATION
      'accommodationType': accommodationTypeController.text,
      'accommodationName': accommodationNameController.text,
      'accommodationAddress': accommodationAddressController.text,
      'roomType': roomTypeController.text,
      'roomNumber': roomNumberController.text,
      'checkIn': checkInController.text,
      'checkOut': checkOutController.text,
      'accommodationContact': accommodationContactController.text,
      'accommodationEmail': accommodationEmailController.text,
      // ACTIVITY
      'activityType': activityTypeController.text,
      'activityName': activityNameController.text,
      'activityAddress': activityAddressController.text,
      'startTime': startTimeController.text,
      'endTime': endTimeController.text,
      'activityContact': activityContactController.text,
      'activityGuideName': activityGuideNameController.text,
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
      if (booking != null) {
        setState(() {
          providerNameController.text = booking!.providerName;
          bookingCodeController.text = booking!.bookingCode;
          bookingTypeController.text = booking!.bookingType;

          // TRANSPORTATION
          if (booking!.bookingType == 'Transportation') {
            TransportationDetailModel dtl =
                booking!.detail as TransportationDetailModel;
            transportationTypeController.text = dtl.transportType;
            transportationNameController.text = dtl.transportName;
            vehicleNameController.text = dtl.vehicleName;
            seatNumberController.text = dtl.seatNumber;
            departureTimeController.text = dtl.departureTime.toString();
            arrivalTimeController.text = dtl.arrivalTime.toString();
            pickupPointController.text = dtl.pickUpPoint;
            dropOffPointController.text = dtl.dropOffPoint;
            departureLocationController.text = dtl.departureLocation;
            arrivalLocationController.text = dtl.arrivalLocation;
          }
          // ACCOMMODATION
          else if (booking!.bookingType == 'Accommodation') {
            AccommodationDetailModel dtl =
                booking!.detail as AccommodationDetailModel;
            accommodationTypeController.text = dtl.accommodationType;
            accommodationNameController.text = dtl.accommodationName;
            accommodationAddressController.text = dtl.address;
            roomTypeController.text = dtl.roomType;
            roomNumberController.text = dtl.roomNumber;
            checkInController.text = dtl.checkIn.toString();
            checkOutController.text = dtl.checkOut.toString();
            accommodationContactController.text = dtl.contact;
            accommodationEmailController.text = dtl.email;
          }
          // ACTIVITY
          else if (booking!.bookingType == 'Activity') {
            ActivityDetailModel dtl = booking!.detail as ActivityDetailModel;
            activityTypeController.text = dtl.activityType;
            activityNameController.text = dtl.activityName;
            activityAddressController.text = dtl.address;
            startTimeController.text = dtl.startTime.toString();
            endTimeController.text = dtl.endTime.toString();
            activityContactController.text = dtl.contact;
            activityGuideNameController.text = dtl.guideName;
          }
          attachments = List<Uint8List>.from(booking!.attachments);
        });
      }
    }
  }

  void validateForm(BuildContext context) async {
    final formData = populateForm();
    if (formData['providerName']!.trim().isEmpty) {
      DialogHandler.showSnackBar(
        context: context,
        message: "Provider Name cannot be empty",
      );
      return;
    }
    if (formData['bookingCode']!.trim().isEmpty) {
      DialogHandler.showSnackBar(
        context: context,
        message: "Booking Code cannot be empty",
      );
      return;
    }
    if (formData['bookingType']!.trim().isEmpty) {
      DialogHandler.showSnackBar(
        context: context,
        message: "Booking Type cannot be empty",
      );
      return;
    }

    // TRANSPORTATION
    if (formData['bookingType'] == 'Transportation') {
      if (formData['transportationType']!.trim().isEmpty) {
        DialogHandler.showSnackBar(
          context: context,
          message: "Transportation Type cannot be empty",
        );
        return;
      }
      if (formData['transportationName']!.trim().isEmpty) {
        DialogHandler.showSnackBar(
          context: context,
          message: "Transportation Name cannot be empty",
        );
        return;
      }
      if (formData['vehicleName']!.trim().isEmpty) {
        DialogHandler.showSnackBar(
          context: context,
          message: "Vehicle Name cannot be empty",
        );
        return;
      }
      if (formData['seatNumber']!.trim().isEmpty) {
        DialogHandler.showSnackBar(
          context: context,
          message: "Seat Number cannot be empty",
        );
        return;
      }
      if (formData['departureTime']!.trim().isEmpty) {
        DialogHandler.showSnackBar(
          context: context,
          message: "Departure Time cannot be empty",
        );
        return;
      }
      if (formData['arrivalTime']!.trim().isEmpty) {
        DialogHandler.showSnackBar(
          context: context,
          message: "Arrival Time cannot be empty",
        );
        return;
      }
      if (formData['pickupPoint']!.trim().isEmpty) {
        DialogHandler.showSnackBar(
          context: context,
          message: "Pickup Point cannot be empty",
        );
        return;
      }
      if (formData['dropOffPoint']!.trim().isEmpty) {
        DialogHandler.showSnackBar(
          context: context,
          message: "Drop Off Point cannot be empty",
        );
        return;
      }
      if (formData['departureLocation']!.trim().isEmpty) {
        DialogHandler.showSnackBar(
          context: context,
          message: "Departure Location cannot be empty",
        );
        return;
      }
      if (formData['arrivalLocation']!.trim().isEmpty) {
        DialogHandler.showSnackBar(
          context: context,
          message: "Arrival Location cannot be empty",
        );
        return;
      }
    }
    // ACCOMMODATION
    else if (formData['bookingType'] == 'Accommodation') {
      if (formData['accommodationType']!.trim().isEmpty) {
        DialogHandler.showSnackBar(
          context: context,
          message: "Accommodation Type cannot be empty",
        );
        return;
      }
      if (formData['accommodationName']!.trim().isEmpty) {
        DialogHandler.showSnackBar(
          context: context,
          message: "Accommodation Name cannot be empty",
        );
        return;
      }
      if (formData['accommodationAddress']!.trim().isEmpty) {
        DialogHandler.showSnackBar(
          context: context,
          message: "Address cannot be empty",
        );
        return;
      }
      if (formData['roomType']!.trim().isEmpty) {
        DialogHandler.showSnackBar(
          context: context,
          message: "Room Type cannot be empty",
        );
        return;
      }
      if (formData['roomNumber']!.trim().isEmpty) {
        DialogHandler.showSnackBar(
          context: context,
          message: "Room Number cannot be empty",
        );
        return;
      }
      if (formData['checkIn']!.trim().isEmpty) {
        DialogHandler.showSnackBar(
          context: context,
          message: "Check-In cannot be empty",
        );
        return;
      }
      if (formData['checkOut']!.trim().isEmpty) {
        DialogHandler.showSnackBar(
          context: context,
          message: "Check-Out cannot be empty",
        );
        return;
      }
      if (formData['accommodationContact']!.trim().isEmpty) {
        DialogHandler.showSnackBar(
          context: context,
          message: "Contact cannot be empty",
        );
        return;
      }
      if (formData['accommodationEmail']!.trim().isEmpty) {
        DialogHandler.showSnackBar(
          context: context,
          message: "Email cannot be empty",
        );
        return;
      }
    }
    // ACTIVITY
    else if (formData['bookingType'] == 'Activity') {
      if (formData['activityType']!.trim().isEmpty) {
        DialogHandler.showSnackBar(
          context: context,
          message: "Activity Type cannot be empty",
        );
        return;
      }
      if (formData['activityName']!.trim().isEmpty) {
        DialogHandler.showSnackBar(
          context: context,
          message: "Activity Name cannot be empty",
        );
        return;
      }
      if (formData['activityAddress']!.trim().isEmpty) {
        DialogHandler.showSnackBar(
          context: context,
          message: "Address cannot be empty",
        );
        return;
      }
      if (formData['startTime']!.trim().isEmpty) {
        DialogHandler.showSnackBar(
          context: context,
          message: "Start Time cannot be empty",
        );
        return;
      }
      if (formData['endTime']!.trim().isEmpty) {
        DialogHandler.showSnackBar(
          context: context,
          message: "End Time cannot be empty",
        );
        return;
      }
      if (formData['activityContact']!.trim().isEmpty) {
        DialogHandler.showSnackBar(
          context: context,
          message: "Contact cannot be empty",
        );
        return;
      }
      if (formData['activityGuideName']!.trim().isEmpty) {
        DialogHandler.showSnackBar(
          context: context,
          message: "Guide Name cannot be empty",
        );
        return;
      }
    }
    if (widget.item.id != null) {
      showSaveDialog(context, formData);
    } else {
      onSubmit(context, formData);
    }
  }

  void onSubmit(BuildContext context, Map<String, String> data) async {
    BookingDetailModel detail = BookingDetailModel();
    if (data['bookingType'] == 'Transportation') {
      detail = TransportationDetailModel(
        transportType: data['transportationType']!,
        transportName: data['transportationName']!,
        vehicleName: data['vehicleName']!,
        seatNumber: data['seatNumber']!,
        departureTime: data['departureTime']!,
        arrivalTime: data['arrivalTime']!,
        pickUpPoint: data['pickupPoint']!,
        dropOffPoint: data['dropOffPoint']!,
        departureLocation: data['departureLocation']!,
        arrivalLocation: data['arrivalLocation']!,
      );
    } else if (data['bookingType'] == 'Accommodation') {
      detail = AccommodationDetailModel(
        accommodationType: data['accommodationType']!,
        accommodationName: data['accommodationName']!,
        address: data['accommodationAddress']!,
        roomType: data['roomType']!,
        roomNumber: data['roomNumber']!,
        checkIn: data['checkIn']!,
        checkOut: data['checkOut']!,
        contact: data['accommodationContact']!,
        email: data['accommodationEmail']!,
      );
    } else if (data['bookingType'] == 'Activity') {
      detail = ActivityDetailModel(
        activityType: data['activityType']!,
        activityName: data['activityName']!,
        address: data['activityAddress']!,
        startTime: data['startTime']!,
        endTime: data['endTime']!,
        contact: data['activityContact']!,
        guideName: data['activityGuideName']!,
      );
    }
    try {
      await BlocProvider.of<TripCubit>(context).saveBooking(
        BookingModel(
          id: widget.item.id != null ? widget.item.id! : const Uuid().v4(),
          providerName: data['providerName']!,
          bookingCode: data['bookingCode']!,
          bookingType: data['bookingType']!,
          detail: detail,
          attachments: attachments,
          tripId: widget.item.tripId,
          createdAt: widget.item.id != null
              ? booking!.createdAt
              : DateTime.now(),
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
    await BlocProvider.of<TripCubit>(context).deleteBooking(widget.item.id!);
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
                controller: providerNameController,
              ),
              TextFieldItem(
                title: "Booking Code",
                inputType: TextInputType.multiline,
                controller: bookingCodeController,
              ),
              DropDownItem(
                title: "Booking Type",
                controller: bookingTypeController,
                items: bookingCategoryTypes
                    .map((c) => {'title': c.name, 'icon': c.icon})
                    .toList(),
              ),
              bookingTypeController.text == 'Transportation'
                  ? Column(
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
                          controller: transportationNameController,
                        ),
                        TextFieldItem(
                          title: "Vehicle Name",
                          controller: vehicleNameController,
                        ),
                        TextFieldItem(
                          title: "Seat Number",
                          controller: seatNumberController,
                        ),
                        TextFieldItem(
                          title: "Departure Time",
                          formType: FormType.date,
                          pickerMode: CupertinoDatePickerMode.dateAndTime,
                          controller: departureTimeController,
                        ),
                        TextFieldItem(
                          title: "Arrival Time",
                          formType: FormType.date,
                          pickerMode: CupertinoDatePickerMode.dateAndTime,
                          controller: arrivalTimeController,
                        ),
                        TextFieldItem(
                          title: "Pickup Point",
                          controller: pickupPointController,
                        ),
                        TextFieldItem(
                          title: "Drop off Point",
                          controller: dropOffPointController,
                        ),
                        TextFieldItem(
                          title: "Departure Location",
                          controller: departureLocationController,
                        ),
                        TextFieldItem(
                          title: "Arrival Location",
                          controller: arrivalLocationController,
                        ),
                      ],
                    )
                  : Container(),
              bookingTypeController.text == 'Accommodation'
                  ? Column(
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
                          controller: accommodationNameController,
                        ),
                        TextFieldItem(
                          title: "Address",
                          controller: accommodationAddressController,
                        ),
                        TextFieldItem(
                          title: "Room Type",
                          controller: roomTypeController,
                        ),
                        TextFieldItem(
                          title: "Room Number",
                          controller: roomNumberController,
                        ),
                        TextFieldItem(
                          title: "Check-In",
                          formType: FormType.date,
                          pickerMode: CupertinoDatePickerMode.dateAndTime,
                          controller: checkInController,
                        ),
                        TextFieldItem(
                          title: "Check-Out",
                          formType: FormType.date,
                          pickerMode: CupertinoDatePickerMode.dateAndTime,
                          controller: checkOutController,
                        ),
                        TextFieldItem(
                          title: "Contact",
                          controller: accommodationContactController,
                        ),
                        TextFieldItem(
                          title: "Email",
                          controller: accommodationEmailController,
                        ),
                      ],
                    )
                  : Container(),
              bookingTypeController.text == 'Activity'
                  ? Column(
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
                          controller: activityNameController,
                        ),
                        TextFieldItem(
                          title: "Address",
                          controller: activityAddressController,
                        ),
                        TextFieldItem(
                          title: "Start Time",
                          formType: FormType.date,
                          pickerMode: CupertinoDatePickerMode.dateAndTime,
                          controller: startTimeController,
                        ),
                        TextFieldItem(
                          title: "End Time",
                          formType: FormType.date,
                          pickerMode: CupertinoDatePickerMode.dateAndTime,
                          controller: endTimeController,
                        ),
                        TextFieldItem(
                          title: "Contact",
                          controller: activityContactController,
                        ),
                        TextFieldItem(
                          title: "Guide Name",
                          controller: activityGuideNameController,
                        ),
                      ],
                    )
                  : Container(),
              AddMultipleImageItem(
                title: "Attachments",
                initialImages: attachments,
                onImagesChanged: (images) {
                  setState(() {
                    attachments = List<Uint8List>.from(images);
                  });
                },
              ),
            ],
          ),
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
        color: Theme.of(context).colorScheme.surface,
        child: BlocBuilder<TripCubit, TripCubitState>(
          builder: (blocContext, state) {
            if (state is TripInitial) {
              return bookingInitial(context);
            } else if (state is TripLoading) {
              return const LoadingState();
            }
            return Container();
          },
        ),
      )
    );
  }
}
