import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class PeticionesServicios {
  Future<bool> setServicios(contenido) async {
    try {
      var uri = Uri.parse("https://serviciostaller.onrender.com/api/servicios");
      final response = await http.post(uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(contenido));

      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      return false;
    }

    return false;
  }

  Future<dynamic> getServicios() async {
    try {
      var uri = Uri.parse("https://serviciostaller.onrender.com/api/servicios");
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      return jsonEncode({"error": "conexion fallida."});
    }
  }

  Future<dynamic> updateServicios(String id, dynamic datos) async {
    try {
      var uri =
          Uri.parse("ttps://serviciostaller.onrender.com/api/servicios/$id");
      final response = await http.put(uri,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(datos));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      return jsonEncode({"error": "conexion fallida."});
    }
    return null;
  }

  Future<dynamic> deleteServicio(String id) async {
    try {
      var uri =
          Uri.parse("https://serviciostaller.onrender.com/api/servicios/$id");
      final response = await http.delete(uri);

      if (response.statusCode == 200) {
        return {"men": "el servicio con el id $id fue eliminado"};
      }
    } catch (e) {
      return jsonEncode({"error": "conexion fallida."});
    }
  }
}
