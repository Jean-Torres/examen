import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class PeticionesDolar {
  Future<dynamic> getDolar() async {
    try {
      var uri = Uri.parse(
          "https://www.datos.gov.co/resource/32sa-8pi3.json?vigenciadesde=${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day - 2}");
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      return jsonEncode({"error": "conexion fallida."});
    }
  }
}
