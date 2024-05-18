import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SchoolSearchInput extends StatelessWidget {
  final FocusNode textFocus1;
  const SchoolSearchInput({super.key, required this.textFocus1});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 10,
          child: Container(
            width: 200,
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  focusNode: textFocus1,
                  onChanged: (value) {
                    schoolNameInput = value;
                  },
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '학교 이름 입력',
                  ),
                  onEditingComplete: () {
                    textFocus1.unfocus();
                  },
                ),
              ],
            ),
          ),
        ),
        const Spacer(
          flex: 1,
        ),
        Flexible(
          flex: 6,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 120, 118, 254),
              minimumSize: const Size(50, 63),
            ),
            child: const Text(
              '학교 찾기',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15.0,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              textFocus1.unfocus();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SchoolSearch(
                    input: schoolNameInput,
                  ),
                ),
              ).then((value) => setState(() {
                    initPref();
                  }));
            },
          ),
        ),
      ],
    );
  }
}
