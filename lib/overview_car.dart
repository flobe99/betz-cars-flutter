import 'dart:ffi';
import 'dart:math';

import 'package:betz_cars/addFuelData.dart';
import 'package:betz_cars/models/Car.dart';
import 'package:betz_cars/models/Fuel.dart';
import 'package:betz_cars/models/getCars.dart';
import 'package:betz_cars/overview_car_fuel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OverviewCar extends StatefulWidget {
  const OverviewCar({
    super.key,
    this.carList,
  });

  final Car? carList;
  @override
  State<OverviewCar> createState() => _OverviewCar();
}

class _OverviewCar extends State<OverviewCar> {
  /*
  @override
  void initState() {
    super.initState();
  }*/

  var number_thousand_separator = NumberFormat('###,###', 'de_DE');

  @override
  Widget build(BuildContext context) {
    var carImage;

    var carName = widget.carList!.modell;

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

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.carList!.producer + " " + widget.carList!.modell),
        backgroundColor: Color.fromRGBO(16, 78, 138, 1),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "overview_car",
        backgroundColor: Color.fromRGBO(16, 78, 138, 1),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddFuelData(
                      carList: widget.carList!,
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
        child: Icon(Icons.local_gas_station),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
              child: Column(
            children: [
              Image.asset(carImage, cacheHeight: 300),
              Text(
                widget.carList!.modell,
                style: TextStyle(fontSize: 40, color: Colors.grey),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40.0),
                    topLeft: Radius.circular(40.0),
                  ),
                ),
                padding: const EdgeInsets.only(top: 40, bottom: 250),
                margin: const EdgeInsets.only(top: 20, left: 20.0, right: 15.0),
                child: Column(
                  children: [
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
                                "${number_thousand_separator.format(widget.carList!.kilometers).toString()} km",
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
                                "${widget.carList!.customer_service.toString()}",
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
                                "2024-01-16",
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
                                "${number_thousand_separator.format(widget.carList!.buying_price).toString()} €",
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
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OverviewCarFuel(
                                      carList: widget.carList!,
                                    )),
                          );
                        },
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              Color.fromRGBO(16, 78, 138, 1)),
                        ),
                        child: Text("gas station"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
