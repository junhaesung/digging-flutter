import 'package:digging/adapter/api/DiggingApi.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class NicknameView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NicknameView();
}

class _NicknameView extends State<NicknameView> {
  final _formKey = GlobalKey<FormState>();
  final _api = DiggingApi();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DotsIndicator(dotsCount: 3, position: 0),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color(0xffe5e5e5),
      ),
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
                          if (value == null || value.length < 2 || value.length > 6) {
                            return "2자~6자까지 입력이 가능해요.";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          _formKey.currentState?.validate();
                        },
                        onFieldSubmitted: (value) async {
                          if (_formKey.currentState?.validate() == true) {
                            final result = await _api.update(nickname: value);
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
        onPressed: () {
          Navigator.pushNamed(context, '/onboard/gender-and-age');
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
}
