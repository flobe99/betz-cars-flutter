import 'dart:ffi';

import 'package:betz_cars/addFuelData.dart';
import 'package:betz_cars/models/Car.dart';
import 'package:betz_cars/models/Fuel.dart';
import 'package:betz_cars/models/getFuel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class OverviewCarFuel extends StatefulWidget {
  const OverviewCarFuel({
    super.key,
    this.carList,
  });
  final Car? carList;
  @override
  _OverviewCarFuel createState() => _OverviewCarFuel();
}

class _OverviewCarFuel extends State<OverviewCarFuel> {
  late List<Fuel>? _fuelList = [];

  var number_thousand_separator = NumberFormat('###,###', 'de_DE');

  @override
  void initState() {
    super.initState();
    _getFuelData(widget.carList?.id);
  }

  void _getFuelData(carId) async {
    _fuelList = [];
    print("_getFuelData: " + carId);
    _fuelList = (await FuelApi().getCarFuels(carId))!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  void _deleteFuelData(carId) async {
    await FuelApi().deleteFuel(carId);
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  Offset _tapPosition = Offset.zero;
  void _getTapPosition(TapDownDetails details) {
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    setState(() {
      _tapPosition = referenceBox.globalToLocal(details.globalPosition);
    });
  }

  void _showContextMenu(BuildContext context, Fuel fuel) async {
    final RenderObject? overlay =
        Overlay.of(context)?.context.findRenderObject();

    final result = await showMenu(
        context: context,
        // Show the context menu at the tap location
        position: RelativeRect.fromRect(
            Rect.fromLTWH(_tapPosition.dx, _tapPosition.dy, 30, 30),
            Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width,
                overlay.paintBounds.size.height)),

        // set a list of choices for the context menu
        items: [
          const PopupMenuItem(
            value: 'favorites',
            child: Icon(
              Icons.favorite,
              color: Colors.orange,
            ),
          ),
          const PopupMenuItem(
            value: 'delete',
            child: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
          const PopupMenuItem(
            value: 'edit',
            child: Icon(
              Icons.edit,
              color: Colors.green,
            ), //Text('Edit fuel'),
          ),
        ]);

    // Implement the logic for each choice here
    switch (result) {
      case 'favorites':
        debugPrint('Add To Favorites');
        break;
      case 'delete':
        _deleteFuelData(fuel.id);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Fuel data deleted')),
        );

        debugPrint('Delete fuel');
        break;
      case 'edit':
        print('fuelId: ' + fuel.id.toString());
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddFuelData(
                    carList: widget.carList,
                    fuelList: fuel,
                  )),
        );
        debugPrint('Edit fuel');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd.MM.yyyy');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.carList!.modell.toString() + ' Fuels'),
        backgroundColor: Color.fromRGBO(16, 78, 138, 1),
      ),
      body: _fuelList == null || _fuelList!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  _getFuelData(widget.carList?.id);
                });
              },
              child: ListView.builder(
                  itemCount: _fuelList!.length,
                  //itemExtent: 100.0,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTapDown: (details) => _getTapPosition(details),
                      onLongPress: () async {
                        _showContextMenu(context, _fuelList![index]);
                      },
                      child: ExpansionTile(
                        //tileColor: Colors.grey[200],
                        shape: Border(bottom: BorderSide()),
                        leading: Icon(Icons.local_gas_station),
                        title: Text(
                            //number_thousand_separator.format(_carList![index].kilometers).toString()
                            number_thousand_separator
                                    .format(_fuelList![index].kilometer)
                                    .toString() +
                                " km"),
                        subtitle:
                            Text(formatter.format(_fuelList![index].date)),
                        trailing: Text(
                            _fuelList![index].price.toStringAsFixed(2) + " €"),
                        children: [
                          Table(
                            children: [
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                      alignment: Alignment.topRight,
                                      margin:
                                          const EdgeInsets.only(right: 15.0),
                                      child: Text(
                                        "Kilometer:",
                                        style: TextStyle(
                                          //fontSize: 25.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      child: Text(
                                        number_thousand_separator
                                                .format(
                                                    _fuelList![index].kilometer)
                                                .toString() +
                                            " km",
                                        style: TextStyle(
                                          //fontSize: 18.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                      alignment: Alignment.topRight,
                                      margin:
                                          const EdgeInsets.only(right: 15.0),
                                      child: Text(
                                        "Price Liter:",
                                        style: TextStyle(
                                          //fontSize: 25.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      child: Text(
                                        _fuelList![index]
                                                .price_liter
                                                .toStringAsFixed(2) +
                                            " €",
                                        style: TextStyle(
                                          //fontSize: 18.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                      alignment: Alignment.topRight,
                                      margin:
                                          const EdgeInsets.only(right: 15.0),
                                      child: Text(
                                        "Liter:",
                                        style: TextStyle(
                                          //fontSize: 25.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      child: Text(
                                        _fuelList![index]
                                                .amount_liter
                                                .toString() +
                                            " L",
                                        style: TextStyle(
                                          //fontSize: 18.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                      alignment: Alignment.topRight,
                                      margin:
                                          const EdgeInsets.only(right: 15.0),
                                      child: Text(
                                        "Price:",
                                        style: TextStyle(
                                          //fontSize: 25.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      child: Text(
                                        _fuelList![index]
                                                .price
                                                .toStringAsFixed(2) +
                                            " €",
                                        style: TextStyle(
                                          //fontSize: 18.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  TableCell(
                                    child: Container(
                                      alignment: Alignment.topRight,
                                      margin:
                                          const EdgeInsets.only(right: 15.0),
                                      child: Text(
                                        "Date:",
                                        style: TextStyle(
                                          //fontSize: 25.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Container(
                                      child: Text(
                                        formatter
                                            .format(_fuelList![index].date),
                                        style: TextStyle(
                                          //fontSize: 18.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ),
    );
  }
}
