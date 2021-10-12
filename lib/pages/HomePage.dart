// ignore_for_file: file_names

import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/models/models.dart';
import 'package:weatherapp/models/provincemodels.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/services/data_services.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _cityTextController = TextEditingController();
  final _dataService = DataService();
  WeatherResponse _response;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App Bro'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_response != null)
                Column(
                  children: [
                    Image.network(_response.iconUrl),
                    Text(
                      '${_response.tempInfo.temperature}°',
                      style: const TextStyle(fontSize: 40),
                    ),
                    Text(_response.weatherInfo.description)
                  ],
                ),
              DropdownSearch<Province>(
                label: "Provinsi",
                showSearchBox: true,
                searchBoxDecoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  hintText: "cari provinsi...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onFind: (String filter) async {
                  Uri url =
                      Uri.parse("https://api.rajaongkir.com/starter/province");

                  try {
                    final response = await http.get(
                      url,
                      headers: {
                        "key": "9e6ff413196b68af0e46b61708d8285c",
                      },
                    );
                    var data =
                        json.decode(response.body) as Map<String, dynamic>;

                    var statusCode = data["rajaongkir"]["status"]["code"];

                    if (statusCode != 200) {
                      throw data["rajaongkir"]["status"]["description"];
                    }

                    var listAllProvince =
                        data["rajaongkir"]["results"] as List<dynamic>;

                    var models = Province.fromJsonList(listAllProvince);
                    return models;
                  } catch (err) {
                    print(err);
                    return List<Province>.empty();
                  }
                },
                onChanged: (value) => print(value.province),
                popupItemBuilder: (context, item, isSelected) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      "${item.province}",
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  );
                },
                itemAsString: (item) => item.province,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: SizedBox(
                  width: 150,
                  child: TextField(
                      controller: _cityTextController,
                      decoration: InputDecoration(labelText: 'City'),
                      textAlign: TextAlign.center),
                ),
              ),
              ElevatedButton(onPressed: _search, child: const Text('Search')),
              ElevatedButton(onPressed: _search, child: const Text('Next')),
            ],
          ),
        ),
      ),
    );
  }

  void _search() async {
    final response = await _dataService.getWeather(_cityTextController.text);
    setState(() => _response = response);
  }
}
