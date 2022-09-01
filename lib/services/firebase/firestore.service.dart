import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kelvin_project/app/models/category.dart';

abstract class FirestoreService {
  static var timeStamp = Timestamp.now();

  // Reference Collection Path Data
  static final refCategory = FirebaseFirestore.instance
      .collection('category')
      .withConverter<CategoryModel>(
          fromFirestore: (snapshot, _) =>
              CategoryModel.fromJson(snapshot.data()!),
          toFirestore: (ctg, _) => ctg.toJson());
}
