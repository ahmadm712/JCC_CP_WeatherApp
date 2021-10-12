import 'package:http/http.dart' as http;
import 'package:weatherapp/models/provincemodels.dart';

void main() async {
  Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");
  final response =
      await http.get(url, headers: {"key": "9e6ff413196b68af0e46b61708d8285c"});
}
