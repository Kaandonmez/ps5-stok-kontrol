//make a ps5 amazon stock checker flutter app
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

//hex color code 006FCD

Color stockColor = Colors.red;
Color stockColorx = Colors.red;
Color stockColorpsGenelVatan = Colors.red;
Color stockColorpsGenelMediaMarkt = Colors.red;
Color stockColordualsenseVatanSiyah = Colors.red;
Color stockColordualsenseMediaMarktKirmizi = Colors.red;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PS5 Stock Checker',
      theme: ThemeData(
        //hex color code 006FCD

        colorScheme: ColorScheme.fromSwatch().copyWith(
          // or from RGB

          primary: const Color(0xff006FCD),
          //secondary: const Color(0xFFFFFFFF),
        ),
      ),
      home: MyHomePage(title: 'PS5 Stock Checker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _stock = 'Kontrol Ediliyor';
  String _stockx = 'Kontrol Ediliyor';
  String _stockpsGenelVatan = 'Kontrol Ediliyor';
  String _stockpsGenelMediaMarkt = 'Kontrol Ediliyor';
  String _stockdualsenseVatanSiyah = 'Kontrol Ediliyor';
  String _stockdualsenseMediaMarktKirmizi = 'Kontrol Ediliyor';

  Future<void> _checkStock() async {
    var url = Uri.parse(
        'https://www.vatanbilgisayar.com/sony-playstation-5-oyun-konsolu-ve-hfw-oyunu.html');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = response.body;
      if (body.contains('ÇOK YAKINDA') || body.contains('Tükendi')) {
        setState(() {
          _stock = 'Stok yok';
          stockColor = Colors.red;
        });
      } else {
        setState(() {
          _stock = 'Stokta olabilir!';
          stockColor = Colors.green;
        });
      }
    } else {
      setState(() {
        _stock = 'Yeniden Deneyin';
        stockColor = Colors.orange;
      });
    }
  }

  Future<void> _checkStockXbox() async {
    var url =
        Uri.parse('https://www.vatanbilgisayar.com/oyun-konsollari-xbox/');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = response.body;
      //RegExp exp = new RegExp('XBOX modellerinde 0 adet ürün');
      if (body.contains('XBOX modellerinde 0 adet ürün')) {
        setState(() {
          _stockx = 'Stok yok';
          stockColorx = Colors.red;
        });
      } else {
        setState(() {
          _stockx = 'Stokta olabilir !';
          stockColorx = Colors.green;
        });
      }
    } else {
      setState(() {
        _stockx = 'Error';
        stockColorx = Colors.orange;
      });
    }
  }

  Future<void> _checkStockPSVatan() async {
    var url = Uri.parse('https://www.vatanbilgisayar.com/playstation/');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = response.body;
      //RegExp exp = new RegExp('XBOX modellerinde 0 adet ürün');
      if (body.contains('UYGUN ÜRÜN BULUNAMADI.')) {
        setState(() {
          _stockpsGenelVatan = 'Stok yok';
          stockColorpsGenelVatan = Colors.red;
        });
      } else {
        setState(() {
          _stockpsGenelVatan = 'Stokta olabilir !';
          stockColorpsGenelVatan = Colors.green;
        });
      }
    } else {
      setState(() {
        _stockpsGenelVatan = 'Error';
        stockColorpsGenelVatan = Colors.orange;
      });
    }
  }

  Future<void> _checkStockPSMediaMarkt() async {
    var url = Uri.parse(
        'https://www.mediamarkt.com.tr/tr/category/_playstation-5-799012.html');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = response.body;
      //RegExp exp = new RegExp('XBOX modellerinde 0 adet ürün');
      if (body.contains('<h1>Playstation 5 <em>(0)</em></h1>')) {
        setState(() {
          _stockpsGenelMediaMarkt = 'Stok yok';
          stockColorpsGenelMediaMarkt = Colors.red;
        });
      } else {
        setState(() {
          _stockpsGenelMediaMarkt = 'Stokta olabilir !';
          stockColorpsGenelMediaMarkt = Colors.green;
        });
      }
    } else {
      setState(() {
        _stockpsGenelMediaMarkt = 'Error';
        stockColorpsGenelMediaMarkt = Colors.orange;
      });
    }
  }

  Future<void> _checkStockDualsenseVatanSiyah() async {
    var url = Uri.parse(
        'https://www.vatanbilgisayar.com/sony-ps5-dualsense-kablosuz-kontrol-cihazi-siyah.html');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = response.body;
      //RegExp exp = new RegExp('XBOX modellerinde 0 adet ürün');
      if (body.contains('Tükendi')) {
        setState(() {
          _stockdualsenseVatanSiyah = 'Stok yok';
          stockColordualsenseVatanSiyah = Colors.red;
        });
      } else {
        setState(() {
          _stockdualsenseVatanSiyah = 'Stokta olabilir !';
          stockColordualsenseVatanSiyah = Colors.green;
        });
      }
    } else {
      setState(() {
        _stockdualsenseVatanSiyah = 'Error';
        stockColordualsenseVatanSiyah = Colors.orange;
      });
    }
  }

  Future<void> _checkStockDualsenseMediaMarktKirmizi() async {
    var url = Uri.parse(
        'https://www.mediamarkt.com.tr/tr/product/_sony-dualsense-wireless-controller-oyun-kolu-k%C4%B1rm%C4%B1z%C4%B1-1216107.html');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = response.body;
      //RegExp exp = new RegExp('XBOX modellerinde 0 adet ürün');
      if (body.contains('Ürün Tükendi')) {
        setState(() {
          _stockdualsenseMediaMarktKirmizi = 'Stok yok';
          stockColordualsenseMediaMarktKirmizi = Colors.red;
        });
      } else {
        setState(() {
          _stockdualsenseMediaMarktKirmizi = 'Stokta olabilir !';
          stockColordualsenseMediaMarktKirmizi = Colors.green;
        });
      }
    } else {
      setState(() {
        _stockdualsenseMediaMarktKirmizi = 'Error';
        stockColordualsenseMediaMarktKirmizi = Colors.orange;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _checkStock();
    _checkStockXbox();
    _checkStockPSVatan();
    _checkStockPSMediaMarkt();
    _checkStockDualsenseVatanSiyah();
    _checkStockDualsenseMediaMarktKirmizi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () {
              String url =
                  'https://www.vatanbilgisayar.com/sony-playstation-5-oyun-konsolu-ve-hfw-oyunu.html';

              launch(url.toString(), forceWebView: false);
            },
            child: Row(
              children: <Widget>[
                Text(
                  'PS5 CD\'li Bundle Vatan:  ',
                  style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff006FCD),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '$_stock',
                  style: TextStyle(
                      fontSize: 15,
                      color: stockColor,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              String url =
                  'https://www.vatanbilgisayar.com/oyun-konsollari-xbox/';

              launch(url.toString(), forceWebView: false);
            },
            child: Row(
              children: <Widget>[
                Text(
                  'Xbox Vatan:  ',
                  style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff006FCD),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '$_stockx',
                  style: TextStyle(
                      fontSize: 15,
                      color: stockColorx,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              String url = 'https://www.vatanbilgisayar.com/playstation/';

              launch(url.toString(), forceWebView: false);
            },
            child: Row(
              children: <Widget>[
                Text(
                  'PS5 Vatan Genel Stok :  ',
                  style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff006FCD),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '$_stockpsGenelVatan',
                  style: TextStyle(
                      fontSize: 15,
                      color: stockColorpsGenelVatan,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              String url =
                  'https://www.mediamarkt.com.tr/tr/category/_playstation-5-799012.html';

              launch(url.toString(), forceWebView: false);
            },
            child: Row(
              children: <Widget>[
                Text(
                  'PS5 MediaMarkt Genel Stok :  ',
                  style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff006FCD),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '$_stockpsGenelMediaMarkt',
                  style: TextStyle(
                      fontSize: 15,
                      color: stockColorpsGenelMediaMarkt,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              String url =
                  'https://www.vatanbilgisayar.com/sony-ps5-dualsense-kablosuz-kontrol-cihazi-siyah.html';

              launch(url.toString(), forceWebView: false);
            },
            child: Row(
              children: <Widget>[
                Text(
                  'Dualsense Siyah Vatan :  ',
                  style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff006FCD),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '$_stockdualsenseVatanSiyah',
                  style: TextStyle(
                      fontSize: 15,
                      color: stockColordualsenseVatanSiyah,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              String url =
                  'https://www.mediamarkt.com.tr/tr/product/_sony-dualsense-wireless-controller-oyun-kolu-k%C4%B1rm%C4%B1z%C4%B1-1216107.html';

              launch(url.toString(), forceWebView: false);
            },
            child: Row(
              children: <Widget>[
                Text(
                  'Dualsense Kırmızı MediaMarkt :  ',
                  style: TextStyle(
                      fontSize: 15,
                      color: Color(0xff006FCD),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '$_stockdualsenseMediaMarktKirmizi',
                  style: TextStyle(
                      fontSize: 15,
                      color: stockColordualsenseMediaMarktKirmizi,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // _checkStock();
          // _checkStockXbox();
          // _checkStockPSVatan();
          // _checkStockPSMediaMarkt();
          //url_laucher lauch this url: https://www.google.com.tr/

          //String url = 'https://www.google.com.tr/';

          //launch(url.toString(), forceWebView: false);

          setState(() {
            _stock = 'Kontrol Ediliyor';
            stockColor = Colors.orange;
            _stockx = 'Kontrol Ediliyor';
            stockColorx = Colors.orange;
            _stockpsGenelVatan = 'Kontrol Ediliyor';
            stockColorpsGenelVatan = Colors.orange;
            _stockpsGenelMediaMarkt = 'Kontrol Ediliyor';
            stockColorpsGenelMediaMarkt = Colors.orange;
            _stockdualsenseVatanSiyah = 'Kontrol Ediliyor';
            stockColordualsenseVatanSiyah = Colors.orange;
            _stockdualsenseMediaMarktKirmizi = 'Kontrol Ediliyor';
            stockColordualsenseMediaMarktKirmizi = Colors.orange;

            _checkStock();
            _checkStockXbox();
            _checkStockPSVatan();
            _checkStockPSMediaMarkt();
            _checkStockDualsenseVatanSiyah();
            _checkStockDualsenseMediaMarktKirmizi();
          });
        },
        tooltip: 'Check Stock',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
