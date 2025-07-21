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

class BookingDetailPageProvider extends StatelessWidget {
  const BookingDetailPageProvider({super.key, required this.item });
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
  const BookingDetailPage({super.key, required this.item });
  final CommonAddArgs item;
  @override
  State<BookingDetailPage> createState() => _BookingDetailPageState();
}

class _BookingDetailPageState extends State<BookingDetailPage> with SingleTickerProviderStateMixin {

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

  Widget bookingDetailLoaded(BuildContext context, BookingDetailLoaded state) {
    final booking = state.booking;

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
      body: booking == null
          ? const NotFoundState(
        title: 'Booking not found',
        subtitle: 'We couldn\'t find the booking you are looking for.',
      )
          : ListView(
            children: [
              Text(booking.providerName)
          ],
      ),
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
