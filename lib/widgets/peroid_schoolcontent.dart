import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class PeroidAndClassContentBox extends StatelessWidget {
  final String peroid;
  final String schoolContent;

  const PeroidAndClassContentBox({
    super.key,
    required this.peroid,
    required this.schoolContent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              flex: 2,
              child: Stack(
                children: [
                  Transform.translate(
                    offset: const Offset(3, 3),
                    child: DottedBorder(
                      borderPadding: const EdgeInsets.all(0),
                      strokeWidth: 2,
                      dashPattern: const [6, 3],
                      radius: const Radius.circular(10),
                      borderType: BorderType.RRect,
                      child: const SizedBox(
                        height: 46,
                        width: 96,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          offset: const Offset(2, 3),
                          blurRadius: 1,
                          spreadRadius: 1,
                        ),
                      ],
                      color: Colors.white,
                      border: Border.all(),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '$peroid교시',
                        style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Flexible(
              flex: 4,
              child: Stack(
                children: [
                  Transform.translate(
                    offset: const Offset(3, 3),
                    child: DottedBorder(
                      borderPadding: const EdgeInsets.all(0),
                      strokeWidth: 2,
                      dashPattern: const [6, 3],
                      radius: const Radius.circular(10),
                      borderType: BorderType.RRect,
                      child: const SizedBox(
                        height: 46,
                        width: 171,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(5),
                    height: 50,
                    width: 175,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.6),
                          offset: const Offset(2, 3),
                          blurRadius: 1,
                          spreadRadius: 1,
                        ),
                      ],
                      color: Colors.white,
                      border: Border.all(),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        schoolContent,
                        style: TextStyle(
                          color: Theme.of(context).hintColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 35,
        ),
      ],
    );
  }
}
