import 'package:flutter/material.dart';

import '../models/Car.dart';

class UserCard extends StatelessWidget {
  UserCard(this.car, this.onTapEdit, this.onTapDelete);
  final Car car;
  final Function onTapEdit, onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0,
      color: Colors.white,
      child: ListTile(
        leading: Text(
          '${car.producer}',
          style: Theme.of(context).textTheme.headline6,
        ),
        title: Text(car.modell),
        subtitle: Text('${car.year}'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              child: Icon(Icons.edit),
            ),
            GestureDetector(
              child: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
