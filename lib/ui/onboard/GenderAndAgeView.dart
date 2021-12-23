import 'package:digging/ui/onboard/gender/gender.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'age_group/age_group.dart';

class GenderAndAgeView extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(builder: (context) => GenderAndAgeView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(context),
      body: SafeArea(
        child: Container(
          color: Color(0xffe5e5e5),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
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

  List<Widget> _getAgeGroupWidgets() => AgeGroup.values
      .where((e) => e != AgeGroup.UNKNOWN)
      .map((e) => _AgeGroupButton(ageGroup: e))
      .toList();

  _goToNoteGroupView(BuildContext context) {
    Navigator.pushNamed(context, '/onboard/note-group');
  }

  Widget _floatingActionButtonWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6.0,
        horizontal: 20.0,
      ),
      child: ElevatedButton(
        onPressed: () {
          _goToNoteGroupView(context);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xff1c1c1c)),
        ),
        child: Container(
          height: 52,
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

  Widget _titleWidget() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 32,
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
    return BlocProvider(
      create: (context) => GenderBloc(),
      child: Column(
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
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: [
                _GenderButton.female(),
                _GenderButton.male(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _ageGroupWidget() {
    return BlocProvider(
      create: (context) => AgeGroupBloc(),
      child: Column(
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
            child: GridView.count(
              crossAxisSpacing: 8.0,
              childAspectRatio: 1,
              crossAxisCount: 5,
              children: _getAgeGroupWidgets(),
            ),
          ),
        ],
      ),
    );
  }
}

/// 성별 선택 버튼
class _GenderButton extends StatelessWidget {
  const _GenderButton._(this.gender);

  factory _GenderButton.female() {
    return _GenderButton._(Gender.FEMALE);
  }

  factory _GenderButton.male() {
    return _GenderButton._(Gender.MALE);
  }

  final Gender gender;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenderBloc, GenderState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        final genderText = this.gender.buttonName();
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () {
              context
                  .read<GenderBloc>()
                  .add(GenderChanged(gender: this.gender));
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(_getImagePath(state)),
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: Center(
                child: Text(
                  genderText,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(_getColorValue(state)),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String _getImagePath(GenderState state) => _isSelected(state)
      ? 'images/onboarding/gender_selected.png'
      : 'images/onboarding/gender_normal.png';

  int _getColorValue(GenderState state) =>
      _isSelected(state) ? 0xff1b1b1b : 0xff888888;

  bool _isSelected(GenderState state) => this.gender == state.gender;
}

/// 나이 선택 버튼
class _AgeGroupButton extends StatelessWidget {
  const _AgeGroupButton({
    required this.ageGroup,
  });

  final AgeGroup ageGroup;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgeGroupBloc, AgeGroupState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) => GestureDetector(
        onTap: () {
          context
              .read<AgeGroupBloc>()
              .add(AgeGroupChanged(ageGroup: this.ageGroup));
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(_getImagePath(state)),
            ),
          ),
          child: Center(
            child: Text(
              "${ageGroup.getAge()}대",
              style: TextStyle(
                fontSize: 14,
                color: Color(_getColorValue(state)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getImagePath(AgeGroupState state) => _isSelected(state)
        ? 'images/onboarding/age_selected.png'
        : 'images/onboarding/age_normal.png';

  int _getColorValue(AgeGroupState state) =>
      _isSelected(state) ? 0xff1b1b1b : 0xff888888;

  bool _isSelected(AgeGroupState state) => this.ageGroup == state.ageGroup;
}
