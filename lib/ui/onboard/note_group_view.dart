import 'package:digging/domain/note_group.dart';
import 'package:digging/ui/design/digging_color.dart';
import 'package:digging/ui/onboard/age_group/age_group.dart';
import 'package:digging/ui/onboard/bloc/onboard_bloc.dart';
import 'package:digging/ui/onboard/gender/gender.dart';
import 'package:digging/ui/onboard/note_group/note_group.dart';
import 'package:digging/ui/onboard/onboard_dots_indicator.dart';
import 'package:digging/ui/onboard/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteGroupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardBloc, OnboardState>(
      builder: (context, state) => Scaffold(
        appBar: _appBar(context),
        body: SafeArea(
          child: Container(
            color: DiggingColor.whiteGrey,
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
        floatingActionButton: BlocBuilder<NoteGroupBloc, NoteGroupState>(
          builder: (context, state) => _FloatingActionButton(
            isAvailable:
                context.read<NoteGroupBloc>().state.noteGroupIds.isNotEmpty,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  void _goToPreviousPage(BuildContext context) {
    context
        .read<OnboardBloc>()
        .add(OnboardStatusChanged(status: OnboardStatus.genderAndAge));
  }

  void _submitOnboard(BuildContext context) {
    context.read<OnboardBloc>().add(
          OnboardSubmitted(
            gender: context.read<GenderBloc>().state.gender,
            ageGroup: context.read<AgeGroupBloc>().state.ageGroup,
            noteGroupIds: context.read<NoteGroupBloc>().state.noteGroupIds,
          ),
        );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: OnboardDotsIndicator(position: 2),
      centerTitle: true,
      backgroundColor: DiggingColor.whiteGrey,
      elevation: 0.0,
      leading: IconButton(
        onPressed: () => _goToPreviousPage(context),
        icon: Icon(
          Icons.arrow_back_ios,
          color: Color(0xff888888),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => _submitOnboard(context),
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
      children: getNoteGroupWidgets(),
    );
  }

  List<Widget> getNoteGroupWidgets() => NoteGroup.getCategorizedNoteGroups()
      .map((e) => _NoteGroupButton(noteGroup: e))
      .toList();
}

class _FloatingActionButton extends StatelessWidget {
  const _FloatingActionButton({required this.isAvailable});

  final isAvailable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6.0,
        horizontal: 20.0,
      ),
      child: isAvailable ? _activeButton(context) : _inactiveButton(),
    );
  }

  Widget _activeButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _submitOnboard(context),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(DiggingColor.black),
      ),
      child: Container(
        height: 52,
        child: _buttonText(),
      ),
    );
  }

  Widget _inactiveButton() {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: DiggingColor.grey100,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: _buttonText(),
    );
  }

  Widget _buttonText() {
    return Center(
      child: Text(
        "선택 완료",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  void _submitOnboard(BuildContext context) {
    context.read<OnboardBloc>().add(
          OnboardSubmitted(
            gender: context.read<GenderBloc>().state.gender,
            ageGroup: context.read<AgeGroupBloc>().state.ageGroup,
            noteGroupIds: context.read<NoteGroupBloc>().state.noteGroupIds,
          ),
        );
  }
}

class _NoteGroupButton extends StatelessWidget {
  _NoteGroupButton({required this.noteGroup});

  final NoteGroup noteGroup;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteGroupBloc, NoteGroupState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(6.0),
          child: GestureDetector(
            onTap: () {
              final noteGroupBloc = context.read<NoteGroupBloc>();
              if (_isSelected(state)) {
                noteGroupBloc.add(NoteGroupRemoved(noteGroupId: noteGroup.id));
              } else {
                noteGroupBloc.add(NoteGroupAdded(noteGroupId: noteGroup.id));
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: _getBorder(state),
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
      },
    );
  }

  Border? _getBorder(NoteGroupState state) {
    return _isSelected(state) ? Border.all(color: Color(0xff83daff)) : null;
  }

  bool _isSelected(NoteGroupState state) {
    return state.noteGroupIds.contains(noteGroup.id);
  }
}
