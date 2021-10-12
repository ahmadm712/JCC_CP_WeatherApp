import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp/models/models.dart';

class SplashScreen extends StatelessWidget {
  WeatherResponse _response;
  var respone = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('${respone.tempInfo.temperature}'),
      ),
    );
  }
}
