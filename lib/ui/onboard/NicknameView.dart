import 'package:digging/ui/design/digging_color.dart';
import 'package:digging/ui/onboard/bloc/onboard_bloc.dart';
import 'package:digging/ui/onboard/nickname/bloc/nickname_bloc.dart';
import 'package:digging/ui/onboard/nickname/model/model.dart';
import 'package:digging/ui/onboard/onboard_dots_indicator.dart';
import 'package:digging/ui/onboard/repository/onboard_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NicknameView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NicknameView();
}

class _NicknameView extends State<NicknameView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardBloc, OnboardState>(
      builder: (context, state) {
        return Scaffold(
          appBar: _appBar(),
          body: Container(
            color: DiggingColor.whiteGrey,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 32),
                      Text(
                        '사용하실 \n닉네임을 입력하세요',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff1d1d20),
                        ),
                      ),
                      Container(height: 28),
                      _nicknameForm(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          floatingActionButton: _floatingActionButtonWidget(context),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: OnboardDotsIndicator(position: 0),
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: DiggingColor.whiteGrey,
      automaticallyImplyLeading: false,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _floatingActionButtonWidget(BuildContext context) {
    return BlocBuilder<NicknameBloc, NicknameState>(
      builder: (context, state) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 6.0,
          horizontal: 20.0,
        ),
        child: state.status == NicknameStatus.completed
            ? _activeButton()
            : _inactiveButton(),
      ),
    );
  }

  _activeButton() {
    return ElevatedButton(
      onPressed: () => _goToNextPage(context),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(DiggingColor.black),
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
    );
  }

  _inactiveButton() {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: Color(0xffc7c7c7),
        borderRadius: BorderRadius.circular(4.0),
      ),
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
    );
  }

  void _goToNextPage(BuildContext context) {
    context
        .read<OnboardBloc>()
        .add(OnboardStatusChanged(status: OnboardStatus.genderAndAge));
  }

  Widget _nicknameForm() {
    return BlocBuilder<NicknameBloc, NicknameState>(
      builder: (context, state) {
        final nicknameBloc = context.read<NicknameBloc>();
        final hasErrorMessage = state.validation.message.isNotEmpty;
        return Column(
          children: [
            Container(
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: hasErrorMessage
                    ? BorderDirectional(
                        top: BorderSide(color: Color(0xfff94747)),
                        bottom: BorderSide(color: Color(0xfff94747)),
                        start: BorderSide(color: Color(0xfff94747)),
                        end: BorderSide(color: Color(0xfff94747)),
                      )
                    : null,
              ),
              child: TextFormField(
                initialValue: state.nickname,
                autofocus: true,
                onChanged: (value) {
                  nicknameBloc.add(NicknameChanged(nickname: value));
                },
                onFieldSubmitted: (value) {
                  nicknameBloc.add(NicknameSubmitted(nickname: value));
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '2자~6자까지 입력이 가능해요.',
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Color(0xffc7c7c7),
                  ),
                ),
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.go,
                enableSuggestions: false,
              ),
            ),
            Container(height: 14),
            if (state.validation.message.isNotEmpty)
              Text(
                state.validation.message,
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xfff94747),
                ),
              ),
          ],
        );
      },
    );
  }
}
