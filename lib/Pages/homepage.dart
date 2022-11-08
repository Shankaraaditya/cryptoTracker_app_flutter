import 'package:cryptotracker_app_flutter/Pages/details_page.dart';
import 'package:cryptotracker_app_flutter/models/cryptocurrency.dart';
import 'package:cryptotracker_app_flutter/provider/markets_provider.dart';
import 'package:cryptotracker_app_flutter/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: 0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome Back',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Crypto Today',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      // Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                      themeProvider.toggleTheme();
                    },
                    icon: (themeProvider.themeMode == ThemeMode.light)
                        ? const Icon(Icons.dark_mode)
                        : const Icon(Icons.light_mode))
              ],
            ),

            const SizedBox(
              height: 10,
            ),

            // expanded -->> ek column me jitna jagah bacha hai usko gher leta hai
            Expanded(child: Consumer<MarketProvider>(
              builder: (context, marketProvider, child) {
                if (marketProvider.isLoading == true) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (marketProvider.markets.length > 0) {
                    return ListView.builder(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: marketProvider.markets.length,
                        itemBuilder: (context, index) {
                          CryptoCurrency currentCrypto =
                              marketProvider.markets[index];

                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailsPage(id: currentCrypto.id!)));
                            },
                            leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    NetworkImage(currentCrypto.image!)),
                            title: Text(
                                "${currentCrypto.name!} #${currentCrypto.marketCapRank}"),
                            subtitle: Text(currentCrypto.symbol!.toUpperCase()),
                            trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "₹ ${currentCrypto.currentPrice!.toStringAsFixed(4)}",
                                    style: const TextStyle(
                                        color: Color(0xff0395eb),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
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
                                            const TextStyle(color: Colors.red),
                                      );
                                    } else {
                                      return Text(
                                        "${priceChangePercentage.toStringAsFixed(2)} % (${priceChange.toStringAsFixed(4)})",
                                        style: const TextStyle(
                                            color: Colors.green),
                                      );
                                    }
                                  })
                                ]),
                          );
                        });
                  } else {
                    return const Text("DATA not found!!!");
                  }
                }
              },
            )),
          ],
        ),
      )),
    );
  }
}
