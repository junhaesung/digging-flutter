import 'package:digging/domain/ageGroup.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class GenderAndAgeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GenderAndAgeView();
}

class _GenderAndAgeView extends State<GenderAndAgeView> {
  var _selectedNoteGroups = 0;
  var _selectedAgeGroup = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DotsIndicator(dotsCount: 3, position: 1),
        centerTitle: true,
        backgroundColor: Color(0xffe5e5e5),
        elevation: 0.0,
        actions: [
          TextButton(
            onPressed: () {
              _goToNoteGroupView(context);
            },
            child: Text(
              '건너뛰기',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff888888),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          color: Color(0xffe5e5e5),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 32,
                    left: 10,
                    right: 10,
                    bottom: 44,
                  ),
                  child: Container(
                    child: Text(
                      '성별과 \n나이를 선택해주세요.',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1d1d20),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '성별',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1d1d20),
                      ),
                    ),
                    Container(
                      height: 200,
                      child: GridView.count(
                        crossAxisCount: 2,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'images/onboarding/selector_gender.png'),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '여성',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff888888),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'images/onboarding/selector_gender.png'),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '남성',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xff888888),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '나이',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1d1d20),
                      ),
                    ),
                    Container(height: 28),
                    Container(
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: GridView.count(
                          crossAxisSpacing: 8.0,
                          childAspectRatio: 1,
                          crossAxisCount: 5,
                          children: _getAgeGroupWidgets(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _floatingActionButtonWidget(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  List<Widget> _getAgeGroupWidgets() =>
      AgeGroups.getAgeGroups().map((e) => _toAgeWidget(e)).toList();

  Widget _toAgeWidget(AgeGroup ageGroup) => ClipOval(
        child: Container(
          color: Colors.white,
          child: Center(
            child: Text(
              ageGroup.age.toString() + "대",
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff888888),
              ),
            ),
          ),
        ),
      );

  _goToNoteGroupView(BuildContext context) {
    Navigator.pushNamed(context, '/onboard/note-group');
  }

  Widget _floatingActionButtonWidget(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _goToNoteGroupView(context);
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xff1c1c1c)),
      ),
      child: Container(
        height: 52,
        width: 340,
        child: Center(
          child: Text(
            "다음",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
