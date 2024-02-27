import 'package:betz_cars/addFuelData.dart';
import 'package:betz_cars/controller/getRepairs.dart';
import 'package:betz_cars/models/Car.dart';
import 'package:betz_cars/models/Fuel.dart';
import 'package:betz_cars/models/Repair.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class OverviewCarRepair extends StatefulWidget {
  const OverviewCarRepair({
    super.key,
    this.carList,
  });
  final Car? carList;
  @override
  _OverviewCarRepair createState() => _OverviewCarRepair();
}

class _OverviewCarRepair extends State<OverviewCarRepair> {
  late List<Repair>? _repairList = [];

  var number_thousand_separator = NumberFormat('###,###', 'de_DE');

  @override
  void initState() {
    super.initState();
    _getRepairData(widget.carList?.id);
  }

  void _getRepairData(carId) async {
    _repairList = [];
//    _repairList = (await RepairApi().getCarRepairs(carId))!;
    _repairList = (await RepairApi().getRepair())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  void _deleteFuelData(carId) async {
    await RepairApi().deleteRepair(carId);
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  Offset _tapPosition = Offset.zero;
  void _getTapPosition(TapDownDetails details) {
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    setState(() {
      _tapPosition = referenceBox.globalToLocal(details.globalPosition);
    });
  }

  void _showContextMenu(BuildContext context, Repair fuel) async {
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
        break;
      case 'delete':
        _deleteFuelData(fuel.id);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Fuel data deleted')),
        );

        break;
      case 'edit':
        /*
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddFuelData(
                    carList: widget.carList,
                    fuelList: fuel,
                  )),
        );*/
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd.MM.yyyy');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.carList!.modell.toString() + ' Repairs'),
        backgroundColor: Color.fromRGBO(16, 78, 138, 1),
      ),
      body: _repairList == null || _repairList!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  _getRepairData(widget.carList?.id);
                });
              },
              child: ListView.builder(
                  itemCount: _repairList!.length,
                  //itemExtent: 100.0,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTapDown: (details) => _getTapPosition(details),
                      onLongPress: () async {
                        _showContextMenu(context, _repairList![index]);
                      },
                      child: ExpansionTile(
                        //tileColor: Colors.grey[200],
                        shape: Border(bottom: BorderSide()),
                        leading: FaIcon(FontAwesomeIcons.screwdriverWrench),
                        title: Text(_repairList![index].summary),
                        subtitle:
                            Text(formatter.format(_repairList![index].date)),
                        trailing: Text(
                            _repairList![index].costs.toStringAsFixed(2) +
                                " €"),
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
                                                .format(_repairList![index]
                                                    .kilometer)
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
                                        "Workshop:",
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
                                        _repairList![index].workshop,
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
                                        "Summary:",
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
                                        _repairList![index].summary,
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
                                        _repairList![index]
                                                .costs
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
                                            .format(_repairList![index].date),
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
