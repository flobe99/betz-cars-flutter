import 'package:betz_cars/models/Car.dart';
import 'package:betz_cars/models/Fuel.dart';
import 'package:betz_cars/controller/getFuel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AddFuelData extends StatefulWidget {
  const AddFuelData({super.key, this.carList, this.index, this.fuelList});

  final int? index;
  final List<Car>? carList;
  final Fuel? fuelList;
  _AddFuelData createState() => _AddFuelData();
}

class _AddFuelData extends State<AddFuelData> {
  late String carController;
  TextEditingController kilometerInputController = TextEditingController();
  TextEditingController priceKilometerInputController = TextEditingController();
  TextEditingController literKilometerInputController = TextEditingController();
  TextEditingController priceInputController = TextEditingController();
  TextEditingController dateInputController = TextEditingController();
  DateTime fuelDate = new DateTime.now();
  final DateFormat formatter = DateFormat('dd.MM.yyyy');

  @override
  void initState() {
    super.initState();
    carController = widget.carList![widget.index!].modell;
    if (widget.fuelList!.id != "-1") {
      isStateUpdate = true;
      kilometerInputController.text = widget.fuelList!.kilometer.toString();
      priceKilometerInputController.text =
          widget.fuelList!.price_liter.toString();
      literKilometerInputController.text =
          widget.fuelList!.amount_liter.toString();
      priceInputController.text = widget.fuelList!.price.toString();
      dateInputController.text =
          formatter.format(widget.fuelList!.date).toString();
    }
  }

  void _addFuelData(data) async {
    await FuelApi().addFuel(data);
    //Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  void _updateFuelData(id, data) async {
    await FuelApi().updateFuel(id, data);
  }

  String onchangeval = "";
  final _formKey = GlobalKey<FormState>();

  bool isStateUpdate = false;

  @override
  Widget build(BuildContext context) {
    List<String> _carModells = widget.carList!.map((car) {
      return car.modell;
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text("Fuel Data " + widget.carList![widget.index!].modell),
        backgroundColor: Color.fromRGBO(16, 78, 138, 1),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Center(
                    child: DropdownButton<String>(
                      enableFeedback: false,
                      value: carController,
                      items: _carModells
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: Text(
                        "Choose a Car Model",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          carController = value!;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter valid number (E.g. 4562)';
                        }
                        return null;
                      },
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      autocorrect: false,
                      controller: kilometerInputController,
                      decoration: InputDecoration(
                        labelText: 'kilometer',
                        suffix: Text("km"),
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter valid number (E.g. 1,79 €)';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        try {
                          double liter_kilometer =
                              double.parse(literKilometerInputController.text);
                          double price_kilometer =
                              double.parse(priceKilometerInputController.text);
                          double price = 0.0;

                          if (liter_kilometer is double &&
                              price_kilometer is double) {
                            price = liter_kilometer * price_kilometer;
                            priceInputController.text =
                                price.toStringAsFixed(2);
                          }
                        } on Exception catch (_) {}
                      },
                      controller: priceKilometerInputController,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(',',
                            replacementString: '.'),
                        FilteringTextInputFormatter.allow(
                            RegExp(r'(^\d*\.?\d{0,2})'))
                      ],
                      autocorrect: false,
                      decoration: InputDecoration(
                        labelText: 'price per Liter',
                        suffix: Text("€"),
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter valid number (E.g. 33,79 L)';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        try {
                          double liter_kilometer =
                              double.parse(literKilometerInputController.text);
                          double price_kilometer =
                              double.parse(priceKilometerInputController.text);
                          double price = 0.0;

                          if (liter_kilometer is double &&
                              price_kilometer is double) {
                            price = liter_kilometer * price_kilometer;
                            priceInputController.text =
                                price.toStringAsFixed(2);
                          }
                        } on Exception catch (_) {}
                      },
                      controller: literKilometerInputController,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(',',
                            replacementString: '.'),
                        FilteringTextInputFormatter.allow(
                            RegExp(r'(^\d*\.?\d{0,2})'))
                      ],
                      autocorrect: false,
                      decoration: InputDecoration(
                        labelText: 'amount Liter',
                        suffix: Text("L"),
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter valid number (E.g. 123,45 €)';
                        }
                        return null;
                      },
                      onChanged: (value) {},
                      controller: priceInputController,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(',',
                            replacementString: '.'),
                        FilteringTextInputFormatter.allow(
                            RegExp(r'(^\d*\.?\d{0,2})'))
                      ],
                      autocorrect: false,
                      decoration: InputDecoration(
                        labelText: 'price',
                        suffix: Text("€"),
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter valid date (dd.MM.yyyy)';
                        }
                        return null;
                      },
                      onChanged: (value) {},
                      controller: dateInputController,
                      readOnly: true,
                      onTap: () async {
                        final f = new DateFormat('dd.MM.yyyy');

                        fuelDate = (await showDatePicker(
                          context: context,
                          initialDate: widget.fuelList!.date,
                          firstDate: DateTime(2020),
                          lastDate: DateTime.now(),
                        ))!;

                        setState(() {
                          fuelDate = fuelDate;
                        });

                        if (fuelDate != null) {
                          dateInputController.text =
                              f.format(fuelDate).toString();
                        }
                      },
                      autocorrect: false,
                      decoration: InputDecoration(
                        labelText: 'date',
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    //margin: EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            Color.fromRGBO(16, 78, 138, 1)),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );

                          Fuel fuel_list = new Fuel(
                              carId: widget.carList![widget.index!].id,
                              kilometer:
                                  int.parse(kilometerInputController.text),
                              price_liter: double.parse(
                                  priceKilometerInputController.text),
                              amount_liter: double.parse(
                                  literKilometerInputController.text),
                              price: double.parse(priceInputController.text),
                              date: fuelDate,
                              id: "");

                          if (isStateUpdate) {
                            _updateFuelData(widget.fuelList?.id, fuel_list);
                          } else {
                            _addFuelData(fuel_list);
                          }

                          //if (status_code == 200) {
                          Navigator.pop(context);
                          //}
                        }
                      },
                      child: Text('Save'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
