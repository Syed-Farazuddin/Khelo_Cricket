import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonList extends StatelessWidget {
  final List list;
  final int active;
  final void Function(int value) onTap;
  const ButtonList({
    super.key,
    required this.list,
    required this.onTap,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          width: 10,
        ),
        shrinkWrap: true,
        itemCount: list.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (builder, index) {
          return GestureDetector(
            onTap: () => onTap(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 12,
              ),
              decoration: BoxDecoration(
                color: active == index
                    ? Colors.grey.withOpacity(
                        0.5,
                      )
                    : Colors.transparent,
                border: Border.all(
                  width: 0.1,
                  strokeAlign: BorderSide.strokeAlignOutside,
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(
                  12,
                ),
              ),
              child: Text(
                list[index].toString(),
                style: GoogleFonts.golosText(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
