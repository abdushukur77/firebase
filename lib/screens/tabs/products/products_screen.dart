import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import '../../../data/model/product_model.dart';
import '../../../utils/colors/app_colors.dart';
import '../../../view_model/product_view_model.dart';
import '../detail_screen.dart';
import 'book_widget.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products",style: TextStyle(color: AppColors.c_2C2C73),),
        actions: [
          IconButton(
            onPressed: () {
              context.read<ProductViewModel>().insertProduct(
                ProductModel(
                  price: 12.5,
                  imageUrl:
                  "https://i.ebayimg.com/images/g/IUMAAOSwZGBkTR-K/s-l400.png",
                  productName: "Nokia 12 80",
                  docId: "",
                  productDescription: "productDescription",
                  categoryId: "kcggCJzOEz7gH1LQy44x",
                ),
                context,
              );
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
                        // context.watch<ProductsViewModel>().categoryProduct[index];
                        return InkWell(
                          borderRadius: BorderRadius.circular(20.w),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return DetailScreen(productModel1: productModel,

                                  );
                                }));
                          },
                          child: const ProductsItem(
                            docId: '',
                            productName: 'Samsung',
                            productDescription: 'zor telfon',
                            price: 2500,
                            imageUrl: 'https://cdn.mediapark.uz/imgs/1a0ef8f0-8d3e-41db-ad98-a655c10cbd9b.webp',
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
