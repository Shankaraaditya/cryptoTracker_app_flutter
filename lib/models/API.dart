import 'dart:convert';

import 'package:http/http.dart' as http;

class API {
 static Future<List<dynamic>> getmarkets() async{
    Uri requestpath = Uri.parse(
        "https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&order=market_cap_desc&per_page=20&page=1&sparkline=false");

    var response = await http.get(requestpath); 

    var decodeResponse = await jsonDecode(response.body.toString());

    List<dynamic> markets = decodeResponse as List<dynamic>;
    return markets;
  }
}
