import 'package:cryptotracker_app_flutter/models/cryptocurrency.dart';
import 'package:cryptotracker_app_flutter/provider/markets_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  // DetailsPage({Key? key}) : super(key: key);
  final String id;

  const DetailsPage({super.key, required this.id});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  
  //////// function for details to be shown in  the details page/////////
  Widget titleAndDetail(String title, String details,CrossAxisAlignment crossAxisAlignment) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
      Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold,
        fontSize: 17),
      ),

      Text(details,style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 17
      ),),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Consumer<MarketProvider>(
          builder: (context, marketProvider, child) {
            CryptoCurrency currentCrypto =
                marketProvider.fetchCryptoById(widget.id);

            return ListView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(currentCrypto.image!),
                  ),
                  title: Text(
                    "${currentCrypto.name!}  (${currentCrypto.symbol!.toUpperCase()})",
                    style: const TextStyle(fontSize: 20),
                  ),
                  subtitle: Text("₹ ${currentCrypto.currentPrice}",
                      style: const TextStyle(
                          color: Color(0xff0395eb),
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                ),

                const SizedBox(height: 20,),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text("Price Change(24h)", style: TextStyle(fontSize: 25 , fontWeight: FontWeight.bold),
                    ),

                      Builder(builder: (context) {
                        double priceChange =
                            currentCrypto.priceChange24!;
                        double priceChangePercentage =
                            currentCrypto.priceChangePercentage24!;

                        if (priceChange < 0) {
                          return Text(
                            "${priceChangePercentage.toStringAsFixed(2)} % (${priceChange.toStringAsFixed(4)})",
                            style:
                                const TextStyle(color: Colors.red, fontSize: 30),
                          );
                        } else {
                          return Text(
                            "${priceChangePercentage.toStringAsFixed(2)} % (${priceChange.toStringAsFixed(4)})",
                            style: const TextStyle(
                                color: Colors.green, fontSize: 30),
                        );
                      }
                    })
                   ],
                ),




                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    titleAndDetail("Market Cap","₹ "+ currentCrypto.currentPrice!.toStringAsFixed(4), CrossAxisAlignment.start),

                    titleAndDetail("Market Cap Rank","#"+ currentCrypto.marketCapRank!.toString(), CrossAxisAlignment.end)

                  ],
                ),

                const SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    titleAndDetail("Low 24h","₹ "+ currentCrypto.low24!.toStringAsFixed(4), CrossAxisAlignment.start),

                    titleAndDetail("High 24h","₹ "+ currentCrypto.high24!.toStringAsFixed(4), CrossAxisAlignment.end)

                  ],
                ),

                const SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    titleAndDetail("Circulating Supply","₹ "+ currentCrypto.circulatingSupply!.toInt().toString(), CrossAxisAlignment.start),

                 

                  ],
                ),

                const SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    titleAndDetail("All Time Low","₹ "+ currentCrypto.atl!.toStringAsFixed(4), CrossAxisAlignment.start),
                    
                    titleAndDetail("All Time Low","₹ "+ currentCrypto.ath!.toStringAsFixed(4), CrossAxisAlignment.end),

                 

                  ],
                )
              ],
            );
          },
        ),
      )),
    );
  }
}
