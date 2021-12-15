import 'package:digging/domain/notegroup.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class NoteGroupView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NoteGroupView();
}

class _NoteGroupView extends State<NoteGroupView> {
  Set<int> _selectedNoteGroupIds = Set.of([]);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _appBarWidget(context),
        body: SafeArea(
          child: Container(
            color: Color(0xffe5e5e5),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  _titleWidget(),
                  _descriptionWidget(),
                  Expanded(
                    child: _noteGroupsWidget(),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: _floatingActionButtonWidget(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );

  void _goToMainView(BuildContext context) {
    while (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    Navigator.pushReplacementNamed(context, '/main');
  }

  Widget _floatingActionButtonWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6.0,
        horizontal: 20.0,
      ),
      child: ElevatedButton(
        onPressed: () {
          _goToMainView(context);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xff1c1c1c)),
        ),
        child: Container(
          height: 52,
          child: Center(
            child: Text(
              "선택 완료",
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
      title: DotsIndicator(dotsCount: 3, position: 2),
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
            // TODO: api 요청
            // 메인페이지 이동
            _goToMainView(context);
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
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '좋아하는\n향수 노트를 알고싶어요.',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xff1d1d20),
            ),
          ),
          Container(
            height: 14,
          ),
          Text(
            '취향을 선택하고 나에게 맞는 향수를 찾아보세요.',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _descriptionWidget() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 28),
        child: Center(
            child: Text(
          '최대 3가지 선택',
          style: TextStyle(
            color: Color(0xff888888),
          ),
        )),
      ),
    );
  }

  Widget _noteGroupsWidget() {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 162 / 104,
      children: getNoteGroupWidgets(context),
    );
  }

  List<Widget> getNoteGroupWidgets(BuildContext context) =>
      NoteGroup.getCategorizedNoteGroups()
          .map((e) => _toNoteGroupWidget(context, e))
          .toList();

  Widget _toNoteGroupWidget(BuildContext context, NoteGroup noteGroup) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (_selectedNoteGroupIds.contains(noteGroup.id)) {
              _selectedNoteGroupIds.remove(noteGroup.id);
            } else if (_selectedNoteGroupIds.length < 3) {
              _selectedNoteGroupIds.add(noteGroup.id);
            } else {
              // do nothing
            }
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: _selectedNoteGroupIds.contains(noteGroup.id)
                ? Border.all(color: Color(0xff83daff))
                : null,
            color: Colors.white,
          ),
          child: Column(
            children: [
              Container(height: 20),
              Image.asset(
                noteGroup.assetImageName,
                height: 32,
                fit: BoxFit.fitHeight,
              ),
              Container(height: 10),
              Text(
                noteGroup.name,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff888888),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
