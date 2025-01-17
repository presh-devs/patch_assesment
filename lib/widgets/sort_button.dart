import 'package:flutter/material.dart';
import 'package:patch_assesment/features/home/view_model/products_view_model.dart';

class SortButton extends StatelessWidget {
  const SortButton({
    super.key,
    required this.viewModel,
    required this.title,
    required this.onPressed,
  });

  final ProductsViewModel viewModel;
  final bool isSortedDescending = false;
  final bool isSortedAscending = false;
  final String title;
  final Function() onPressed;

  getSortMode() {
    if (title == 'Lowest price first') {
      return viewModel.isSortedAscending;
    } else {
      return viewModel.isSortedDescending;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: const BorderSide(color: Color(0xFFCACACA), width: 0.5)),
          backgroundColor: getSortMode() // Change color based on sorting
              ? const Color(0xFF7A6EAE)
              : const Color(0xFFCACACA),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: getSortMode() // Change color based on sorting
                  ? Colors.white
                  : Colors.black),
        ),
      ),
    );
  }
}
