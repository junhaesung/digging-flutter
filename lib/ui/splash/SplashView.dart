import 'package:digging/adapter/api/DiggingApi.dart';
import 'package:digging/util/device_id_resolver.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  final DiggingApi _api = DiggingApi();

  @override
  Widget build(BuildContext context) {
    goToOnboardDescription(context);
    return Scaffold(
      backgroundColor: Color(0xfff8f8f8),
      body: Container(
        child: Column(
          children: [
            Image.asset('images/splash_background.png'),
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Center(
                    child: Image.asset(
                      'images/logo.png',
                      fit: BoxFit.fitHeight,
                      height: 50,
                    ),
                  ),
                ),
              ),
            ),
            RotatedBox(
              quarterTurns: 2,
              child: Image.asset('images/splash_background.png'),
            ),
          ],
        ),
      ),
    );
  }

  _login() async {
    final deviceId = await DeviceIdResolver.resolveDeviceId();
    final loginResponse = await _api.login(deviceId);
    print('accessToken: ${loginResponse.accessToken}');
    print('memberDetail: ${loginResponse.memberDetail}');
    // TODO: save accessToken
  }

  goToOnboardDescription(BuildContext context) async {
    await _login();
    Navigator.pushReplacementNamed(context, '/onboard/description');
    // Navigator.of(context).pushReplacement(NicknamePage.route());
  }
}
