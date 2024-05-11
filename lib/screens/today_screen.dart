import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/school_search.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

//TODO 첫화면체크랑 위에거 기기에 저장하기 만들기

class _TodayScreenState extends State<TodayScreen> {
  bool isFirst = true;
  FocusNode textFocus1 = FocusNode();
  FocusNode textFocus2 = FocusNode();

  @override
  Widget build(BuildContext context) {
    String schoolNameInput = '';
    String schoolNumber = '';

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: const Color.fromARGB(255, 24, 6, 131),
          backgroundColor: const Color.fromARGB(255, 24, 6, 131),
          shadowColor: Colors.black,
          elevation: 5,
          title: const Center(
            child: Text(
              '설정',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: isFirst
            ? Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 200,
                          height: 55,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 245, 242, 242),
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
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(20, 55),
                            backgroundColor: Colors.white,
                            shadowColor: Colors.black,
                            elevation: 5,
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                          ),
                          child: const Text('학교 찾기'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SchoolSearch(
                                  input: schoolNameInput,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 315,
                      height: 55,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 245, 242, 242),
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(5),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            focusNode: textFocus2,
                            onChanged: (value) {
                              schoolNumber = value;
                            },
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '학번 입력',
                            ),
                            onEditingComplete: () {
                              textFocus2.unfocus();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : const Column());
  }
}
