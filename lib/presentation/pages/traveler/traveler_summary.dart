import 'package:flutter/material.dart';
import '../../core/widget/common_separator.dart';

class TravelerSummary extends StatefulWidget {
  const TravelerSummary({super.key, this.summary});
  final Map<String, dynamic>? summary;

  @override
  State<TravelerSummary> createState() => _TravelerSummaryState();
}

class _TravelerSummaryState extends State<TravelerSummary> {
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
                  Icon(
                    Icons.home,
                    size: 18,
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      "Traveler Summary",
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
                  const Icon(
                    Icons.paid,
                    size: 18,
                  ),
                  const SizedBox(width: 8.0),
                  const Expanded(
                    child: Text(
                        "Budget"
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(widget.summary?['budget'] ?? '-')
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.paid_outlined,
                    size: 18,
                  ),
                  const SizedBox(width: 8.0),
                  const Expanded(
                    child: Text(
                      "Unused Budget"
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(widget.summary?['unusedBudget'] ?? '-')
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.warning,
                    size: 18,
                  ),
                  const SizedBox(width: 8.0),
                  const Expanded(
                    child: Text(
                      "Over Budget"
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(widget.summary?['overBudget'] ?? '-')
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.attach_money,
                    size: 18,
                  ),
                  const SizedBox(width: 8.0),
                  const Expanded(
                    child: Text(
                      "Paid"
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(widget.summary?['paid'] ?? '-')
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.money_off,
                    size: 18,
                  ),
                  const SizedBox(width: 8.0),
                  const Expanded(
                    child: Text(
                      "Unpaid"
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(widget.summary?['unpaid'] ?? '-')
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.trending_up,
                    size: 18,
                  ),
                  const SizedBox(width: 8.0),
                  const Expanded(
                    child: Text(
                      "Over Paid"
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(widget.summary?['overPaid'] ?? '-')
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.summarize,
                    size: 18,
                  ),
                  const SizedBox(width: 8.0),
                  const Expanded(
                    child: Text(
                      "Total"
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(widget.summary?['total'] ?? '-')
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