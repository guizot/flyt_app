import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../core/constant/routes_values.dart';
import 'traveler/traveler.dart';
import 'phrases/phrases.dart';
import 'trip/trip.dart';
import 'packing/packing.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<TripPageState> tripPageKey = GlobalKey<TripPageState>();
  final GlobalKey<TravelerPageState> travelerPageKey = GlobalKey<TravelerPageState>();
  final GlobalKey<PackingPageState> packingPageKey = GlobalKey<PackingPageState>();
  final GlobalKey<PhrasesPageState> phrasesPageKey = GlobalKey<PhrasesPageState>();

  int currentPageIndex = 0;
  String titlePage = "Trip";
  // String? imageBytes = 'https://vetmarlborough.co.nz/wp-content/uploads/cat-facts.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(titlePage),
          backgroundColor: Theme.of(context).colorScheme.surface,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          // leading: Container(
          //   margin: const EdgeInsets.only(left: 21.0),
          //   child: GestureDetector(
          //     onTap: () {
          //       // Aksi saat ditekan
          //     },
          //     child: Container(
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: Theme.of(context).hoverColor,
          //         border: Border.all(
          //           color: Theme.of(context).colorScheme.shadow,
          //         ),
          //       ),
          //       child: Center(
          //         child: (imageBytes != null && imageBytes!.isNotEmpty)
          //             ? ClipOval(
          //           child: Image.network(
          //             imageBytes!,
          //             width: 34,
          //             height: 34,
          //             fit: BoxFit.cover,
          //           ),
          //         )
          //             : const Icon(Icons.person, size: 18),
          //       ),
          //     ),
          //   ),
          // ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: const Icon(Icons.add_circle_outline_sharp),
                tooltip: 'Add',
                onPressed: () {
                  if(currentPageIndex == 0) {
                    Navigator.pushNamed(context, RoutesValues.tripAdd).then((_) {
                      tripPageKey.currentState?.refreshData();
                    });
                  }
                  else if(currentPageIndex == 1) {
                    Navigator.pushNamed(context, RoutesValues.travelerAdd).then((_) {
                      travelerPageKey.currentState?.refreshData();
                    });
                  }
                  else if(currentPageIndex == 2) {
                    Navigator.pushNamed(context, RoutesValues.packingAdd).then((_) {
                      packingPageKey.currentState?.refreshData();
                    });
                  }
                  else if(currentPageIndex == 3) {
                    Navigator.pushNamed(context, RoutesValues.languageAdd).then((_) {
                      phrasesPageKey.currentState?.refreshData();
                    });
                  }
                },
              ),
            )
          ],
        ),
        bottomNavigationBar: Stack(
          children: [
            NavigationBar(
              backgroundColor: Theme.of(context).colorScheme.surface,
              indicatorColor: Theme.of(context).colorScheme.shadow,
              onDestinationSelected: (int index) {
                setState(() {
                  currentPageIndex = index;
                  if(index == 0) {
                    titlePage = "Trip";
                  }
                  else if(index == 1) {
                    titlePage = "Traveler";
                  }
                  else if(index == 2) {
                    titlePage = "Packing";
                  }
                  else if(index == 3) {
                    titlePage = "Phrases";
                  }
                });
              },
              elevation: 8.0,
              selectedIndex: currentPageIndex,
              destinations: <Widget>[
                NavigationDestination(
                  selectedIcon: SvgPicture.asset(
                  'assets/svg/trip.svg',
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).iconTheme.color ?? Colors.grey,
                        BlendMode.srcIn
                    ),
                  ),
                  icon: SvgPicture.asset(
                  'assets/svg/trip.svg',
                    width: 20,
                    height: 20,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).iconTheme.color ?? Colors.grey,
                        BlendMode.srcIn
                    ),
                  ),
                  label: 'Trip',
                ),
                NavigationDestination(
                  selectedIcon: SvgPicture.asset(
                      'assets/svg/traveler.svg',
                      width: 20,
                      height: 20,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).iconTheme.color ?? Colors.grey,
                        BlendMode.srcIn
                    ),
                  ),
                  icon: SvgPicture.asset(
                      'assets/svg/traveler.svg',
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).iconTheme.color ?? Colors.grey,
                          BlendMode.srcIn
                      ),
                  ),
                  label: 'Traveler',
                ),
                NavigationDestination(
                  selectedIcon: SvgPicture.asset(
                      'assets/svg/packing.svg',
                      width: 20,
                      height: 20,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).iconTheme.color ?? Colors.grey,
                        BlendMode.srcIn
                    ),
                  ),
                  icon: SvgPicture.asset(
                      'assets/svg/packing.svg',
                      width: 20,
                      height: 20,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).iconTheme.color ?? Colors.grey,
                        BlendMode.srcIn
                    ),
                  ),
                  label: 'Packing',
                ),
                NavigationDestination(
                  selectedIcon: SvgPicture.asset(
                      'assets/svg/phrases.svg',
                      width: 20,
                      height: 20,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).iconTheme.color ?? Colors.grey,
                        BlendMode.srcIn
                    ),
                  ),
                  icon: SvgPicture.asset(
                      'assets/svg/phrases.svg',
                      width: 20,
                      height: 20,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).iconTheme.color ?? Colors.grey,
                        BlendMode.srcIn
                    ),
                  ),
                  label: 'Phrases',
                ),
              ],
            )
          ],
        ),
        body: Container(
          color: Theme.of(context).colorScheme.surface,
          child: Builder(
            builder: (_) {
              if (currentPageIndex == 0) return TripPageProvider(pageKey: tripPageKey);
              if (currentPageIndex == 1) return TravelerPageProvider(pageKey: travelerPageKey);
              if (currentPageIndex == 2) return PackingPageProvider(pageKey: packingPageKey);
              if (currentPageIndex == 3) return PhrasesPageProvider(pageKey: phrasesPageKey);
              return const SizedBox.shrink();
            },
          ),
        )
    );
  }

}