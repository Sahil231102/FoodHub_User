import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseCollectionNAmes {
  static const user = "user";
  static const foodItems = "FoodItems";
}

class FirebaseServices {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static CollectionReference<Map<String, dynamic>> useFirestore =
      FirebaseFirestore.instance.collection(FirebaseCollectionNAmes.user);

  static CollectionReference<Map<String, dynamic>> foodFirestore =
      FirebaseFirestore.instance.collection(FirebaseCollectionNAmes.foodItems);
}
