import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injector.dart';
import '../../../core/constant/routes_values.dart';
import '../../../core/handler/dialog_handler.dart';
import '../../../core/model/arguments/common_add_args.dart';
import '../../../core/widget/loading_state.dart';
import '../../../core/widget/not_found_state.dart';
import '../cubit/trip_cubit.dart';
import '../cubit/trip_state.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class BookingDetailPageProvider extends StatelessWidget {
  const BookingDetailPageProvider({super.key, required this.item});
  final CommonAddArgs item;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TripCubit>(),
      child: BookingDetailPage(item: item),
    );
  }
}

class BookingDetailPage extends StatefulWidget {
  const BookingDetailPage({super.key, required this.item});
  final CommonAddArgs item;
  @override
  State<BookingDetailPage> createState() => _BookingDetailPageState();
}

class _BookingDetailPageState extends State<BookingDetailPage>
    with SingleTickerProviderStateMixin {
  String detailType = '';

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  void refreshData() {
    context.read<TripCubit>().getBookingDetail(widget.item.id!);
  }

  void navigateBookingEdit() {
    Navigator.pushNamed(
      context,
      RoutesValues.bookingAdd,
      arguments: CommonAddArgs(id: widget.item.id, tripId: widget.item.tripId),
    ).then((value) {
      refreshData();
    });
  }

  void showDataWarning() {
    DialogHandler.showConfirmDialog(
      context: context,
      title: "Data Protection",
      description:
          "All data is stored locally on your device. Uninstalling or clearing the app will permanently delete it. Be sure to back up anything important.",
      confirmText: "I Understand",
      onConfirm: () => Navigator.pop(context),
      isCancelable: false,
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

  Widget bookingGridItem(Map<String, dynamic> entry, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).hoverColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.shadow, width: 1),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            entry['icon'] as IconData,
            size: 32,
            color: Theme.of(context).iconTheme.color,
          ),
          const SizedBox(height: 12),
          Text(
            entry['title'] as String,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          const SizedBox(height: 6),
          Text(
            entry['value'] as String,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodySmall?.color,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget bookingDetailLoaded(BuildContext context, BookingDetailLoaded state) {
    final booking = state.booking;

    if (booking == null) {
      return const NotFoundState(
        title: 'Booking not found',
        subtitle: 'We couldn\'t find the booking you are looking for.',
      );
    }

    List<Map<String, dynamic>> bookingEntries = [
      {
        'icon': Icons.business_rounded,
        'title': 'Provider Name',
        'value': booking.providerName,
      },
      {
        'icon': Icons.confirmation_number_rounded,
        'title': 'Booking Code',
        'value': booking.bookingCode,
      },
      {
        'icon': Icons.category_rounded,
        'title': 'Booking Type',
        'value': booking.bookingType,
      },
      // {
      //   'icon': Icons.attach_file_rounded,
      //   'title': 'Attachments',
      //   'value': booking.attachments.isNotEmpty
      //       ? '${booking.attachments.length} file(s)'
      //       : 'None',
      // },
    ];

    List<Map<String, dynamic>> detailEntries = [];

    // Add detail fields
    final detail = booking.detail;
    if (detail.runtimeType.toString() == 'AccommodationDetailModel') {
      detailType = 'Accommodation';
      final d = detail as dynamic;
      bookingEntries.addAll([
        {
          'icon': Icons.hotel_rounded,
          'title': 'Accom. Type',
          'value': d.accommodationType,
        },
      ]);
      detailEntries.addAll([
        {
          'icon': Icons.hotel_rounded,
          'title': 'Accom. Name',
          'value': d.accommodationName,
        },
        {
          'icon': Icons.location_on_rounded,
          'title': 'Address',
          'value': d.address,
        },
        {
          'icon': Icons.meeting_room_rounded,
          'title': 'Room Type',
          'value': d.roomType,
        },
        {
          'icon': Icons.confirmation_number_rounded,
          'title': 'Room Number',
          'value': d.roomNumber,
        },
        {'icon': Icons.login_rounded, 'title': 'Check In', 'value': d.checkIn},
        {
          'icon': Icons.logout_rounded,
          'title': 'Check Out',
          'value': d.checkOut,
        },
        {'icon': Icons.phone_rounded, 'title': 'Contact', 'value': d.contact},
        {'icon': Icons.email_rounded, 'title': 'Email', 'value': d.email},
      ]);
    } else if (detail.runtimeType.toString() == 'TransportationDetailModel') {
      detailType = 'Transportation';
      final d = detail as dynamic;
      bookingEntries.addAll([
        {
          'icon': Icons.directions_bus_rounded,
          'title': 'Transport Type',
          'value': d.transportType,
        },
      ]);
      detailEntries.addAll([
        {
          'icon': Icons.directions_bus_rounded,
          'title': 'Transport Name',
          'value': d.transportName,
        },
        {
          'icon': Icons.directions_car_rounded,
          'title': 'Vehicle Name',
          'value': d.vehicleName,
        },
        {
          'icon': Icons.event_seat_rounded,
          'title': 'Seat Number',
          'value': d.seatNumber,
        },
        {
          'icon': Icons.schedule_rounded,
          'title': 'Departure Time',
          'value': d.departureTime,
        },
        {
          'icon': Icons.schedule_rounded,
          'title': 'Arrival Time',
          'value': d.arrivalTime,
        },
        {
          'icon': Icons.location_on_rounded,
          'title': 'Pickup Point',
          'value': d.pickUpPoint,
        },
        {
          'icon': Icons.location_on_rounded,
          'title': 'Drop Off Point',
          'value': d.dropOffPoint,
        },
        {
          'icon': Icons.location_on_rounded,
          'title': 'Departure Loc.',
          'value': d.departureLocation,
        },
        {
          'icon': Icons.location_on_rounded,
          'title': 'Arrival Loc.',
          'value': d.arrivalLocation,
        },
      ]);
    } else if (detail.runtimeType.toString() == 'ActivityDetailModel') {
      detailType = 'Activity';
      final d = detail as dynamic;
      bookingEntries.addAll([
        {
          'icon': Icons.event_rounded,
          'title': 'Activity Type',
          'value': d.activityType,
        },
      ]);
      detailEntries.addAll([
        {
          'icon': Icons.event_rounded,
          'title': 'Activity Name',
          'value': d.activityName,
        },
        {
          'icon': Icons.location_on_rounded,
          'title': 'Address',
          'value': d.address,
        },
        {
          'icon': Icons.schedule_rounded,
          'title': 'Start Time',
          'value': d.startTime,
        },
        {
          'icon': Icons.schedule_rounded,
          'title': 'End Time',
          'value': d.endTime,
        },
        {'icon': Icons.phone_rounded, 'title': 'Contact', 'value': d.contact},
        {
          'icon': Icons.person_rounded,
          'title': 'Guide Name',
          'value': d.guideName,
        },
      ]);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        title: const Text('Booking Detail'),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(Icons.edit_note_outlined),
              tooltip: 'Edit',
              onPressed: navigateBookingEdit,
            ),
          ),
        ],
      ),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StaggeredGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: [
                  for (final entry in bookingEntries)
                    StaggeredGridTile.fit(
                      crossAxisCellCount: 1,
                      child: bookingGridItem(entry, context),
                    ),
                ],
              ),
              if (detailEntries.isNotEmpty) ...[
                const SizedBox(height: 16),
                headerItem('$detailType Detail'),
                StaggeredGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  children: [
                    for (final entry in detailEntries)
                      StaggeredGridTile.fit(
                        crossAxisCellCount:
                        (entry['title'] == 'Accom. Name' ||
                            entry['title'] == 'Transport Name' ||
                            entry['title'] == 'Activity Name' ||
                            entry['title'] == 'Address')
                            ? 2
                            : 1,
                        child: bookingGridItem(entry, context),
                      ),
                  ],
                ),
                if (booking.attachments.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  headerItem('Attachments'),
                  for (final imageBytes in booking.attachments)
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RoutesValues.viewImage,
                          arguments: imageBytes,
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 200,
                        margin: const EdgeInsets.only(
                          bottom: 16,
                          left: 4,
                          right: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.memory(
                            imageBytes,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            height: 200,
                          ),
                        ),
                      ),
                    ),
                ],
              ],
            ],
          ),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripCubit, TripCubitState>(
      builder: (context, state) {
        if (state is TripInitial) {
          return const SizedBox.shrink();
        } else if (state is TripLoading) {
          return Scaffold(appBar: AppBar(), body: const LoadingState());
        } else if (state is BookingDetailLoaded) {
          return bookingDetailLoaded(context, state);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
