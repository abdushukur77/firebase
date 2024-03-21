import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../utils/styles/app_text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../../../view_model/auth_view_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    User? user = context.watch<AuthViewModel>().getUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthViewModel>().logout(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: user != null
          ? context.watch<AuthViewModel>().loading
              ? const Center(child: CircularProgressIndicator())
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Row(
                          children: [
                             CircleAvatar(
                              radius: 50.0,
                              backgroundImage: AssetImage(
                                  user.photoURL.toString()), // Replace with your image path
                            ),
                            const SizedBox(width: 20.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  [
                                Text(
                                  user.displayName.toString(),
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  user.uid,
                                  style: TextStyle(fontSize: 12.sp),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          user.uid,
                          style:
                              AppTextStyle.interSemiBold.copyWith(fontSize: 24),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          user.email.toString(),
                          style:
                              AppTextStyle.interSemiBold.copyWith(fontSize: 24),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          user.displayName.toString(),
                          style:
                              AppTextStyle.interSemiBold.copyWith(fontSize: 24),
                        ),
                        if (user.photoURL != null)
                          Image.network(
                            user.photoURL!,
                            width: 200,
                            height: 200,
                          ),
                        IconButton(
                          onPressed: () {
                            context.read<AuthViewModel>().updateImageUrl(
                                "https://www.tenforums.com/attachments/tutorials/146359d1501443008-change-default-account-picture-windows-10-a-user.png");
                          },
                          icon: const Icon(Icons.image),
                        )
                      ],
                    ),
                  ),
                )
          : const Center(
              child: Text("USER NOT EXIST"),
            ),
    );
  }
}

// import 'package:flutter/material.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Profile'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Profile Picture & Name Section
//               _buildProfileHeader(),
//
//               // About Me Section
//               const Divider(),
//               const Text(
//                 'About Me',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const Text(
//                 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam euismod mi a augue tincidunt blandit. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Suspendisse potenti. Sed vel leo dui. Mauris eget leo vitae justo condimentum porta.',
//                 style: TextStyle(fontSize: 16),
//               ),
//
//               // Contact Information Section
//               const Divider(),
//               const Text(
//                 'Contact Information',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               const ListTile(
//                 leading: Icon(Icons.email),
//                 title: Text('example@email.com'),
//               ),
//               const ListTile(
//                 leading: Icon(Icons.phone),
//                 title: Text('+123 456 7890'),
//               ),
//
//               // Additional Information Sections
//               // You can add more sections here based on your needs
//               // For example:
//               // - Social Media Links
//               // - Skills & Experience
//               // - Interests & Hobbies
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
Widget _buildProfileHeader() {
  return Row(
    children: [
      const CircleAvatar(
        radius: 50.0,
        backgroundImage: AssetImage(
            'assets/profile_picture.jpg'), // Replace with your image path
      ),
      const SizedBox(width: 20.0),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'John Doe',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          Text(
            'Software Engineer',
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    ],
  );
}
