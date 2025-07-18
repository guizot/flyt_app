import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flyt_app/presentation/pages/trip/trip_display_item.dart';
import 'package:flyt_app/presentation/pages/trip/trip_item.dart';
import '../../../data/models/local/trip_model.dart';
import '../../../injector.dart';
import '../../core/constant/routes_values.dart';
import '../../core/handler/dialog_handler.dart';
import '../../core/widget/empty_state.dart';
import '../../core/widget/loading_state.dart';
import 'cubit/trip_cubit.dart';
import 'cubit/trip_state.dart';

class TripPageProvider extends StatelessWidget {
  const TripPageProvider({super.key, this.pageKey});
  final Key? pageKey;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TripCubit>(),
      child: TripPage(key: pageKey),
    );
  }
}

class TripPage extends StatefulWidget {
  const TripPage({super.key});
  @override
  State<TripPage> createState() => TripPageState();
}

class TripPageState extends State<TripPage> {

  String? searchQuery;
  late FocusNode searchFocusNode;

  @override
  void initState() {
    super.initState();
    searchFocusNode = FocusNode();
    refreshData();
  }

  @override
  void dispose() {
    super.dispose();
    searchFocusNode.dispose();
  }

  void refreshData() {
    if (searchQuery?.isNotEmpty == true) {
      context.read<TripCubit>().searchTrip(searchQuery!);
    } else {
      context.read<TripCubit>().getGroupedTrip();
    }
  }

  void showDataWarning() {
    DialogHandler.showConfirmDialog(
        context: context,
        title: "Data Protection",
        description: "All data is stored locally on your device. Uninstalling or clearing the app will permanently delete it. Be sure to back up anything important.",
        confirmText: "I Understand",
        onConfirm: () => Navigator.pop(context),
        isCancelable: false
    );
  }

  void navigateTripAdd() {
    Navigator.pushNamed(context, RoutesValues.tripAdd).then((value) => refreshData());
  }

  void navigateTripEdit(String id) {
    // Navigator.pushNamed(context, RoutesValues.tripAdd, arguments: id).then((value) => refreshData());
  }

  void navigateTripDetail(String id) {
    Navigator.pushNamed(context, RoutesValues.tripDetail, arguments: id).then((value) => refreshData());
  }

  Widget tripGroupedLoaded(List<TripDisplayItem> items) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        if (item is TripHeaderItem) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Row(
              children: [
                Text(item.icon, style: const TextStyle(fontSize: 20)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    item.title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        } else if (item is TripContentItem) {
          return TripItem(
            item: item.trip,
            onTap: navigateTripDetail,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget tripSearchLoaded(List<TripModel> travelers) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: travelers.length,
      itemBuilder: (context, index) {
        final item = travelers[index];
        return TripItem(
          item: item,
          onTap: navigateTripDetail,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: 16,
          ),
          padding: const EdgeInsets.only(left: 8, right: 20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            color: Theme.of(context).hoverColor,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  focusNode: searchFocusNode,
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    hintText: 'Search trips..',
                    hintStyle: TextStyle(
                      color: Theme.of(context).iconTheme.color?.withAlpha(70),
                      fontWeight: FontWeight.normal,
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  onChanged: (query) {
                    searchQuery = query;
                    if (query.isEmpty) {
                      context.read<TripCubit>().getGroupedTrip();
                    } else {
                      context.read<TripCubit>().searchTrip(query);
                    }
                  },
                ),
              ),
              const Icon(Icons.search_rounded, size: 26, weight: 10),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<TripCubit, TripCubitState>(
            builder: (context, state) {
              if (state is TripInitial) {
                return const SizedBox.shrink();
              }
              else if (state is TripLoading) {
                return const LoadingState();
              }
              else if (state is TripEmpty) {
                return EmptyState(
                  title: "No Records",
                  subtitle: "You haven’t added any trip. Once you do, they’ll appear here.",
                  tapText: "Add Trip +",
                  onTap: navigateTripAdd,
                  onLearn: showDataWarning,
                );
              }
              else if (state is TripGroupedLoaded) {
                return tripGroupedLoaded(state.items);
              }
              else if (state is TripSearchLoaded) {
                return tripSearchLoaded(state.trips);
              }
              return const SizedBox.shrink();
            },
          )
        ),
      ],
    );
  }
}