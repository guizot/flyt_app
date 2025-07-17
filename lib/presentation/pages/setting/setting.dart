import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constant/theme_service_values.dart';
import '../../core/service/theme_service.dart';
import '../../core/widget/common_item.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Consumer<ThemeService> (
          builder: (context, ThemeService themeService, child) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                CommonItem(
                    title: "Theme Mode",
                    icon: Icons.dark_mode_rounded,
                    child: Wrap(
                        spacing: 10,
                        runSpacing: 0,
                        children: List.generate(ThemeServiceValues.themeString.length, (index) {
                          return FilterChip(
                            label: Text(ThemeServiceValues.themeString[index]),
                            backgroundColor: Theme.of(context).highlightColor,
                            selectedColor: Theme.of(context).colorScheme.inversePrimary,
                            onSelected: (bool value) {
                              themeService.themeMode = ThemeServiceValues.themeString[index];
                            },
                            selected: themeService.themeMode == ThemeServiceValues.themeString[index] ? true : false,
                            side: const BorderSide(
                                style: BorderStyle.none
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)
                            ),
                          );
                        }
                        )
                    )
                ),
                // CommonItem(
                //     title: "Theme Color",
                //     icon: Icons.color_lens_rounded,
                //     child: Wrap(
                //         spacing: 10,
                //         runSpacing: 0,
                //         children: List.generate(ThemeServiceValues.colorValue.length, (index) {
                //             return GestureDetector(
                //               onTap: () {
                //                themeService.colorSeed = ThemeServiceValues.colorString[index];
                //               },
                //               child: Container(
                //                   height: 50,
                //                   width: 50,
                //                   decoration: BoxDecoration(
                //                     border: Border.all(color: Colors.black.withOpacity(0.2)),
                //                     shape: BoxShape.circle,
                //                     color: ThemeServiceValues.colorValueList[index],
                //                   ),
                //                   child: themeService.colorSeed == ThemeServiceValues.colorString[index]
                //                       ? const Icon(
                //                           Icons.check,
                //                           color: Colors.black,
                //                         )
                //                       : null
                //               )
                //             );
                //           }
                //         )
                //     )
                // ),
              ],
            );
          }
      ),
    );
  }

}