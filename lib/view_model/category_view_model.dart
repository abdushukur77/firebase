import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:library_app/utils/utility_functions.dart';
import '../data/model/category_model.dart';

class CategoryViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get getLoader => _isLoading;

  Stream<List<CategoryModel>> listenCategories() => FirebaseFirestore.instance
      .collection("categories")
      .snapshots()
      .map((event) =>
          event.docs.map((doc) => CategoryModel.fromJson(doc.data())).toList());

  insertCategory(CategoryModel categoryModel, BuildContext context) async {
    try {
      //create
      _notify(true);
      var cf = await FirebaseFirestore.instance
          .collection("categories")
          .add(categoryModel.toJson());
      //update
      cf.id;
      await FirebaseFirestore.instance
          .collection("categories")
          .doc(cf.id)
          .update({"doc_id": cf.id});

      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      showSnackbar(
        context: context,
        message: error.code,
      );
    }
  }

  updateCategory(CategoryModel categoryModel, BuildContext context) async {
    try {
      //create
      _notify(true);
      await FirebaseFirestore.instance
          .collection("categories")
          .doc(categoryModel.docId)
          .update(
            categoryModel.toJsonForUpdate(),
          );
      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      showSnackbar(
        context: context,
        message: error.code,
      );
    }
  }

  deleteCategory(String docId, BuildContext context) async {
    try {
      //create
      _notify(true);
      await FirebaseFirestore.instance.collection("categories").doc(docId).delete();

      _notify(false);
    } on FirebaseException catch (error) {
      if (!context.mounted) return;
      showSnackbar(
        context: context,
        message: error.code,
      );
    }
  }



  _notify(bool v) {
    _isLoading = v;
    notifyListeners();
  }
}
