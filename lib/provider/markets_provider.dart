import 'dart:async';

import 'package:cryptotracker_app_flutter/models/API.dart';
import 'package:cryptotracker_app_flutter/models/cryptocurrency.dart';
import 'package:flutter/cupertino.dart';

class MarketProvider with ChangeNotifier {
  bool isLoading = true;
  List<CryptoCurrency> markets = []; // ek list bnaye CryptoCurrency ka..
  // kyuki kai sare cyptocurrency ko dikhana padegha na..isilie list bana pada

  MarketProvider() {
    fetchdata();
  } //constructor // isse ye hoga ki MarketProvider ka instance banayege to fetchdata apne aap call ho jayega

  void fetchdata() async {
    List<dynamic> _markets = await API.getmarkets();

    List<CryptoCurrency> temp = []; // ek aur temporary list kyu lena pada yar

    for (var market in _markets) {
      CryptoCurrency newCrypto = CryptoCurrency.fromJSON(market);
      temp.add(newCrypto); // list me ek crypto add hua
    }

    markets = temp;
    isLoading = false;
    notifyListeners();

    Timer(const Duration(seconds: 3), () {
      fetchdata();
      print("DATA updated !!");
    });
  }

  CryptoCurrency fetchCryptoById(String id) {
    CryptoCurrency crypto =
        markets.where((element) => element.id == id).toList()[0];
    return crypto;
  }
}
