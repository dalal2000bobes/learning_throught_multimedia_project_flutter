import 'package:get/get.dart';

import '../../../Common/responsive.dart';
import '../../Login_and_StartPage/profile_page.dart';
import 'components/my_fields.dart';
import 'package:flutter/material.dart';

import '../../../Common/constants.dart';
import 'components/header.dart';

import 'components/recent_files.dart';
import 'components/storage_details.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            MaterialButton(
              onPressed: () {
                print("Edit Image ...");
                Get.to(ProfilePage());
              },
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 5, color: Colors.white),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 20,
                          offset: const Offset(5, 5),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.person,
                      color: Colors.grey.shade300,
                      size: 80.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      MyFiles(),
                      SizedBox(height: defaultPadding),
                      RecentFiles(),
                      SizedBox(height: defaultPadding),
                      StorageDetails(),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
