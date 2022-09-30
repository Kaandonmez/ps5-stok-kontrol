import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'config.dart';
import 'package:flutter/services.dart';
import 'denc.dart';
import 'dart:core';
import 'package:vibration/vibration.dart';

DateTime? testTime;

int toplamStok = 0;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(MyApp()));
  runApp(MyApp());
}

//press button every 5 seconds
//https://stackoverflow.com/questions/56474601/how-to-make-a-button-press-every-5-seconds-in-flutter

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PS5 Stok Kontrol',
      theme: ThemeData(
        //hex color code 006FCD

        colorScheme: ColorScheme.fromSwatch().copyWith(
          // or from RGB

          primary: const Color(0xff006FCD),
          //secondary: const Color(0xFFFFFFFF),
        ),
      ),
      home: MyHomePage(title: 'PS5 Stok Kontrol'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.title});

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
  String _stockpsDigitalMediaMarkt = 'Kontrol Ediliyor';
  String _stockdualsenseVatanBeyaz = 'Kontrol Ediliyor';
  String _stockdualsenseVatanPembe = 'Kontrol Ediliyor';
  String _stockdualsenseVatanMavi = 'Kontrol Ediliyor';
  String _stockdualsenseVatanMor = 'Kontrol Ediliyor';
  String _stockdualsenseVatanKirmizi = 'Kontrol Ediliyor';
  String _stockdualsenseVatanSarj = 'Kontrol Ediliyor';
  String _stockpsGenelOverGame = 'Kontrol Ediliyor';

  Future<DateTime> sifreCoz(String decrypted1) async {
    String a = await decryptMyMessage(decrypted1);
    DateTime b = DateTime.parse(a);
    //print(b);

    setState(() {
      testTime = b;
    });
    //print(a);
    return b;
  }

  Future<void> _checkStock() async {
    var url = Uri.parse(vatanCDBundle);
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
          toplamStok++;
          Vibration.vibrate(duration: 50, amplitude: 128);
        });
      }
    } else {
      setState(() {
        _stock = 'Yeniden Deneyin';
        stockColor = Colors.orange;
        toplamStok++;
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
      if (body.contains('UYGUN ÜRÜN BULUNAMADI.')) {
        setState(() {
          _stockx = 'Stok yok';
          stockColorx = Colors.red;
        });
      } else {
        setState(() {
          _stockx = 'Stokta olabilir !';
          stockColorx = Colors.green;
          //toplamStok++;
          //vibrate
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
    var url = Uri.parse(vatanGenelPS);
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
          toplamStok++;
          Vibration.vibrate(duration: 50, amplitude: 128);
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
          toplamStok++;
          Vibration.vibrate(duration: 50, amplitude: 128);
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
          toplamStok++;
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
          toplamStok++;
        });
      }
    } else {
      setState(() {
        _stockdualsenseMediaMarktKirmizi = 'Error';
        stockColordualsenseMediaMarktKirmizi = Colors.orange;
      });
    }
  }

  Future<void> _checkStockpsDigitalMediaMarkt() async {
    var url = Uri.parse(
        'https://www.mediamarkt.com.tr/tr/product/_sony-playstation-5-oyun-konsolu-beyaz-1212362.html');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = response.body;
      //RegExp exp = new RegExp('XBOX modellerinde 0 adet ürün');
      if (body.contains('Ürün Tükendi')) {
        setState(() {
          _stockpsDigitalMediaMarkt = 'Stok yok';
          stockColorpsDigitalMediaMarkt = Colors.red;
        });
      } else {
        setState(() {
          _stockpsDigitalMediaMarkt = 'Stokta olabilir !';
          stockColorpsDigitalMediaMarkt = Colors.green;
          toplamStok++;
          Vibration.vibrate(duration: 50, amplitude: 128);
        });
      }
    } else {
      setState(() {
        _stockpsDigitalMediaMarkt = 'Error';
        stockColorpsDigitalMediaMarkt = Colors.orange;
      });
    }
  }

  Future<void> _checkStockdualsenseVatanBeyaz() async {
    var url = Uri.parse(
        'https://www.vatanbilgisayar.com/sony-ps5-dualsense-kablosuz-kontrol-cihazi.html');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = response.body;
      //RegExp exp = new RegExp('XBOX modellerinde 0 adet ürün');
      if (body.contains('Tükendi')) {
        setState(() {
          _stockdualsenseVatanBeyaz = 'Stok yok';
          stockColordualsenseVatanBeyaz = Colors.red;
        });
      } else {
        setState(() {
          _stockdualsenseVatanBeyaz = 'Stokta olabilir !';
          stockColordualsenseVatanBeyaz = Colors.green;
          toplamStok++;
        });
      }
    } else {
      setState(() {
        _stockdualsenseVatanBeyaz = 'Error';
        stockColordualsenseVatanBeyaz = Colors.orange;
      });
    }
  }

  Future<void> _checkStockdualsenseVatanPembe() async {
    var url = Uri.parse(
        'https://www.vatanbilgisayar.com/sony-ps5-dualsense-kablosuz-kontrol-cihazi-nova-pink.html');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = response.body;
      //RegExp exp = new RegExp('XBOX modellerinde 0 adet ürün');
      if (body.contains('Tükendi')) {
        setState(() {
          _stockdualsenseVatanPembe = 'Stok yok';
          stockColordualsenseVatanPembe = Colors.red;
        });
      } else {
        setState(() {
          _stockdualsenseVatanPembe = 'Stokta olabilir !';
          stockColordualsenseVatanPembe = Colors.green;
          toplamStok++;
        });
      }
    } else {
      setState(() {
        _stockdualsenseVatanPembe = 'Error';
        stockColordualsenseVatanPembe = Colors.orange;
      });
    }
  }

  Future<void> _checkStockdualsenseVatanMavi() async {
    var url = Uri.parse(
        'https://www.vatanbilgisayar.com/sony-ps5-dualsense-kablosuz-kontrol-cihazi-starlight-blue.html');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = response.body;
      //RegExp exp = new RegExp('XBOX modellerinde 0 adet ürün');
      if (body.contains('Tükendi')) {
        setState(() {
          _stockdualsenseVatanMavi = 'Stok yok';
          stockColordualsenseVatanMavi = Colors.red;
        });
      } else {
        setState(() {
          _stockdualsenseVatanMavi = 'Stokta olabilir !';
          stockColordualsenseVatanMavi = Colors.green;
          toplamStok++;
        });
      }
    } else {
      setState(() {
        _stockdualsenseVatanMavi = 'Error';
        stockColordualsenseVatanMavi = Colors.orange;
      });
    }
  }

  Future<void> _checkStockdualsenseVatanMor() async {
    var url = Uri.parse(
        'https://www.vatanbilgisayar.com/sony-ps5-dualsense-kablosuz-kontrol-cihazi-galactic-purple.html');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = response.body;
      //RegExp exp = new RegExp('XBOX modellerinde 0 adet ürün');
      if (body.contains('Tükendi')) {
        setState(() {
          _stockdualsenseVatanMor = 'Stok yok';
          stockColordualsenseVatanMor = Colors.red;
        });
      } else {
        setState(() {
          _stockdualsenseVatanMor = 'Stokta olabilir !';
          stockColordualsenseVatanMor = Colors.green;
          toplamStok++;
        });
      }
    } else {
      setState(() {
        _stockdualsenseVatanMor = 'Error';
        stockColordualsenseVatanMor = Colors.orange;
      });
    }
  }

  Future<void> _checkStockdualsenseVatanKirmizi() async {
    var url = Uri.parse(
        'https://www.vatanbilgisayar.com/sony-ps5-dualsense-kablosuz-kontrol-cihazi-kirmizi.html');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = response.body;
      //RegExp exp = new RegExp('XBOX modellerinde 0 adet ürün');
      if (body.contains('Tükendi')) {
        setState(() {
          _stockdualsenseVatanKirmizi = 'Stok yok';
          stockColordualsenseVatanKirmizi = Colors.red;
        });
      } else {
        setState(() {
          _stockdualsenseVatanKirmizi = 'Stokta olabilir !';
          stockColordualsenseVatanKirmizi = Colors.green;
          toplamStok++;
        });
      }
    } else {
      setState(() {
        _stockdualsenseVatanKirmizi = 'Error';
        stockColordualsenseVatanKirmizi = Colors.orange;
      });
    }
  }

  Future<void> _checkStockdualsenseVatanSarj() async {
    var url = Uri.parse(
        'https://www.vatanbilgisayar.com/sony-ps5-dualsense-sarj-istasyonu.html');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = response.body;
      //RegExp exp = new RegExp('XBOX modellerinde 0 adet ürün');
      if (body.contains('Tükendi')) {
        setState(() {
          _stockdualsenseVatanSarj = 'Stok yok';
          stockColorDualsenseSarjVatan = Colors.red;
        });
      } else {
        setState(() {
          _stockdualsenseVatanSarj = 'Stokta olabilir !';
          stockColorDualsenseSarjVatan = Colors.green;
          //toplamStok++;
        });
      }
    } else {
      setState(() {
        _stockdualsenseVatanSarj = 'Error';
        stockColorDualsenseSarjVatan = Colors.orange;
      });
    }
  }

  Future<void> _checkStockPSGenelOverGame() async {
    var url = Uri.parse(
        'https://www.overgameweb.com/playstation/playstation-5/playstation5-konsol');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var body = response.body;
      //RegExp exp = new RegExp('XBOX modellerinde 0 adet ürün');
      if (body.contains('<i class="icon-cart-list"></i>') == false) {
        setState(() {
          _stockpsGenelOverGame = 'Stok yok';
          stockColorpsGenelOverGame = Colors.red;
        });
      } else {
        setState(() {
          _stockpsGenelOverGame = 'Stokta olabilir !';
          stockColorpsGenelOverGame = Colors.green;
          toplamStok++;
          Vibration.vibrate(duration: 50, amplitude: 128);
        });
      }
    } else {
      setState(() {
        _stockpsGenelOverGame = 'Error';
        stockColorpsGenelOverGame = Colors.orange;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _date = DateTime.now().toString();
    _checkStock();
    _checkStockXbox();
    _checkStockPSVatan();
    _checkStockPSMediaMarkt();
    _checkStockDualsenseVatanSiyah();
    _checkStockDualsenseMediaMarktKirmizi();
    _checkStockpsDigitalMediaMarkt();
    _checkStockdualsenseVatanBeyaz();
    _checkStockdualsenseVatanPembe();
    _checkStockdualsenseVatanMavi();
    _checkStockdualsenseVatanMor();
    _checkStockdualsenseVatanKirmizi();
    _checkStockdualsenseVatanSarj();
    _checkStockPSGenelOverGame();
  }

  //get current date
  String _date = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(widget.title),
        leading: Column(
          children: [
            Text(
              _date,
              style: const TextStyle(fontSize: 10),
            ),
            Text(
              "God Mode",
              style: const TextStyle(fontSize: 10, color: Colors.yellow),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              const Center(
                child: Text(
                  'Toplam stok: ',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Center(
                child: Text(
                  toplamStok.toString() + "  ",
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: stockColor == Colors.red
                    ? stockColor.withOpacity(0.15)
                    : stockColor.withOpacity(0.27),
              ),
              onPressed: () {
                String url =
                    'https://www.vatanbilgisayar.com/sony-playstation-5-oyun-konsolu-ve-hfw-oyunu.html';

                launch(url.toString(), forceWebView: false);
              },
              child: Row(
                children: <Widget>[
                  const Text(
                    'PS5 CD\'li Bundle Vatan:  ',
                    style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff006FCD),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _stock,
                    style: TextStyle(
                        fontSize: 15,
                        color: stockColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            TextButton(
              //if _stock is equal to 'Stok yok' button color will be red else green
              style: TextButton.styleFrom(
                backgroundColor: stockColorx == Colors.red
                    ? stockColorx.withOpacity(0.15)
                    : stockColorx.withOpacity(0.27),
              ),
              onPressed: () {
                String url =
                    'https://www.vatanbilgisayar.com/oyun-konsollari-xbox/';

                launch(url.toString(), forceWebView: false);
              },
              child: Row(
                children: <Widget>[
                  const Text(
                    'Xbox Vatan:  ',
                    style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff006FCD),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _stockx,
                    style: TextStyle(
                        fontSize: 15,
                        color: stockColorx,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: stockColorpsGenelVatan == Colors.red
                    ? stockColorpsGenelVatan.withOpacity(0.15)
                    : stockColorpsGenelVatan.withOpacity(0.27),
              ),
              onPressed: () {
                String url = 'https://www.vatanbilgisayar.com/playstation/';

                launch(url.toString(), forceWebView: false);
              },
              child: Row(
                children: <Widget>[
                  const Text(
                    'PS5 Genel Stok Vatan :  ',
                    style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff006FCD),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _stockpsGenelVatan,
                    style: TextStyle(
                        fontSize: 15,
                        color: stockColorpsGenelVatan,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: stockColorpsGenelMediaMarkt == Colors.red
                    ? stockColorpsGenelMediaMarkt.withOpacity(0.15)
                    : stockColorpsGenelMediaMarkt.withOpacity(0.27),
              ),
              onPressed: () {
                String url =
                    'https://www.mediamarkt.com.tr/tr/category/_playstation-5-799012.html';

                launch(url.toString(), forceWebView: false);
              },
              child: Row(
                children: <Widget>[
                  const Text(
                    'PS5 Genel Stok MediaMarkt :  ',
                    style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff006FCD),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _stockpsGenelMediaMarkt,
                    style: TextStyle(
                        fontSize: 15,
                        color: stockColorpsGenelMediaMarkt,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: stockColordualsenseVatanBeyaz == Colors.red
                    ? stockColordualsenseVatanBeyaz.withOpacity(0.15)
                    : stockColordualsenseVatanBeyaz.withOpacity(0.27),
              ),
              onPressed: () {
                String url =
                    'https://www.vatanbilgisayar.com/sony-ps5-dualsense-kablosuz-kontrol-cihazi.html';

                launch(url.toString(), forceWebView: false);
              },
              child: Row(
                children: <Widget>[
                  const Text(
                    'Dualsense Beyaz Vatan:  ',
                    style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff006FCD),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _stockdualsenseVatanBeyaz,
                    style: TextStyle(
                        fontSize: 15,
                        color: stockColordualsenseVatanBeyaz,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: stockColordualsenseVatanSiyah == Colors.red
                    ? stockColordualsenseVatanSiyah.withOpacity(0.15)
                    : stockColordualsenseVatanSiyah.withOpacity(0.27),
              ),
              onPressed: () {
                String url =
                    'https://www.vatanbilgisayar.com/sony-ps5-dualsense-kablosuz-kontrol-cihazi-siyah.html';

                launch(url.toString(), forceWebView: false);
              },
              child: Row(
                children: <Widget>[
                  const Text(
                    'Dualsense Siyah Vatan :  ',
                    style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff006FCD),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _stockdualsenseVatanSiyah,
                    style: TextStyle(
                        fontSize: 15,
                        color: stockColordualsenseVatanSiyah,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: stockColordualsenseVatanPembe == Colors.red
                    ? stockColordualsenseVatanPembe.withOpacity(0.15)
                    : stockColordualsenseVatanPembe.withOpacity(0.27),
              ),
              onPressed: () {
                String url =
                    'https://www.vatanbilgisayar.com/sony-ps5-dualsense-kablosuz-kontrol-cihazi-nova-pink.html';

                launch(url.toString(), forceWebView: false);
              },
              child: Row(
                children: <Widget>[
                  const Text(
                    'Dualsense Pembe Vatan :  ',
                    style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff006FCD),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _stockdualsenseVatanPembe,
                    style: TextStyle(
                        fontSize: 15,
                        color: stockColordualsenseVatanPembe,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: stockColordualsenseVatanMavi == Colors.red
                    ? stockColordualsenseVatanMavi.withOpacity(0.15)
                    : stockColordualsenseVatanMavi.withOpacity(0.27),
              ),
              onPressed: () {
                String url =
                    'https://www.vatanbilgisayar.com/sony-ps5-dualsense-kablosuz-kontrol-cihazi-starlight-blue.html';

                launch(url.toString(), forceWebView: false);
              },
              child: Row(
                children: <Widget>[
                  const Text(
                    'Dualsense Mavi Vatan :  ',
                    style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff006FCD),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _stockdualsenseVatanMavi,
                    style: TextStyle(
                        fontSize: 15,
                        color: stockColordualsenseVatanMavi,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: stockColordualsenseVatanMor == Colors.red
                    ? stockColordualsenseVatanMor.withOpacity(0.15)
                    : stockColordualsenseVatanMor.withOpacity(0.27),
              ),
              onPressed: () {
                String url =
                    'https://www.vatanbilgisayar.com/sony-ps5-dualsense-kablosuz-kontrol-cihazi-galactic-purple.html';

                launch(url.toString(), forceWebView: false);
              },
              child: Row(
                children: <Widget>[
                  const Text(
                    'Dualsense Mor Vatan :  ',
                    style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff006FCD),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _stockdualsenseVatanMor,
                    style: TextStyle(
                        fontSize: 15,
                        color: stockColordualsenseVatanMor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: stockColordualsenseVatanKirmizi == Colors.red
                    ? stockColordualsenseVatanKirmizi.withOpacity(0.15)
                    : stockColordualsenseVatanKirmizi.withOpacity(0.27),
              ),
              onPressed: () {
                String url =
                    'https://www.vatanbilgisayar.com/sony-ps5-dualsense-kablosuz-kontrol-cihazi-kirmizi.html';

                launch(url.toString(), forceWebView: false);
              },
              child: Row(
                children: <Widget>[
                  const Text(
                    'Dualsense Kırmızı Vatan :  ',
                    style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff006FCD),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _stockdualsenseVatanKirmizi,
                    style: TextStyle(
                        fontSize: 15,
                        color: stockColordualsenseVatanKirmizi,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: stockColordualsenseMediaMarktKirmizi ==
                        Colors.red
                    ? stockColordualsenseMediaMarktKirmizi.withOpacity(0.15)
                    : stockColordualsenseMediaMarktKirmizi.withOpacity(0.27),
              ),
              onPressed: () {
                String url =
                    'https://www.mediamarkt.com.tr/tr/product/_sony-dualsense-wireless-controller-oyun-kolu-k%C4%B1rm%C4%B1z%C4%B1-1216107.html';

                launch(url.toString(), forceWebView: false);
              },
              child: Row(
                children: <Widget>[
                  const Text(
                    'Dualsense Kırmızı MediaMarkt :  ',
                    style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff006FCD),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _stockdualsenseMediaMarktKirmizi,
                    style: TextStyle(
                        fontSize: 15,
                        color: stockColordualsenseMediaMarktKirmizi,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: stockColorpsDigitalMediaMarkt == Colors.red
                    ? stockColorpsDigitalMediaMarkt.withOpacity(0.15)
                    : stockColorpsDigitalMediaMarkt.withOpacity(0.27),
              ),
              onPressed: () {
                String url =
                    'https://www.mediamarkt.com.tr/tr/product/_sony-playstation-5-oyun-konsolu-beyaz-1212362.html';

                launch(url.toString(), forceWebView: false);
              },
              child: Row(
                children: <Widget>[
                  const Text(
                    'PS5 Digital MediaMarkt :  ',
                    style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff006FCD),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _stockpsDigitalMediaMarkt,
                    style: TextStyle(
                        fontSize: 15,
                        color: stockColorpsDigitalMediaMarkt,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: stockColorDualsenseSarjVatan == Colors.red
                    ? stockColorDualsenseSarjVatan.withOpacity(0.15)
                    : stockColorDualsenseSarjVatan.withOpacity(0.27),
              ),
              onPressed: () {
                String url =
                    'https://www.vatanbilgisayar.com/sony-ps5-dualsense-sarj-istasyonu.html';

                launch(url.toString(), forceWebView: false);
              },
              child: Row(
                children: <Widget>[
                  const Text(
                    'Dualsense Şarj İstasyonu Vatan :  ',
                    style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff006FCD),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _stockdualsenseVatanSarj,
                    style: TextStyle(
                        fontSize: 15,
                        color: stockColorDualsenseSarjVatan,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: stockColorpsGenelOverGame == Colors.red
                    ? stockColorpsGenelOverGame.withOpacity(0.15)
                    : stockColorpsGenelOverGame.withOpacity(0.27),
              ),
              onPressed: () {
                String url =
                    'https://www.overgameweb.com/playstation/playstation-5/playstation5-konsol';

                launch(url.toString(), forceWebView: false);
              },
              child: Row(
                children: <Widget>[
                  const Text(
                    'PS Genel OverGame :  ',
                    style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff006FCD),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _stockpsGenelOverGame,
                    style: TextStyle(
                        fontSize: 15,
                        color: stockColorpsGenelOverGame,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            //writeable text field
            Container(
              margin: const EdgeInsets.all(10),
              child: TextField(
                readOnly: isTextfieldWR,
                onChanged: (value) {
                  setState(() {
                    //get now time

                    keyValue = value;

                    //if keyvalue is exactly 388 characters
                    if (keyValue.length == 388) {
                      makeCalculation = true;
                      sifreCoz(keyValue);
                    }
                  });
                },
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText:
                      'Yenileme ikonu yeşil olduysa doğru key değeri girdiniz.',
                  labelStyle: const TextStyle(
                      fontSize: 15,
                      color: Colors.lime,
                      fontWeight: FontWeight.bold),
                  suffixText: keyValueStatus,
                  suffixStyle: TextStyle(color: refreshIconColor),
                  helperText:
                      'Key değeri benzersizdir ve sadece\n geliştirici tarafından verilir.',
                  helperStyle: const TextStyle(color: Colors.white),
                ),
              ),
            ),

            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              onPressed: () {
                setState(() {
                  var now = DateTime.now();
                  if (makeCalculation && testTime!.isAfter(now)) {
                    //disable button
                    isKeyValid = true;
                    keyValueStatus = 'Key Geçerli!';
                    refreshIconColor = Colors.green;
                    isTextfieldWR = true;
                  } else {
                    //enable button
                    isKeyValid = false;
                    refreshIconColor = Colors.red;
                    keyValueStatus = 'Hatalı key değeri';
                  }
                });
              },
              child: const Text(
                'Key\'i test et',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Divider(
              color: Colors.deepOrange,
              height: 20,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),

            TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.deepOrange[700]!),
                ),
                onPressed: () {
                  String url =
                      'https://forum.donanimhaber.com/playstation-5-stok-takip-ve-sohbet--152062533';

                  launch(url.toString(), forceWebView: false);
                },
                child: const Text(
                  'Donanım Haber Stok/Sohbet Konusuna Git',
                  style: TextStyle(color: Colors.white),
                )),

            const SizedBox(height: 10),

            TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.deepOrange[700]!),
                ),
                onPressed: () {
                  String url =
                      'https://forum.donanimhaber.com/playstation-5-stok-takip-ve-bildirim--147894746';

                  launch(url.toString(), forceWebView: false);
                },
                child: const Text(
                  'Donanım Haber Stok/Bildirim Konusuna Git',
                  style: TextStyle(color: Colors.white),
                )),
            Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.red[900]!),
                ),
                onPressed: () {
                  String url =
                      'https://www.arcelik.com.tr/oyun-konsolu/sony-playstation-5-dijital-surum-hobi-oyun';

                  launch(url.toString(), forceWebView: false);
                },
                child: Row(
                  children: const <Widget>[
                    Text(
                      'PS5 Digital Arçelik Sayfası',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                  right: 10, left: 10, top: 10, bottom: 20),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue[700]!),
                ),
                onPressed: () {
                  String url =
                      'https://www.beko.com.tr/oyun-konsolu/sony-playstation-5-dijital-surum-hobi-oyun';

                  launch(url.toString(), forceWebView: false);
                },
                child: Row(
                  children: const <Widget>[
                    Text(
                      'PS5 Digital Beko Sayfası',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('refresh'),
        backgroundColor: refreshIconColor,
        onPressed: () async {
          setState(() {
            toplamStok = 0;
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
            _stockpsDigitalMediaMarkt = 'Kontrol Ediliyor';
            stockColorpsDigitalMediaMarkt = Colors.orange;
            _stockdualsenseVatanBeyaz = 'Kontrol Ediliyor';
            stockColordualsenseVatanBeyaz = Colors.orange;
            _stockdualsenseVatanPembe = 'Kontrol Ediliyor';
            stockColordualsenseVatanPembe = Colors.orange;
            _stockdualsenseVatanMavi = 'Kontrol Ediliyor';
            stockColordualsenseVatanMavi = Colors.orange;
            _stockdualsenseVatanMor = 'Kontrol Ediliyor';
            stockColordualsenseVatanMor = Colors.orange;
            _stockdualsenseVatanKirmizi = 'Kontrol Ediliyor';
            stockColordualsenseVatanKirmizi = Colors.orange;
            _stockdualsenseVatanSarj = 'Kontrol Ediliyor';
            stockColorDualsenseSarjVatan = Colors.orange;
            _stockpsGenelOverGame = 'Kontrol Ediliyor';
            stockColorpsGenelOverGame = Colors.orange;

            _checkStock();
            _checkStockXbox();
            _checkStockPSVatan();
            _checkStockPSMediaMarkt();
            _checkStockDualsenseVatanSiyah();
            _checkStockDualsenseMediaMarktKirmizi();
            _checkStockpsDigitalMediaMarkt();
            _checkStockdualsenseVatanBeyaz();
            _checkStockdualsenseVatanPembe();
            _checkStockdualsenseVatanMavi();
            _checkStockdualsenseVatanMor();
            _checkStockdualsenseVatanKirmizi();
            _checkStockdualsenseVatanSarj();
            _checkStockPSGenelOverGame();

            _date = DateTime.now().toString();

            //print(_date);
          });
        },
        tooltip: 'Check Stock',
        child: const Icon(
          Icons.refresh_rounded,
          size: 50,
        ),
      ),
    );
  }
}
