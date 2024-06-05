// ignore_for_file: file_names
library globals;

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class appDatas {
  Future<String?> dataSet(int x) async {
    //call api end points
    var url = Uri.parse('http://busspass.somee.com/api/Passenger/$x');

    var response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      if (kDebugMode) {
        print('Request failed with status: ${response.statusCode}.');
      }
    }
    return null;
  }
}
