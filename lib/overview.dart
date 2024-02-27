import 'dart:ffi';
import 'package:betz_cars/addFuelData.dart';
import 'package:betz_cars/models/Fuel.dart';
import 'package:betz_cars/overview_car_fuel.dart';
import 'package:betz_cars/overview_car_repair.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:betz_cars/models/Car.dart';
import 'package:betz_cars/controller/getCars.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Overview extends StatefulWidget {
  const Overview({Key? key}) : super(key: key);

  @override
  _Overview createState() => _Overview();
}

class _Overview extends State<Overview> {
  late List<Car>? _carList = [];

  var number_thousand_separator = NumberFormat('###,###', 'de_DE');

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    do {
      _carList = (await CarApi().getCars())!;
    } while (_carList?.isEmpty == true);

    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd.MM.yyyy');

    //return _carList!.isEmpty ? Text("test") : Text("data");

    return Scaffold(
      appBar: AppBar(
        title: const Text('Betz Cars Fleet'),
        backgroundColor: Color.fromRGBO(16, 78, 138, 1),
        actions: [
          PopupMenuItem(
            onTap: () {
              _getData();
            },
            child: Icon(Icons.refresh),
          ),
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text("My Account"),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: Text("Settings"),
                  onTap: () {},
                ),
                PopupMenuItem<int>(
                  value: 2,
                  child: Text("Logout"),
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove("username");
                    //Navigator.pushNamed(context, '/login');
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/signin', ModalRoute.withName('/signin'));
                  },
                ),
              ];
            },
          ),
        ],
      ),
      body: Container(
        child: Swiper(
          itemCount: _carList!.length,
          loop: true,
          itemBuilder: (BuildContext context, int index) {
            var carName = _carList![index].modell;
            var carImage;
            if (carName == "Golf 7") {
              carImage = "img/golf7.png";
            } else if (carName == "T-Roc") {
              carImage = "img/t-roc.png";
            } else if (carName == "Polo") {
              carImage = "img/polo.png";
            } else {
              // Handle the case when carName doesn't match any of the specified values
              carImage = "img/default.png";
            }
            return SingleChildScrollView(
              child: Container(
                //color: Colors.red,
                margin: EdgeInsets.all(30),
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      child: Image.asset(carImage),
                    ),
                    Text(
                      _carList![index].modell,
                      style: TextStyle(fontSize: 40, color: Colors.grey),
                    ),
                    Table(
                      //border: TableBorder.all(),
                      children: [
                        TableRow(children: [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Container(
                              margin: const EdgeInsets.only(right: 15.0),
                              alignment: Alignment.topRight,
                              child: Text(
                                "kilometers:",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Container(
                              child: Text(
                                "${number_thousand_separator.format(_carList![index].kilometers).toString()} km",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Container(
                              margin: const EdgeInsets.only(right: 15.0),
                              alignment: Alignment.topRight,
                              child: Text(
                                "service:",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Container(
                              child: Text(
                                "${formatter.format(_carList![index].customer_service)}",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Container(
                              margin: const EdgeInsets.only(right: 15.0),
                              alignment: Alignment.topRight,
                              child: Text(
                                "consumption:",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Container(
                              child: Text(
                                "4,6 L",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Container(
                              margin: const EdgeInsets.only(right: 15.0),
                              alignment: Alignment.topRight,
                              child: Text(
                                "last-fuel:",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Container(
                              child: Text(
                                formatter.format(_carList![index].last_fuel),
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Container(
                              margin: const EdgeInsets.only(right: 15.0),
                              alignment: Alignment.topRight,
                              child: Text(
                                "costs:",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          TableCell(
                            verticalAlignment:
                                TableCellVerticalAlignment.middle,
                            child: Container(
                              child: Text(
                                "${number_thousand_separator.format(_carList![index].buying_price).toString()} €",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ]),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      width: 200,
                      //color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FloatingActionButton(
                            heroTag: "btn1",
                            backgroundColor: Colors.red,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OverviewCarRepair(
                                          carList: _carList![index],
                                        )),
                              );
                            },
                            child: FaIcon(FontAwesomeIcons.screwdriverWrench),
                          ),
                          const Spacer(),
                          FloatingActionButton(
                            heroTag: "btn2",
                            backgroundColor: Colors.orange,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OverviewCarFuel(
                                          carList: _carList![index],
                                        )),
                              );
                            },
                            child: Icon(Icons.local_gas_station),
                          ),
                          const Spacer(),
                          FloatingActionButton(
                            heroTag: "btn3",
                            backgroundColor: Colors.green,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddFuelData(
                                          carList: _carList,
                                          index: index,
                                          fuelList: Fuel(
                                              id: "-1",
                                              carId: "-1",
                                              kilometer: 0,
                                              price_liter: 0,
                                              amount_liter: 0,
                                              price: 0,
                                              date: DateTime.now()),
                                        )),
                              );
                            },
                            child: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          //pagination: SwiperPagination(),
          control: SwiperControl(),
        ),
      ),
    );
  }
}
