// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ReuseableRow extends StatelessWidget {
  const ReuseableRow({super.key, required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 15),
              ),
              Text(value, style: const TextStyle(fontSize: 15))
            ],
          ),
          const SizedBox(height: 5),
          const Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}
