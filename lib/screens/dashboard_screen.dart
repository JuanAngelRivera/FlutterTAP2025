import 'package:flutter/material.dart';
import 'package:flutter_application/utils/global_values.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:sidebarx/sidebarx.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SidebarX(
        headerBuilder: (context, extended) {
          return const UserAccountsDrawerHeader(
            accountName: Text("Cherrisita"),
            accountEmail: Text("Cherrisita@gmail.com"),
          );
        },
        extendedTheme: const SidebarXTheme(width: 200),
        controller: SidebarXController(selectedIndex: 1),
        items: [
          SidebarXItem(
            onTap: () => Navigator.pushNamed(context, "/challenge"),
            icon: Icons.home,
            label: "Challenge App",
          ),
        ],
      ),
      appBar: AppBar(title: Text("Panel de control")),
      body: HawkFabMenu(
        body: const Center(child: Text("MIIIIAAAAAAAAAAAU")),
        items: [
          HawkFabMenuItem(
            label: "Theme light",
            ontap: () => GlobalValues.themeMode.value = 1,
            icon: const Icon(Icons.light_mode),
          ),
          HawkFabMenuItem(
            label: "Theme dark",
            ontap: () => GlobalValues.themeMode.value = 0,
            icon: const Icon(Icons.dark_mode),
          ),
        ],
      ),
    );
  }
}
