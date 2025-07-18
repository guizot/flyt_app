import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/local/traveler_model.dart';
import '../../../injector.dart';
import '../../core/constant/routes_values.dart';
import '../../core/handler/dialog_handler.dart';
import '../../core/widget/loading_state.dart';
import 'cubit/traveler_cubit.dart';
import 'cubit/traveler_state.dart';

class TravelerDetailPageProvider extends StatelessWidget {
  const TravelerDetailPageProvider({super.key, this.id});
  final String? id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TravelerCubit>(),
      child: TravelerDetailPage(id: id),
    );
  }
}

class TravelerDetailPage extends StatefulWidget {
  const TravelerDetailPage({super.key, this.id});
  final String? id;
  @override
  State<TravelerDetailPage> createState() => _TravelerDetailPageState();
}

class _TravelerDetailPageState extends State<TravelerDetailPage>
    with SingleTickerProviderStateMixin {
  int selectedTabIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedTabIndex);
    refreshData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void refreshData() {
    context.read<TravelerCubit>().getAllDetail(widget.id!);
  }

  void changeTab(int index) {
    // setState(() => selectedTabIndex = index);
    _pageController.jumpToPage(index);
  }

  void navigateTravelerEdit(BuildContext context) {
    Navigator.pushNamed(
      context,
      RoutesValues.travelerAdd,
      arguments: widget.id!,
    ).then((value) {
      refreshData();
      if (value == 'delete' && context.mounted) {
        Navigator.pop(context);
      }
    });
  }

  void navigateDocumentAdd() {
    // Navigator.pushNamed(
    //   context,
    //   RoutesValues.documentAdd,
    //   arguments: DocumentAddArgs(travelerId: widget.id!),
    // ).then((value) {
    //   refreshData();
    // });
  }

  void navigateDocumentEdit(String id) {
    // Navigator.pushNamed(
    //   context,
    //   RoutesValues.documentAdd,
    //   arguments: DocumentAddArgs(id: id, travelerId: widget.id!),
    // ).then((value) {
    //   refreshData();
    // });
  }

  void navigateAction(BuildContext context) {
    if (selectedTabIndex == 0) {
      navigateTravelerEdit(context);
    } else if (selectedTabIndex == 1) {
      navigateDocumentAdd();
    }
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

  Widget _buildTab(String label, int index) {
    final isSelected = selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => changeTab(index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12), // dynamic width
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).iconTheme.color
                : Theme.of(context).hoverColor,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
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

  Widget _buildTabContent(int index, Traveler? traveler) {
    switch (index) {
      case 0:
        return traveler != null
            ? ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8,
                ),
                children: [],
              )
            : Container();
      // case 1:
      //   return documents.isNotEmpty ? ListView.builder(
      //     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      //     itemCount: documents.length,
      //     itemBuilder: (context, index) {
      //       return DocumentItem(
      //         item: documents[index],
      //         onTap: navigateDocumentEdit,
      //       );
      //     },
      //   )
      //       : Padding(
      //       padding: const EdgeInsets.only(bottom: 60),
      //       child: EmptyState(
      //           title: "No Records",
      //           subtitle: "You haven’t added any Document. Once you do, they’ll appear here.",
      //           tapText: "Add Document +",
      //           onTap: navigateDocumentAdd,
      //           onLearn: showDataWarning
      //       )
      //   );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget travelerDetailLoaded(
    BuildContext context,
    TravelerDetailLoaded state,
  ) {
    Traveler? traveler = state.traveler;
    // List<DocumentModel> documents = state.documents;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        title: const Text('Traveler Detail'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: selectedTabIndex == 0
                ? const Icon(Icons.edit_note_outlined)
                : const Icon(Icons.add_circle_outline_sharp),
            tooltip: selectedTabIndex == 0 ? 'Edit' : 'Add',
            onPressed: () => navigateAction(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 8.0,
              top: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTab("Detail", 0),
                const SizedBox(width: 12.0),
                _buildTab("Documents", 1),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => selectedTabIndex = index);
              },
              children: [
                _buildTabContent(0, traveler),
                _buildTabContent(1, traveler),
                _buildTabContent(2, traveler),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TravelerCubit, TravelerCubitState>(
      builder: (context, state) {
        if (state is TravelerInitial) {
          return const SizedBox.shrink();
        } else if (state is TravelerLoading) {
          return Scaffold(appBar: AppBar(), body: const LoadingState());
        } else if (state is TravelerDetailLoaded) {
          return travelerDetailLoaded(context, state);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
