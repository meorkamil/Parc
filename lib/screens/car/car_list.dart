import 'package:flutter/material.dart';
import 'package:parc_app/screens/shared/empty_car.dart';
import 'package:parc_app/screens/shared/loading.dart';
import 'package:parc_app/services/database.dart';
import 'package:parc_app/models/user.dart';
import 'package:parc_app/screens/car/car_tile.dart';
import 'package:provider/provider.dart';
import 'package:parc_app/models/car.dart';

class CarList extends StatefulWidget {
  @override
  _CarListState createState() => _CarListState();
}

class _CarListState extends State<CarList> {
  @override
  Widget build(BuildContext context) {
    final cars = Provider.of<List<Car>>(context) ?? [];
    final user = Provider.of<User>(context);
    // print(cars);

    // cars.forEach((car) {
    //   print(car.noplate);
    // });

    // cars.forEach((car) {
    //   print(car.status);
    //   print(car.noplate);
    // });

    return StreamBuilder<List<Car>>(
        stream: DatabaseService(uid: user.uid).car,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data.isEmpty) return EmptyCar();
          return ListView.builder(
            itemCount: cars.length,
            itemBuilder: (context, index) {
              return CarTile(car: cars[index]);
            },
          );
        });
  }
}
