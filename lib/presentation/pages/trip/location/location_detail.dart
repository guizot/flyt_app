import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyt_app/presentation/pages/trip/location/location_detail_item.dart';
import '../../../../injector.dart';
import '../../../core/constant/routes_values.dart';
import '../../../core/handler/dialog_handler.dart';
import '../../../core/model/arguments/common_add_args.dart';
import '../../../core/widget/loading_state.dart';
import '../../../core/widget/not_found_state.dart';
import '../cubit/trip_cubit.dart';
import '../cubit/trip_state.dart';

class LocationDetailPageProvider extends StatelessWidget {
  const LocationDetailPageProvider({super.key, required this.item });
  final CommonAddArgs item;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TripCubit>(),
      child: LocationDetailPage(item: item)
    );
  }
}

class LocationDetailPage extends StatefulWidget {
  const LocationDetailPage({super.key, required this.item });
  final CommonAddArgs item;
  @override
  State<LocationDetailPage> createState() => _LocationDetailPageState();
}

class _LocationDetailPageState extends State<LocationDetailPage> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  void refreshData() {
    context.read<TripCubit>().getLocationDetail(widget.item.id!);
  }

  void navigateLocationEdit() {
    Navigator.pushNamed(
      context,
      RoutesValues.locationAdd,
      arguments: CommonAddArgs(id: widget.item.id!, tripId: widget.item.tripId),
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

  Widget locationDetailLoaded(BuildContext context, LocationDetailLoaded state) {
    final location = state.location;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        title: const Text('Location Detail'),
        centerTitle: true,
        actions: location != null ? [
          Container(
            margin: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(Icons.edit_note_outlined),
              tooltip: 'Edit',
              onPressed: navigateLocationEdit,
            ),
          ),
        ] : null,
      ),
      body: location == null
          ? const NotFoundState(
        title: 'Location not found',
        subtitle: 'We couldn\'t find the location you are looking for.',
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 1 + // for the image section
            (location.note != null && location.note!.isNotEmpty ? 8 : 7),
        itemBuilder: (context, index) {
          if (index == 0) {
            // Show image section
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RoutesValues.viewImage,
                  arguments: location.photoBytes,
                );
              },
              child: Container(
                width: double.infinity,
                height: 200,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                alignment: Alignment.center,
                child: location.photoBytes != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.memory(
                    location.photoBytes!,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    height: 200,
                  ),
                )
                    : const Icon(Icons.image_not_supported_outlined),
              ),
            );
          }

          final indexOffset = index - 1;
          final items = <MapEntry<String, String>>[
            MapEntry('Name', location.name),
            MapEntry('Type', location.type),
            MapEntry('Address', location.address),
            MapEntry('Phone', location.phone),
            MapEntry('Email', location.email),
            MapEntry('Website', location.website),
            MapEntry('Map URL', location.mapUrl),
            if (location.note != null && location.note!.isNotEmpty)
              MapEntry('Note', location.note!),
          ];

          final copyableKeys = {
            'Address',
            'Phone',
            'Email',
            'Website',
            'Map URL',
          };

          final entry = items[indexOffset];
          final isCopyable = copyableKeys.contains(entry.key);

          return LocationDetailItem(
            title: entry.key,
            description: entry.value,
            onTap: isCopyable
                ? () {
              Clipboard.setData(
                  ClipboardData(text: entry.value));
            }
                : null,
          );
        },
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
        } else if (state is LocationDetailLoaded) {
          return locationDetailLoaded(context, state);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
