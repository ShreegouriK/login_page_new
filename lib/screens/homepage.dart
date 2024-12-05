import 'package:flutter/material.dart';
import 'package:login_page_new/provider/provider.dart';
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
       // body: Center(child: Text("Welcome to the new page ${widget.userId}")),
      body: Center(child: Text("Welcome username:${provider.username}, userId:${provider.userId}, email:${provider.email} "),),
    );
  }
}
