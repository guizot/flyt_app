import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyt_app/data/models/local/booking_model.dart';
import 'package:flyt_app/data/models/local/note_model.dart';
import 'package:flyt_app/data/models/local/path_model.dart';
import 'package:flyt_app/presentation/core/model/arguments/common_add_args.dart';
import 'package:flyt_app/presentation/core/model/common/itinerary_group.dart';
import 'package:flyt_app/presentation/pages/trip/booking/booking_item.dart';
import 'package:flyt_app/presentation/pages/trip/path/path_filter.dart';
import 'package:flyt_app/presentation/pages/trip/path/path_item.dart';
import '../../../data/models/local/bookingdetail/accommodation_detail_model.dart';
import '../../../data/models/local/bookingdetail/activity_detail_model.dart';
import '../../../data/models/local/bookingdetail/transportation_detail_model.dart';
import '../../../data/models/local/location_model.dart';
import '../../../data/models/local/trip_model.dart';
import '../../../injector.dart';
import '../../core/constant/routes_values.dart';
import '../../core/handler/dialog_handler.dart';
import '../../core/model/static/location_types.dart';
import '../../core/widget/empty_state.dart';
import '../../core/widget/loading_state.dart';
import 'booking/booking_filter.dart';
import 'cubit/trip_cubit.dart';
import 'cubit/trip_state.dart';
import 'description/description_item.dart';
import 'itinerary/itinerary_group_item.dart';
import 'location/location_filter.dart';
import 'location/location_item.dart';
import 'note/note_item.dart';

class TripDetailPageProvider extends StatelessWidget {
  const TripDetailPageProvider({super.key, this.id});
  final String? id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TripCubit>(),
      child: TripDetailPage(id: id),
    );
  }
}

class TripDetailPage extends StatefulWidget {
  const TripDetailPage({super.key, this.id});
  final String? id;
  @override
  State<TripDetailPage> createState() => _TripDetailPageState();
}

class _TripDetailPageState extends State<TripDetailPage> with SingleTickerProviderStateMixin {

  int selectedTabIndex = 0;
  late PageController _pageController;
  late ScrollController _tabScrollController;
  final List<GlobalKey> _tabKeys = List.generate(6, (_) => GlobalKey());

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedTabIndex);
    _tabScrollController = ScrollController();
    refreshData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabScrollController.dispose();
    super.dispose();
  }

  void refreshData() {
    context.read<TripCubit>().getAllDetail(widget.id!);
  }

  void scrollToSelectedTab() {
    final keyContext = _tabKeys[selectedTabIndex].currentContext;
    if (keyContext != null) {
      Scrollable.ensureVisible(
        keyContext,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: 0.5, // Center the tab, or use 0.0 for left
      );
    }
  }

  void changeTab(int index) {
    setState(() => selectedTabIndex = index);
    _pageController.jumpToPage(index);
    scrollToSelectedTab();
  }

  // region FILTER

  TextEditingController bookingTypeController = TextEditingController();
  TextEditingController bookingTypeItemController = TextEditingController();

  void filterBooking() {
    DialogHandler.showBottomSheet(
        context: context,
        child: BookingFilter(
          bookingTypeController: bookingTypeController,
          bookingTypeItemController: bookingTypeItemController,
          onFilterApplied: () {
            setState(() {});
          },
        )
    );
  }

  TextEditingController locationController = TextEditingController();

  void filterLocation(List<LocationType> usedLocationTypes) {
    DialogHandler.showBottomSheet(
        context: context,
        child: LocationFilter(
          controller: locationController,
          onFilterApplied: () {
            setState(() {});
          },
          usedLocationTypes: usedLocationTypes
        )
    );
  }

  TextEditingController locationListController = TextEditingController();

  void filterPath(List<LocationModel> locations) {
    DialogHandler.showBottomSheet(
        context: context,
        child: PathFilter(
          locationListController: locationListController,
          locations: locations,
          onFilterApplied: () {
            setState(() {});
          },
        )
    );
  }

  // endregion

  // region NAVIGATION

  void navigateAction(BuildContext context) {
    if (selectedTabIndex == 0) {
      navigateItineraryAdd(context);
    }
    else if (selectedTabIndex == 1) {
      navigateBookingAdd(context);
    }
    else if (selectedTabIndex == 2) {
      navigateLocationAdd(context);
    }
    else if (selectedTabIndex == 3) {
      navigatePathAdd(context);
    }
    else if (selectedTabIndex == 4) {
      navigateTripEdit(context);
    }
    else if (selectedTabIndex == 5) {
      navigateNoteAdd(context);
    }
  }

  void navigateTripEdit(BuildContext context) {
    Navigator.pushNamed(
      context,
      RoutesValues.tripAdd,
      arguments: widget.id!,
    ).then((value) {
      refreshData();
      if (value == 'delete' && context.mounted) {
        Navigator.pop(context);
      }
    });
  }

  void navigateNoteAdd(BuildContext context) {
    Navigator.pushNamed(
      context,
      RoutesValues.noteAdd,
      arguments: CommonAddArgs(tripId: widget.id!),
    ).then((value) {
      refreshData();
    });
  }

  void navigateNoteEdit(String id) {
    Navigator.pushNamed(
      context,
      RoutesValues.noteAdd,
      arguments: CommonAddArgs(id: id, tripId: widget.id!),
    ).then((value) {
      refreshData();
    });
  }

  void navigateLocationAdd(BuildContext context) {
    Navigator.pushNamed(
      context,
      RoutesValues.locationAdd,
      arguments: CommonAddArgs(tripId: widget.id!),
    ).then((value) {
      refreshData();
    });
  }

  void navigateLocationDetail(String id) {
    Navigator.pushNamed(
      context,
      RoutesValues.locationDetail,
      arguments: CommonAddArgs(id: id, tripId: widget.id!),
    ).then((value) {
      refreshData();
    });
  }

  void navigatePathAdd(BuildContext context) {
    Navigator.pushNamed(
      context,
      RoutesValues.pathAdd,
      arguments: CommonAddArgs(tripId: widget.id!),
    ).then((value) {
      refreshData();
    });
  }

  void navigatePathEdit(String id) {
    Navigator.pushNamed(
      context,
      RoutesValues.pathAdd,
      arguments: CommonAddArgs(id: id, tripId: widget.id!),
    ).then((value) {
      refreshData();
    });
  }

  void navigateItineraryAdd(BuildContext context) {
    Navigator.pushNamed(
      context,
      RoutesValues.itineraryAdd,
      arguments: CommonAddArgs(tripId: widget.id!),
    ).then((value) {
      refreshData();
    });
  }

  void navigateItineraryEdit(String id) {
    Navigator.pushNamed(
      context,
      RoutesValues.itineraryAdd,
      arguments: CommonAddArgs(id: id, tripId: widget.id!),
    ).then((value) {
      refreshData();
    });
  }

  void navigateBookingAdd(BuildContext context) {
    Navigator.pushNamed(
      context,
      RoutesValues.bookingAdd,
      arguments: CommonAddArgs(tripId: widget.id!),
    ).then((value) {
      refreshData();
    });
  }

  void navigateBookingDetail(String id) {
    Navigator.pushNamed(
      context,
      RoutesValues.bookingDetail,
      arguments: CommonAddArgs(id: id, tripId: widget.id!),
    ).then((value) {
      refreshData();
    });
  }

  // endregion

  // region PAGES

  Widget itineraryPage(
      List<ItineraryGroup> itineraries,
      List<LocationModel> locations,
      List<PathModel> paths
  ) {
    if (itineraries.isEmpty) {
      return EmptyState(
        title: "No Records",
        subtitle: "You haven’t added any itinerary. Once you do, they’ll appear here.",
        tapText: "Add Itinerary +",
        onTap: () => navigateItineraryAdd(context),
        onLearn: showDataWarning,
      );
    }
    return ItineraryGroupItem(
      groups: itineraries,
      onTap: (id) => navigateItineraryEdit(id),
      locations: locations,
      paths: paths,
    );
  }

  Widget bookingPage(List<BookingModel> bookings) {
    String typeFilter = bookingTypeController.text.trim();
    String itemFilter = bookingTypeItemController.text.trim();
    bool isFiltered = typeFilter.isNotEmpty || itemFilter.isNotEmpty;

    List<BookingModel> filteredBookings = bookings.where((booking) {
      final matchType = typeFilter.isEmpty || booking.bookingType.toLowerCase() == typeFilter.toLowerCase();
      bool matchItem = false;
      switch (booking.bookingType.toLowerCase()) {
        case 'transportation':
          matchItem = itemFilter.isEmpty || (booking.detail as TransportationDetailModel)
              .transportType
              .toLowerCase()
              .contains(itemFilter.toLowerCase());
          break;
        case 'activity':
          matchItem = itemFilter.isEmpty || (booking.detail as ActivityDetailModel)
              .activityType
              .toLowerCase()
              .contains(itemFilter.toLowerCase());
          break;
        case 'accommodation':
          matchItem = itemFilter.isEmpty || (booking.detail as AccommodationDetailModel)
              .accommodationType
              .toLowerCase()
              .contains(itemFilter.toLowerCase());
          break;
      }
      return matchType && matchItem;
    }).toList();

    final currentFilterText = typeFilter.isNotEmpty || itemFilter.isNotEmpty
        ? '${typeFilter.isNotEmpty ? typeFilter : 'All'} - ${itemFilter.isNotEmpty ? itemFilter : 'All'}'
        : 'All Booking - All Type';

    if (filteredBookings.isEmpty) {
      // ❌ No booking, show filterItem + empty state in a Column
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            child: filterItem(currentFilterText, filterBooking, () {
              bookingTypeController.clear();
              bookingTypeItemController.clear();
              setState(() {});
            }, isFiltered),
          ),
          Expanded(
            child: EmptyState(
              title: "No Records",
              subtitle: "No booking found with the current filter.",
              tapText: "Add Booking +",
              onTap: () => navigateBookingAdd(context),
              onLearn: showDataWarning,
            ),
          ),
        ],
      );
    } else {
      // ✅ Has data, inject filterItem as the first item in ListView
      return ListView.builder(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
        itemCount: filteredBookings.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return filterItem(currentFilterText, filterBooking, () {
              bookingTypeController.clear();
              bookingTypeItemController.clear();
              setState(() {});
            }, isFiltered);
          }
          final booking = filteredBookings[index - 1];
          return BookingItem(
            item: booking,
            onTap: (id) => navigateBookingDetail(id),
          );
        },
      );
    }
  }

  Widget locationPage(List<LocationModel> locations) {
    String filter = locationController.text.trim();
    bool isFiltered = filter.isNotEmpty;

    List<LocationModel> filteredLocations = locations.where((location) {
      return filter.isEmpty ||
          location.type.toLowerCase().contains(filter.toLowerCase());
    }).toList();

    final currentFilterText = isFiltered ? filter : 'All Locations';

    final usedTypeIds = locations.map((l) => l.type).toSet();

    final usedLocationTypes = locationTypes
        .where((type) => usedTypeIds.contains(type.name))
        .toList();

    if (filteredLocations.isEmpty) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            child: filterItem(
              currentFilterText,
              () => filterLocation(usedLocationTypes),
              () {
                locationController.clear();
                setState(() { });
              },
              isFiltered,
            ),
          ),
          Expanded(
            child: EmptyState(
              title: "No Records",
              subtitle: "No location found with the current filter.",
              tapText: "Add Location +",
              onTap: () => navigateLocationAdd(context),
              onLearn: showDataWarning,
            ),
          ),
        ],
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: filteredLocations.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return filterItem(
            currentFilterText,
            () => filterLocation(usedLocationTypes),
            () {
              locationController.clear();
              setState(() { });
            },
            isFiltered,
          );
        }

        final location = filteredLocations[index - 1];
        return LocationItem(
          item: location,
          onTap: (id) => navigateLocationDetail(id),
        );
      },
    );
  }

  Widget pathPage(List<PathModel> paths, List<LocationModel> locations) {
    String filter = locationListController.text.trim();
    bool isFiltered = filter.isNotEmpty;
    String filterName = '';

    List<PathModel> filteredPaths = paths.where((path) {
      final fromLocation = locations.firstWhere((l) => l.id == path.fromLocationId);
      final toLocation = locations.firstWhere((l) => l.id == path.toLocationId);
      return filter.isEmpty ||
          fromLocation.id.toLowerCase().contains(filter.toLowerCase()) ||
          toLocation.id.toLowerCase().contains(filter.toLowerCase());
    }).toList();

    if(filter != '')  {
      filterName = locations.firstWhere((l) => l.id == filter).name;
    } else {
      filterName = 'All Locations';
    }

    final currentFilterText = isFiltered ? filterName : 'All Locations';

    if (filteredPaths.isEmpty) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            child: filterItem(
              currentFilterText,
              () => filterPath(locations),
              () {
                locationListController.clear();
                setState(() {});
              },
              isFiltered,
            ),
          ),
          Expanded(
            child: EmptyState(
              title: "No Records",
              subtitle: "No path found with the current filter.",
              tapText: "Add Path +",
              onTap: () => navigatePathAdd(context),
              onLearn: showDataWarning,
            ),
          ),
        ],
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: filteredPaths.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return filterItem(
            currentFilterText,
            () => filterPath(locations),
            () {
              locationListController.clear();
              setState(() {});
            },
            isFiltered,
          );
        }

        final path = filteredPaths[index - 1];
        return PathItem(
          item: path,
          onTap: (id) => navigatePathEdit(id),
          locations: locations,
        );
      },
    );
  }

  Widget descriptionPage(TripModel? trip) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        DescriptionItem(title: 'Title', child: Text(
            trip?.title ?? '',
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            )
        )),
        DescriptionItem(title: 'Start Date & End Date', child: Text(
            '${trip?.startDate} - ${trip?.endDate}',
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            )
        )),
        DescriptionItem(title: 'Description', child: Text(
            trip?.description ?? '',
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            )
        )),
        DescriptionItem(title: 'Image', separator: false, child: Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(16.0),
          ),
          alignment: Alignment.center,
          child: trip?.photoBytes != null
              ? ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.memory(
              trip!.photoBytes!,
              width: double.infinity,
              fit: BoxFit.cover,
              height: 200,
            ),
          ) : Container(),
        ),
          onTap: () {
            Navigator.pushNamed(
              context,
              RoutesValues.viewImage,
              arguments: trip?.photoBytes,
            );
          },
        )
      ],
    );
  }

  Widget notesPage(List<NoteModel> notes) {
    if (notes.isEmpty) {
      return EmptyState(
        title: "No Records",
        subtitle: "You haven’t added any note. Once you do, they’ll appear here.",
        tapText: "Add Note +",
        onTap: () => navigateNoteAdd(context),
        onLearn: showDataWarning,
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return NoteItem(
          item: note,
          onTap: (id) => navigateNoteEdit(id),
        );
      },
    );
  }

  // endregion

  Widget filterItem(
      String text,
      VoidCallback onTap,
      VoidCallback onClear,
      bool isFiltered,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(top: 8, bottom: 20, left: 8, right: 8),
        child: Row(
          children: [
            const Icon(Icons.circle, size: 16),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (isFiltered)
              GestureDetector(
                onTap: () {
                  onClear();
                },
                child: const Icon(Icons.clear_rounded),
              )
            else
              const Icon(Icons.filter_list_rounded),
          ],
        ),
      ),
    );
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

  Widget buildTab(String label, int index, {Key? key}) {
    final isSelected = selectedTabIndex == index;
    return Container(
      key: key,
      child: GestureDetector(
        onTap: () => changeTab(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          margin: EdgeInsets.only(right: index != 5 ? 12 : 0),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).iconTheme.color
                : Theme.of(context).hoverColor,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? Theme.of(context).colorScheme.surface
                  : Theme.of(context).iconTheme.color,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget tripDetailLoaded(BuildContext context, TripDetailLoaded state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        title: const Text('Trip Detail'),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(
                selectedTabIndex != 4
                    ? Icons.add_circle_outline_sharp
                    : Icons.edit_note_outlined,
              ),
              tooltip: selectedTabIndex != 4 ? 'Add' : 'Edit',
              onPressed: () => navigateAction(context),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              top: 16.0,
              bottom: 16.0,
              left: 16,
              right: 16,
            ),
            controller: _tabScrollController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                buildTab("Itinerary", 0, key: _tabKeys[0]),
                buildTab("Booking", 1, key: _tabKeys[1]),
                buildTab("Location", 2, key: _tabKeys[2]),
                buildTab("Path", 3, key: _tabKeys[3]),
                buildTab("Description", 4, key: _tabKeys[4]),
                buildTab("Notes", 5, key: _tabKeys[5]),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => selectedTabIndex = index);
                scrollToSelectedTab();
              },
              children: [
                itineraryPage(state.itineraries, state.locations, state.paths),
                bookingPage(state.bookings),
                locationPage(state.locations),
                pathPage(state.paths, state.locations),
                descriptionPage(state.trip),
                notesPage(state.notes),
              ],
            ),
          ),
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
        }
        else if (state is TripLoading) {
          return Scaffold(appBar: AppBar(), body: const LoadingState());
        }
        else if (state is TripDetailLoaded) {
          return tripDetailLoaded(context, state);
        }
        return const SizedBox.shrink();
      },
    );
  }

}
