// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:mbinu/ui/utils/color_extension.dart';

class ProductDetailsColorSelector extends StatefulWidget {
  final List<String> colors;
  final int selectedColor;
  final Function(int index) onSelected;

  const ProductDetailsColorSelector({
    Key? key,
    required this.colors,
    required this.selectedColor,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<ProductDetailsColorSelector> createState() =>
      _ProductDetailsColorSelectorState();
}

class _ProductDetailsColorSelectorState
    extends State<ProductDetailsColorSelector> {
  int colorSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.colors.length,
        itemBuilder: (context, int index) {
          return InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              colorSelectedIndex = index;
              widget.onSelected(index);
              if (mounted) {
                setState(() {});
              }
            },
            child: CircleAvatar(
              radius: 18,
              backgroundColor: HexColor.fromHex(widget.colors[index]),
              child:
                  colorSelectedIndex == index
                      ? const Icon(Icons.done, color: Colors.white)
                      : null,
            ),
          );
        },
        separatorBuilder: (context, int index) {
          return const SizedBox(width: 8);
        },
      ),
    );
  }
}
