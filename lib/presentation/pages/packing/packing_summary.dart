import 'package:flutter/material.dart';
import '../../core/widget/common_separator.dart';

class PackingSummary extends StatefulWidget {
  const PackingSummary({super.key, this.summary});
  final Map<String, dynamic>? summary;

  @override
  State<PackingSummary> createState() => _PackingSummaryState();
}

class _PackingSummaryState extends State<PackingSummary> {

  @override
  Widget build(BuildContext context) {
    return widget.summary != null ? Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
                Radius.circular(24.0)
            ),
            color: Theme.of(context).hoverColor,
          ),
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
          child: Column(
            children: [
              const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image.asset(
                  //   IconValues.whiteCircle,
                  //   height: 18,
                  //   width: 18,
                  // ),
                  Icon(
                    Icons.groups_rounded,
                    size: 18,
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      "Packing Summary",
                      style: TextStyle(
                        fontWeight: FontWeight.w600
                      ),
                    )
                  ),
                  SizedBox(width: 8.0),
                ],
              ),

              const CommonSeparator(
                color: Colors.grey,
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image.asset(
                  //   IconValues.envelope,
                  //   height: 15,
                  //   width: 15,
                  // ),
                  const Icon(
                    Icons.mail,
                    size: 18,
                  ),
                  const SizedBox(width: 8.0),
                  const Expanded(
                    child: Text(
                        "Packing"
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(widget.summary?['mails'])
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image.asset(
                  //   IconValues.familyManWomanBoy,
                  //   height: 15,
                  //   width: 15,
                  // ),
                  const Icon(
                    Icons.people_alt_rounded,
                    size: 18,
                  ),
                  const SizedBox(width: 8.0),
                  const Expanded(
                    child: Text(
                      "Total"
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(widget.summary?['peoples'])
                ],
              ),

              const CommonSeparator(
                color: Colors.grey,
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image.asset(
                  //   IconValues.largeGreenCircle,
                  //   height: 15,
                  //   width: 15,
                  // ),
                  const Icon(
                    Icons.contact_page,
                    size: 18,
                  ),
                  const SizedBox(width: 8.0),
                  const Expanded(
                    child: Text(
                        "Confirmed"
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(widget.summary?['confirmed'])
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image.asset(
                  //   IconValues.whiteCircle,
                  //   height: 15,
                  //   width: 15,
                  // ),
                  const Icon(
                    Icons.contact_page_outlined,
                    size: 18,
                  ),
                  const SizedBox(width: 8.0),
                  const Expanded(
                    child: Text(
                        "Unconfirmed"
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(widget.summary?['unconfirmed'])
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16.0,
        )
      ],
    ) : Container();
  }

}