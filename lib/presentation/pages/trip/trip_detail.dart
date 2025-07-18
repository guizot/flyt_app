import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../injector.dart';
import '../../core/constant/routes_values.dart';
import '../../core/handler/dialog_handler.dart';
import '../../core/model/arguments/document_add_args.dart';
import '../../core/widget/loading_state.dart';
import 'cubit/trip_cubit.dart';
import 'cubit/trip_state.dart';

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

  void navigateAction(BuildContext context) {
    if (selectedTabIndex == 0) {
    } else if (selectedTabIndex == 1) {
    } else if (selectedTabIndex == 2) {
    } else if (selectedTabIndex == 3) {
    } else if (selectedTabIndex == 4) {
      navigateTripEdit(context);
    } else if (selectedTabIndex == 5) {}
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

  void navigateNoteAdd() {
    Navigator.pushNamed(
      context,
      RoutesValues.documentAdd,
      arguments: DocumentAddArgs(travelerId: widget.id!),
    ).then((value) {
      refreshData();
    });
  }

  void navigateNoteEdit(String id) {
    Navigator.pushNamed(
      context,
      RoutesValues.documentAdd,
      arguments: DocumentAddArgs(id: id, travelerId: widget.id!),
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

  Widget travelerDetailLoaded(BuildContext context, TripDetailLoaded state) {
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
              bottom: 8.0,
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
                itineraryPage(),
                bookingPage(),
                locationPage(),
                pathPage(),
                descriptionPage(),
                notesPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget itineraryPage() {
    return const Center(child: Text("Itinerary"));
  }

  Widget bookingPage() {
    return const Center(child: Text("Booking"));
  }

  Widget locationPage() {
    return const Center(child: Text("Location"));
  }

  Widget pathPage() {
    return const Center(child: Text("Path"));
  }

  Widget descriptionPage() {
    return const Center(child: Text("Description"));
  }

  Widget notesPage() {
    return const Center(child: Text("Notes"));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripCubit, TripCubitState>(
      builder: (context, state) {
        if (state is TripInitial) {
          return const SizedBox.shrink();
        } else if (state is TripLoading) {
          return Scaffold(appBar: AppBar(), body: const LoadingState());
        } else if (state is TripDetailLoaded) {
          return travelerDetailLoaded(context, state);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
