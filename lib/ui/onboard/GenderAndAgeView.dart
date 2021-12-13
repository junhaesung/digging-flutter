import 'package:digging/domain/ageGroup.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class GenderAndAgeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GenderAndAgeView();
}

class _GenderAndAgeView extends State<GenderAndAgeView> {
  // TODO: 성별 선택 레이아웃 작성중
  var _selectedGender = 0;
  var _selectedAgeGroup = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(context),
      body: SafeArea(
        child: Container(
          color: Color(0xffe5e5e5),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView(
              children: [
                _titleWidget(),
                _genderWidget(),
                _ageGroupWidget(),
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

  PreferredSizeWidget _appBarWidget(BuildContext context) {
    return AppBar(
      title: DotsIndicator(dotsCount: 3, position: 1),
      centerTitle: true,
      backgroundColor: Color(0xffe5e5e5),
      elevation: 0.0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: Color(0xff888888),
        ),
      ),
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
    );
  }

  Widget _genderButtonWidget(String genderText) {
    var selected = false;
    if (_selectedGender == 1 && genderText == '여성') {
      selected = true;
    }
    if (_selectedGender == 2 && genderText == '남성') {
      selected = true;
    }

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            var current = genderText == '여성' ? 1 : 2;
            _selectedGender = _selectedGender != current ? current : 0;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(selected
                  ? 'images/onboarding/gender_selected.png'
                  : 'images/onboarding/gender_normal.png'),
              fit: BoxFit.fitWidth,
            ),
          ),
          child: Center(
            child: Text(
              genderText,
              style: TextStyle(
                fontSize: 16,
                color: Color(selected ? 0xff1b1b1b : 0xff888888),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleWidget() {
    return Padding(
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
    );
  }

  Widget _genderWidget() {
    return Column(
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
              _genderButtonWidget('여성'),
              _genderButtonWidget('남성'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _ageGroupWidget() {
    return Column(
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
    );
  }
}
