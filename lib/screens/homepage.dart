import 'package:flutter/material.dart';
import 'package:login_page_new/provider/provider.dart';
import 'package:login_page_new/screens/bottomNavigatorPage.dart';
import 'package:login_page_new/screens/loginpage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Homepage extends StatefulWidget {

  final String email;
  final String username;
  final int userId;

  const Homepage({super.key, required this.email, required this.username, required this.userId});


  // const Homepage({super.key, required this.email, required this.username  });
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  int _selectedIndex = 0;

  final List<Widget> _screens = [
    Center(child: Text("Home Page", style: TextStyle(fontSize: 20, color: Colors.black),),),
    Center(child: Text("Search Page", style: TextStyle(fontSize: 20, color: Colors.black),),),
    Center(child: Text("Profile Page", style: TextStyle(fontSize: 20, color: Colors.black),),)
  ];

  void _onItemTapped (int index){
    setState(() {
      _selectedIndex = index;
    });
  }


  void logout() async {
    // Provider.of<LoginDataProvider>(context, listen: false).clearFields();

    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginDataProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        actions: [
          IconButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Loginpage()));
            logout();
          },
              icon: Icon(Icons.logout))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      // body: _screens[_selectedIndex],
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
    );
  }
}

