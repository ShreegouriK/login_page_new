import 'package:flutter/material.dart';
import 'package:login_page_new/provider/provider.dart';
import 'package:login_page_new/screens/homepage.dart';
import 'package:login_page_new/services/api_services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(email);
  }

  // Function to display a snackbar message
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _login() async{
    String email = _emailController.text.trim();
    String password = _passwordcontroller.text.trim();
    final ApiService apiService = ApiService();

    // Validate input fields
    if (email.isEmpty || password.isEmpty) {
      _showMessage("Please fill in all fields.");
      return;
    }
    if (!_isValidEmail(email)) {
      _showMessage("Please enter a valid email address.");
      return;

    }
    final response = await apiService.login(email, password);
    print(response);
    if(response['success']== true){

      final userId = response['data']['data']['user_id']?? 0;
      final username = response['data']['data']['username']?? '';

      print(username);

      Provider.of<LoginDataProvider>(context, listen: false).setData(userId, username, email, password);


      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString("user_id", userId.toString());
      await pref.setString("username", username);
      await pref.setString("email_id", email);



    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Login Success"),
            content: Text("Login Successful"),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Homepage(email: email, username: username, userId: userId,)));
                },
              ),
            ],
          );
        },
      );
    }else{
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Login Failed"),
            content: Text("Login Failed"),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Loginpage()));
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

      ),
      body:Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Enter email here",
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              ),
              SizedBox(height: 20,),

              TextField(
                controller: _passwordcontroller,
                decoration: InputDecoration(
                    hintText: "Enter password here",
                    labelText: "Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                ),
              ),
              SizedBox(height: 20,),

              ElevatedButton(onPressed: (){
                _login();
              },
                  child: Text("login"))
            ],
          ),
        ),
      ),
    );
  }
}
