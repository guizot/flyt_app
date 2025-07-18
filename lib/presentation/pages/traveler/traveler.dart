import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/local/traveler_model.dart';
import '../../../injector.dart';
import '../../core/constant/routes_values.dart';
import '../../core/handler/dialog_handler.dart';
import '../../core/widget/empty_state.dart';
import '../../core/widget/loading_state.dart';
import 'cubit/traveler_cubit.dart';
import 'cubit/traveler_state.dart';
import 'traveler_item.dart';

class TravelerPageProvider extends StatelessWidget {
  const TravelerPageProvider({super.key, this.pageKey});
  final Key? pageKey;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TravelerCubit>(),
      child: TravelerPage(key: pageKey),
    );
  }
}

class TravelerPage extends StatefulWidget {
  const TravelerPage({super.key});
  @override
  State<TravelerPage> createState() => TravelerPageState();
}

class TravelerPageState extends State<TravelerPage> {
  @override
  void initState() {
    super.initState();
    context.read<TravelerCubit>().getAllTraveler();
  }

  void refreshData() {
    context.read<TravelerCubit>().getAllTraveler();
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

  void navigateTravelerAdd() {
    Navigator.pushNamed(context, RoutesValues.travelerAdd).then((value) => refreshData());
  }

  void navigateTravelerDetail(String id) {
    Navigator.pushNamed(context, RoutesValues.travelerDetail, arguments: id).then((value) => refreshData());
  }

  Widget travelerLoaded(List<Traveler> travelers) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: travelers.length,
      itemBuilder: (context, index) {
        final item = travelers[index];
        return TravelerItem(
          item: item,
          onTap: navigateTravelerDetail,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TravelerCubit, TravelerCubitState>(
      builder: (context, state) {
        if (state is TravelerInitial) {
          return const SizedBox.shrink();
        } else if (state is TravelerLoading) {
          return const LoadingState();
        } else if (state is TravelerEmpty) {
          return EmptyState(
            title: "No Records",
            subtitle: "You haven’t added any travelers. Once you do, they’ll appear here.",
            tapText: "Add Traveler +",
            onTap: navigateTravelerAdd,
            onLearn: showDataWarning,
          );
        } else if (state is TravelerLoaded) {
          return travelerLoaded(state.travelers);
        }
        return const SizedBox.shrink();
      },
    );
  }
} 