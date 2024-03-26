import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:library_app/services/local_notification_service.dart';

import 'package:provider/provider.dart';

import '../../../data/model/product_model.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../view_model/product_view_model.dart';
import '../detail_screen.dart';
import 'product_widget.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}


class _ProductsScreenState extends State<ProductsScreen> {
  int id=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Products",
          style: TextStyle(color: AppColors.c_2C2C73),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<ProductViewModel>().insertProduct(
                    ProductModel(
                      price: 12.5,
                      imageUrl:
                          "https://olcha.uz/image/600x600/products/2022-02-10/smartfon-samsung-galaxy-s22-ultra-5g-35759-0.png",
                      productName: "S22 Ultra",
                      docId: "",
                      productDescription: "productDescription",
                      categoryId: "",
                    ),
                    context,
                  );
              LocalNotificationService().showNotification(title: "Product qoshildi", body: "Mahsulot qo'shib bo'lindi", id: id);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder<List<ProductModel>>(
        stream: context.read<ProductViewModel>().listenProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.hasData) {
            List<ProductModel> list = snapshot.data as List<ProductModel>;
            return ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.all(25),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 15,
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    children: [
                      ...List.generate(list.length, (index) {
                        ProductModel productModel = list[index];
                        // ProductModel productModel =
                        // context.watch<ProductViewModel>().categoryProduct[index];
                        return InkWell(
                          borderRadius: BorderRadius.circular(20.w),
                          onTap: () {
                            debugPrint(productModel.productName);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return DetailScreen(
                                    productModel1: productModel,
                                  );
                                },
                              ),
                            );
                          },
                          child:  ProductsItem(
                            docId: '',
                            productName: productModel.productName,
                            productDescription: 'zor telfon',
                            price: 2500,
                            imageUrl:
                                productModel.imageUrl.toString(),
                            categoryId: '',
                          ),
                        );
                      })
                    ],
                  ),
                )
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
