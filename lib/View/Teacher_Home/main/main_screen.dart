import '../../../Controller/TeacherHomeController.dart';
import '../../../Common/responsive.dart';
import '../dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/side_menu.dart';

class TeacherHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 24, 27, 55),
      drawerScrimColor: Color.fromARGB(255, 24, 27, 55),
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: DashboardScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
