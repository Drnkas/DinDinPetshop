import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/app_colors.dart';
import '../controller/home_controller.dart';

class CustomSearch extends StatefulWidget {
  const CustomSearch({super.key});

  @override
  State<CustomSearch> createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextFormField(
        onChanged: homeController.setSearchQuery,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          isDense: true,
          hintText: 'Pesquise aqui...',
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
          prefixIcon: Icon(Icons.search, color: AppColors.primary, size: 21),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(60),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
        ),
      ),
    );

    //   Column(
    //   children: [
    //     Padding(
    //       padding: const EdgeInsets.symmetric(
    //         horizontal: 10,
    //         vertical: 5,
    //       ),
    //       child: TextFormField(
    //         onChanged: homeController.setSearchQuery,
    //         decoration: InputDecoration(
    //           filled: true,
    //           fillColor: Colors.white,
    //           isDense: true,
    //           hintText: 'Pesquise aqui...',
    //           hintStyle: TextStyle(
    //             color: Colors.grey.shade400,
    //             fontSize: 14,
    //           ),
    //           prefixIcon: Icon(Icons.search, color: AppColors.primary, size: 21),
    //           border: OutlineInputBorder(
    //             borderRadius: BorderRadius.circular(60),
    //             borderSide: const BorderSide(
    //               width: 0,
    //               style: BorderStyle.none,
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //     Expanded(
    //       child: StreamBuilder<QuerySnapshot>(
    //         stream: FirebaseFirestore.instance
    //             .collection('products')
    //             .orderBy('name')
    //             .startAt([search])
    //             .endAt([search + "\uf8ff"])
    //             .snapshots(),
    //         builder: (context, snapshot) {
    //           if (snapshot.connectionState == ConnectionState.waiting) {
    //             return const Center(
    //               child: CircularProgressIndicator(),
    //             );
    //           } else if (snapshot.hasError) {
    //             return Center(
    //               child: Text('Error: ${snapshot.error}'),
    //             );
    //           } else {
    //             return ListView.builder(
    //               itemCount: snapshot.data!.docs.length,
    //               itemBuilder: (context, index) {
    //                 var data = snapshot.data!.docs[index].data()
    //                 as Map<String, dynamic>;
    //
    //                 return ListTile(
    //                   title: Text(
    //                     data['name'],
    //                     maxLines: 1,
    //                     overflow: TextOverflow.ellipsis,
    //                     style: const TextStyle(
    //                       color: Colors.black54,
    //                       fontSize: 16,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                   ),
    //                   // leading: CircleAvatar(
    //                   //   backgroundImage: NetworkImage(data['image']),
    //                   // ),
    //                 );
    //               },
    //             );
    //           }
    //         },
    //       ),
    //     ),
    //   ],
    // );
  }
}
