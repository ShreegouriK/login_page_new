// import 'package:flutter/material.dart';
//
// class Bottomnavigatorpage extends StatefulWidget {
//   const Bottomnavigatorpage({super.key});
//
//   @override
//   State<Bottomnavigatorpage> createState() => _BottomnavigatorpageState();
// }
//
// class _BottomnavigatorpageState extends State<Bottomnavigatorpage> {
//
//   int _selectedIndex = 0;
//
//   final List<Widget> _screens = [
//     Center(child: Text("Home Page", style: TextStyle(fontSize: 20, color: Colors.black),),),
//     Center(child: Text("Search Page", style: TextStyle(fontSize: 20, color: Colors.black),),),
//     Center(child: Text("Profile Page", style: TextStyle(fontSize: 20, color: Colors.black),),)
//   ];
//
//   void _onItemTapped (int index){
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//        appBar: AppBar(
//          title: Text("Demo"),
//        ),
//       bottomNavigationBar: BottomNavigationBar(
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//                 icon: Icon(Icons.home), label: "Home"),
//             BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
//             BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
//           ],
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//       ),
//       body: _screens[_selectedIndex],
//     );
//   }
// }
