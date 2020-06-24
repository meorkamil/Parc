import 'dart:typed_data';
import 'package:intl/intl.dart'; //for date format
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:parc_app/models/parc.dart';
import 'package:parc_app/models/transactions.dart';
import 'package:parc_app/models/user.dart';
import 'package:parc_app/models/car.dart';
import 'package:parc_app/services/auth.dart';
import 'dart:convert';

class DatabaseService {
  final String uid;
  final String transactionID;

  final String credentials = "Upaid";
  //final Codec<String, String> stringToBase64 = utf8.fuse(base64);
  // final String encoded = stringToBase64.encode(credentials); // dXNlcm5hbWU6cGFzc3dvcmQ=
  // final String decoded = stringToBase64.decode(encoded);
  Codec<String, String> stringToBase64 = utf8.fuse(base64);
  DatabaseService({this.uid, this.transactionID});

  // collection reference
  final CollectionReference parcCollection =
      Firestore.instance.collection('parcs');

  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  final CollectionReference carsCollection =
      Firestore.instance.collection('cars');

  final CollectionReference transCollection =
      Firestore.instance.collection('transactions');

  // Future updateCarsData(String noplate) async {
  //   return await usersCollection.document(uid).collection('cars').add({
  //     'noplate': noplate,
  //   });
  // }
  Future updateCarsData(String noplate) async {
    // return await carsCollection
    //     .add({'uid': uid, 'noplate': noplate, 'status': 'No'});
    if (await checkCar(noplate) == true) {
      return await carsCollection
          .add({'uid': uid, 'noplate': noplate, 'status': 'No'});
    } else {
      //final String error = "Vehicle already exist!";
      return null;
    }
  }

  checkCar(String noplate) async {
    try {
      final noplateCheck = await carsCollection
          .where('noplate', isEqualTo: noplate)
          .getDocuments();

      final List<DocumentSnapshot> documents = noplateCheck.documents;

      if (documents.isEmpty) {
        return true;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // checkStatusCar(String noplate) async {
  //   try {
  //     final noplateCheck = await carsCollection
  //         .where('noplate', isEqualTo: noplate)
  //         .where('status', isEqualTo: 'Unpaid')
  //         .getDocuments();

  //     if (documents.) {
  //       return true;
  //     } else {
  //       return null;
  //     }
  //   } catch (e) {
  //     return null;
  //   }
  // }

  Future updateCarsDataDoc(String noplate, String docID) async {
    return await carsCollection.document(docID).updateData({
      'noplate': noplate,
    });
  }

  Future updateUserName(String name) async {
    return await usersCollection.document(uid).updateData({
      'name': name,
    });
  }

  Future updateContactNo(String contactNo) async {
    return await usersCollection.document(uid).updateData({
      'contact': contactNo,
    });
  }

  Future addTransaction(
      String docID, String userID, String noplate, String stripe) async {
    return await transCollection.add({
      'carID': docID,
      'uid': userID,
      'stripe': stripe,
      'noplate': noplate,
      'amount': 'RM10',
      'time': FieldValue.serverTimestamp()
    });
  }

  Future updateCarPayment(String docID) async {
    return await carsCollection.document(docID).updateData({
      'status': 'Paid',
    });
  }

  Future deleteCarsData(String docID) async {
    return await carsCollection.document(docID).delete();

    // if (await checkCar(noplate) == true) {
    //   return await carsCollection.document(docID).delete();
    // } else {
    //   //final String error = "Vehicle already exist!";
    //   return null;
    // }
  }

  // Future updateCarsDataDoc(String noplate, String docID) async {
  //   return await usersCollection
  //       .document(uid)
  //       .collection('cars')
  //       .document(docID)
  //       .setData({
  //     'noplate': noplate,
  //   });
  // }

  // Future deleteCarsData(String docID) async {
  //   return await usersCollection
  //       .document(uid)
  //       .collection('cars')
  //       .document(docID)
  //       .delete();
  // }

  Future updateUserData(String name, String email) async {
    return await usersCollection.document(uid).setData({
      'name': name,
      'email': email,
      'contact': '-',
    });
  }

  //Base64Codec base64 = const Base64Codec();

  // parc list from snapshot
  List<Parc> _parcListFromSnapsot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Parc(
          name: doc.data['name'] ?? '', noplate: doc.data['noplate'] ?? '');
    }).toList();
  }

  List<Car> _carListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Car(
          noplate: doc.data['noplate'] ?? '',
          status: doc.data['status'],
          docID: doc.documentID);
    }).toList();
  }

  List<Transactions> _listTransactions(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Transactions(
          carID: doc.data['carID'] //, time: getDate(doc.data['time'])

          );
      // userID: doc.documentID);
    }).toList();
  }

  getDate(DateTime inputVal) {
    String processedDate;
    processedDate = inputVal.year.toString() +
        '-' +
        inputVal.month.toString() +
        '-' +
        inputVal.day.toString();
    return processedDate;
  }

  List<Car> _unpaidCarList(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Car(
          noplate: doc.data['noplate'] ?? '',
          status: doc.data['status'],
          docID: doc.documentID);
    }).toList();
  }

  // static String dataFromBase64String(base64String) {
  //   Codec<String, String> stringToBase64 = utf8.fuse(base64);
  //   return stringToBase64.encode(base64String);
  // }

  // List<Car> _userListFromSnapsot(QuerySnapshot snapshot) {
  //   return snapshot.documents.map((doc) {
  //     return Car(noplate: doc.data['noplate'] ?? '');
  //   }).toList();
  // }

  //user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid, name: snapshot.data['name'], email: snapshot.data['email']);
  }

  // Transactions _listTransactions(DocumentSnapshot snapshot) {
  //   return Transactions(
  //       time: snapshot.data['time'].toString(), carID: snapshot.data['carID']);
  // }
  // CarData _carDataFromSnapshot(DocumentSnapshot snapshot) {
  //   return CarData(
  //     noplate: snapshot.data['noplate'],
  //     docID: snapshot.documentID,
  //   );
  // }

  // List<UserData> _userDataFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.documents.map((doc) {
  //     return UserData(
  //         email: doc.data['email'] ?? '',
  //         name: doc.data['name'],
  //         uid: doc.documentID);
  //   }).toList();
  // }

  Stream<List<Car>> get car {
    return carsCollection
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map(_carListFromSnapshot);
  }

  Stream<List<Car>> get unpaidCar {
    return carsCollection
        .where('uid', isEqualTo: uid)
        .where('status', isEqualTo: 'Unpaid')
        .snapshots()
        .map(_unpaidCarList);
  }

  // get parc stream_userDataFromSnapshot
  Stream<List<Parc>> get parc {
    return usersCollection.snapshots().map(_parcListFromSnapsot);
  }

  Stream<List<Transactions>> get transactions {
    return transCollection
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map(_listTransactions);
  }

  Stream<UserData> get userData {
    return usersCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  // Stream<CarData> get carData {
  //   return usersCollection
  //       .document(uid)
  //       .collection('cars')
  //       .document(docID)
  //       .snapshots()
  //       .map(_carDataFromSnapshot);
  // }

  // Stream<List<Car>> get car {
  //   return usersCollection
  //       .document(uid)
  //       .collection('cars')
  //       .snapshots()
  //       .map(_carListFromSnapshot);
  // }
}
