import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:library_app/data/model/product_model.dart';
import 'package:library_app/utils/utility_functions.dart';

class ProductViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get getLoader => _isLoading;

  Stream<List<ProductModel>> listenProducts() => FirebaseFirestore.instance
      .collection("products")
      .snapshots()
      .map((event) =>
          event.docs.map((doc) => ProductModel.fromJson(doc.data())).toList());
  List<ProductModel> categoryProduct = [];


  insertProduct(ProductModel productModel, BuildContext context) async {
    try {
      //create
      _notify(true);
      var cf = await FirebaseFirestore.instance
          .collection("products")
          .add(productModel.toJson());
      //update
      cf.id;
      await FirebaseFirestore.instance
          .collection("products")
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
  Future<void> getProductsByCategory(String categoryDocId) async {
    _notify(true);
    await FirebaseFirestore.instance
        .collection("products")
        .where("category_id", isEqualTo: categoryDocId)
        .get()
        .then((snapshot) {
      categoryProduct =
          snapshot.docs.map((e) => ProductModel.fromJson(e.data())).toList();
    });
    _notify(false);
  }

  updateProduct(ProductModel productModel, BuildContext context) async {
    try {
      //create
      _notify(true);
      await FirebaseFirestore.instance
          .collection("products")
          .doc(productModel.docId)
          .update(
            productModel.toJsonForUpdate(),
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

  deleteProduct(String docId, BuildContext context) async {
    try  {
      //created
      _notify(true);
      await FirebaseFirestore.instance.collection("products").doc(docId).delete();

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
