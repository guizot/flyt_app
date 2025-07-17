import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/local/packing_model.dart';
import '../../../injector.dart';
import '../../core/constant/routes_values.dart';
import '../../core/handler/dialog_handler.dart';
import '../../core/widget/empty_state.dart';
import '../../core/widget/loading_state.dart';
import 'cubit/packing_cubit.dart';
import 'cubit/packing_state.dart';
import 'packing_item.dart';

class PackingPageProvider extends StatelessWidget {
  const PackingPageProvider({super.key, this.pageKey});
  final Key? pageKey;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PackingCubit>(),
      child: PackingPage(key: pageKey),
    );
  }
}

class PackingPage extends StatefulWidget {
  const PackingPage({super.key});
  @override
  State<PackingPage> createState() => PackingPageState();
}

class PackingPageState extends State<PackingPage> {

  @override
  void initState() {
    super.initState();
    context.read<PackingCubit>().getAllPacking();
  }

  void refreshData() {
    context.read<PackingCubit>().getAllPacking();
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

  void navigatePackingAdd() {
    Navigator.pushNamed(context, RoutesValues.packingAdd).then((value) => refreshData());
  }

  void navigatePackingEdit(String id) {
    Navigator.pushNamed(context, RoutesValues.packingAdd, arguments: id).then((value) => refreshData());
  }

  Widget packingLoaded(List<Packing> packings) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: packings.length,
      itemBuilder: (context, index) {
        final item = packings[index];
        return PackingItem(
          item: item,
          onTap: navigatePackingEdit,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackingCubit, PackingCubitState>(
      builder: (context, state) {
        if (state is PackingInitial) {
          return const SizedBox.shrink();
        } else if (state is PackingLoading) {
          return const LoadingState();
        } else if (state is PackingEmpty) {
          return EmptyState(
            title: "No Records",
            subtitle: "You haven’t added any packing. Once you do, they’ll appear here.",
            tapText: "Add Packing +",
            onTap: navigatePackingAdd,
            onLearn: showDataWarning,
          );
        } else if (state is PackingLoaded) {
          return packingLoaded(state.packings);
        }
        return const SizedBox.shrink();
      },
    );
  }

}