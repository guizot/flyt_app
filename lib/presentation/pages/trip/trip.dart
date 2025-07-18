import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  @override
  void initState() {
    super.initState();
    context.read<TripCubit>().getAllTrip();
  }

  void refreshData() {
    context.read<TripCubit>().getAllTrip();
    setState(() {});
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
    Navigator.pushNamed(context, RoutesValues.tripAdd, arguments: id).then((value) => refreshData());
  }

  void navigateTripDetail(String id) {
    // Navigator.pushNamed(context, RoutesValues.tripDetail, arguments: id).then((value) => refreshData());
  }

  Widget tripLoaded(List<TripModel> travelers) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: travelers.length,
      itemBuilder: (context, index) {
        final item = travelers[index];
        return TripItem(
          item: item,
          onTap: navigateTripEdit,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripCubit, TripCubitState>(
      builder: (context, state) {
        if (state is TripInitial) {
          return const SizedBox.shrink();
        } else if (state is TripLoading) {
          return const LoadingState();
        } else if (state is TripEmpty) {
          return EmptyState(
            title: "No Records",
            subtitle: "You haven’t added any trip. Once you do, they’ll appear here.",
            tapText: "Add Trip +",
            onTap: navigateTripAdd,
            onLearn: showDataWarning,
          );
        } else if (state is TripLoaded) {
          return tripLoaded(state.trips);
        }
        return const SizedBox.shrink();
      },
    );
  }
}