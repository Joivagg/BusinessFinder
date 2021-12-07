import 'package:http/http.dart' as http;

class ServerConnection {
  final _svrUrl='https://script.google.com/macros/s/AKfycbzN8Iffl93KEfEV3tGD2DA4BmkFxVkuW9dOlPaCRYbllalzUg/exec';
  Future<String> select(String table) async {
    final url = Uri.parse(_svrUrl + '?&acc=1&tbl=' + table);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return response.body; //me duevelve un futuro string con  los datos del json
    } else {
      return 'response status: ${response.statusCode}';
    }
  }

  Future<String> insert(String table, String data) async {
    final url = Uri.parse(_svrUrl);
    var response = await http.post(url, body: {'acc': '2', 'tbl': table, 'data': data});
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return 'response status: ${response.statusCode}';
    }
  }
}