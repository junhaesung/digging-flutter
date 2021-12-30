import 'package:digging/adapter/api/DiggingApi.dart';
import 'package:digging/ui/onboard/bloc/onboard_bloc.dart';
import 'package:digging/ui/onboard/onboard_dots_indicator.dart';
import 'package:digging/ui/onboard/repository/onboard_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NicknameView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NicknameView();
}

class _NicknameView extends State<NicknameView> {
  final _formKey = GlobalKey<FormState>();
  final _api = const DiggingApi();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardBloc, OnboardState>(
      builder: (context, state) {
        return Scaffold(
          appBar: _appBar(),
          body: Container(
            color: Color(0xffe5e5e5),
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
                      Container(
                        height: 52,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            validator: (value) {
                              if (value == null ||
                                  value.length < 2 ||
                                  value.length > 6) {
                                return "2자~6자까지 입력이 가능해요.";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _formKey.currentState?.validate();
                            },
                            onFieldSubmitted: (value) async {
                              if (_formKey.currentState?.validate() == true) {
                                final result =
                                    await _api.update(nickname: value);
                                print('result: $result');
                                if (result == null) {
                                  print('success');
                                } else {
                                  print('failure. result: $result');
                                }
                              }
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
                      ),
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
      backgroundColor: Color(0xffe5e5e5),
      automaticallyImplyLeading: false,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _floatingActionButtonWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 6.0,
        horizontal: 20.0,
      ),
      child: ElevatedButton(
        onPressed: () => _goToNextPage(context),
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

  void _goToNextPage(BuildContext context) {
    context
        .read<OnboardBloc>()
        .add(OnboardStatusChanged(status: OnboardStatus.genderAndAge));
  }
}
