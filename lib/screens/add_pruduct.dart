import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../../data/model/notification_model.dart';
import '../data/model/product_model.dart';
import '../services/local_notification_service.dart';
import '../utils/colors/app_colors.dart';
import '../utils/styles/app_text_style.dart';
import '../view_model/image_view_model.dart';
import '../view_model/notification_view_model.dart';
import '../view_model/product_view_model.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key, });
  // final String categoryId;
  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController nameController=TextEditingController();
  TextEditingController priceController=TextEditingController();
  TextEditingController productDescriptionController=TextEditingController();
  final ImagePicker picker = ImagePicker();
  String imageUrl='';
  String storagePath='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          },icon:const Icon(Icons.arrow_back,color: AppColors.black,),),
          centerTitle: true,
          title:  Text('Add Product',style: AppTextStyle.interRegular.copyWith(
              color: AppColors.c_0C8A7B,fontSize: 24
          ),),
        ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal:24.w,vertical:40),
                child: Column(children: [
                  TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      hintText: 'Enter product name',
                      border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            width: 1,color: AppColors.black.withOpacity(0.7),
                          )
                      )
                  ),
                ),
                SizedBox(height: 20.h,),
                TextField(
                  controller: productDescriptionController,
                  decoration: InputDecoration(
                      hintText: 'Enter description',
                      border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            width: 1,color: AppColors.black.withOpacity(0.7),
                          )
                      )
                  ),
                ),
                SizedBox(height: 20.h,),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(
                      hintText: 'Enter price',
                      border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            width: 1,color: AppColors.black.withOpacity(0.7),
                          )
                      )
                  ),
                ),
                SizedBox(height: 12.h),
                if (context.watch<ImageViewModel>().getLoader)
        const CircularProgressIndicator(),
    if (imageUrl.isNotEmpty) Image.network(imageUrl),
    TextButton(
    style: TextButton.styleFrom(
    padding: const EdgeInsets.all(16),
    backgroundColor:AppColors.c_090F47,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
    ),
    ),
    onPressed: () {
    takeAnImage();
    },
    child: Text(
    "Upload your image",

      style: AppTextStyle.interSemiBold.copyWith(
        fontSize: 24,
        color: Colors.white,
      ),
    ),
    ),
                  const SizedBox(height: 40,),
                  TextButton(onPressed: ()async{
                    if (imageUrl.isNotEmpty &&
                        nameController.text.isNotEmpty && productDescriptionController.text.isNotEmpty && priceController.text.isNotEmpty){
                      await context.read<ProductViewModel>().insertProduct(
                          ProductModel(
                            storagePath: storagePath,
                            price: double.parse(priceController.text),
                            imageUrl:imageUrl,
                            productName:nameController.text,
                            docId: '',
                            productDescription: productDescriptionController.text,
                            categoryId:""),
                          context);
                      Navigator.pop(context);
                    }
                    NotificationModel notification=NotificationModel(name: "${nameController.text} qoshildi", id:DateTime.now().millisecond);
                    context.read<NotificationViewModel>().addNotification(notification);
                    LocalNotificationService().showNotification(
                        title: "${nameController.text} nomli mahsulot qoshildi", body:"Mahsulot", id:notification.id);
                  },
                      style: TextButton.styleFrom(
                          backgroundColor: AppColors.c_0C8A7B
                      ),
                      child:Text('Save',style: AppTextStyle.interRegular.copyWith(
                          fontSize: 14.w,color: AppColors.white
                      ),))
                ],),
            ),
        ),
    );
  }
  Future<void> _getImageFromCamera() async {
    XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 1024,
      maxWidth: 1024,
    );
    if (image != null && context.mounted) {
      debugPrint("IMAGE PATH:${image.path}");
      storagePath = "files/images/${image.name}";
      imageUrl = await context.read<ImageViewModel>().uploadImage(
        pickedFile: image,
        storagePath: storagePath,
      );

      debugPrint("DOWNLOAD URL:$imageUrl");
    }
  }

  Future<void> _getImageFromGallery() async {
    XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 1024,
      maxWidth: 1024,
    );
    if (image != null && context.mounted) {
      debugPrint("IMAGE PATH:${image.path}");
      storagePath = "files/images/${image.name}";
      imageUrl = await context.read<ImageViewModel>().uploadImage(
        pickedFile: image,
        storagePath: storagePath,
      );

      debugPrint("DOWNLOAD URL:$imageUrl");
    }
  }

  takeAnImage() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            )),
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12.h),
              ListTile(
                onTap: () async {
                  await _getImageFromGallery();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.photo_album_outlined),
                title: const Text("Gallereyadan olish"),
              ),
              ListTile(
                onTap: () async {
                  await _getImageFromCamera();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.camera_alt),
                title: const Text("Kameradan olish"),
              ),
              SizedBox(height: 24.h),
            ],
          );
        });
  }
}
