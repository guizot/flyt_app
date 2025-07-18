import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/local/traveler_model.dart';
import '../../../injector.dart';
import '../../core/constant/routes_values.dart';
import '../../core/handler/dialog_handler.dart';
import '../../core/widget/loading_state.dart';
import 'cubit/traveler_cubit.dart';
import 'cubit/traveler_state.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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

class _TravelerDetailPageState extends State<TravelerDetailPage> with SingleTickerProviderStateMixin {

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


  Widget buildTab(String label, int index) {
    final isSelected = selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => changeTab(index),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ), // dynamic width
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

  Widget buildTabContent(int index, Traveler? traveler) {
    switch (index) {
      case 0:
        return traveler != null
            ? MasonryGridView.count(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  bottom: 16.0,
                  right: 16,
                  left: 16,
                ),
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                shrinkWrap: false,
                itemCount: travelerItems(traveler).length,
                itemBuilder: (context, index) {
                  final item = travelerItems(traveler)[index];
                  if (item['type'] == 'image') {
                    return Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).hoverColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: MemoryImage(item['imageBytes']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            item['title'] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  else {
                    return Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).hoverColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            item['icon'] as IconData,
                            size: 32,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            item['title'] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item['description'] as String,
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).textTheme.bodySmall?.color,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
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

  int? calculateAge(String birthdate) {
    try {
      final parts = birthdate.split(' ');
      if (parts.length == 3) {
        final day = int.parse(parts[0]);
        final monthMap = {
          'jan': 1,
          'feb': 2,
          'mar': 3,
          'apr': 4,
          'may': 5,
          'jun': 6,
          'jul': 7,
          'aug': 8,
          'sep': 9,
          'oct': 10,
          'nov': 11,
          'dec': 12,
        };
        final month = monthMap[parts[1].toLowerCase()] ?? 1;
        final year = int.parse(parts[2]);
        final birth = DateTime(year, month, day);
        final now = DateTime.now();
        int age = now.year - birth.year;
        if (now.month < birth.month ||
            (now.month == birth.month && now.day < birth.day)) {
          age--;
        }
        return age;
      }
    } catch (_) {}
    return null;
  }

  List<Map<String, dynamic>> travelerItems(Traveler traveler) {
    final items = <Map<String, dynamic>>[];

    items.add({'icon': Icons.person, 'title': 'Name', 'description': traveler.name});

    if (traveler.imageBytes != null) {
      items.add({
        'type': 'image',
        'imageBytes': traveler.imageBytes,
        'title': 'Photo',
        'icon': Icons.image,
      });
    }

    items.add({
      'icon': Icons.calendar_today,
      'title': 'Age',
      'description': '${calculateAge(traveler.birthdate)} years',
    });

    items.addAll([
      {
        'icon': Icons.cake,
        'title': 'Birthdate',
        'description': traveler.birthdate,
      },
      {'icon': Icons.wc, 'title': 'Gender', 'description': traveler.gender},
      {
        'icon': Icons.bloodtype,
        'title': 'Blood Type',
        'description': 'Type ${traveler.bloodType}',
      },
      {
        'icon': Icons.favorite,
        'title': 'Marital Status',
        'description': traveler.maritalStatus,
      },
      {
        'icon': Icons.flag,
        'title': 'Nationality',
        'description': traveler.nationality,
      },
      {'icon': Icons.phone, 'title': 'Phone', 'description': traveler.phone},
      {'icon': Icons.email, 'title': 'Email', 'description': traveler.email},
    ]);
    return items;
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
                buildTab("Detail", 0),
                const SizedBox(width: 12.0),
                buildTab("Documents", 1),
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
                buildTabContent(0, traveler),
                buildTabContent(1, traveler),
                buildTabContent(2, traveler),
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
