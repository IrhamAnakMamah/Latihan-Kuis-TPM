import 'package:flutter/material.dart';
import 'package:lat_kuis/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _isLoggedIn = false;

  void _login({
    required String user,
    required String password
  }){
    setState(() {
      _isLoggedIn = (user == "Irham" && password == "12345" ? true : false);
    }); 
    if(!_isLoggedIn){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login Gagal!, username atau password salah"))
      );
    }else{
      // kalo pushReplacement, historynya ke hapus (tidak bisa balik lagi ke halaman Login)
      Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage(username: user)),
      );
      _userController.clear();
      _passController.clear();
      _isLoggedIn = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login Page',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(padding: EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _isLoggedIn ? Text("Login Berhasil!") : Text(""),
              SizedBox(
                height: 20,
              ),
              _loginField(
                hint: "Username",
                inputController: _userController,
                isLogin: _isLoggedIn
              ),

              SizedBox(
                height: 20,
              ),

              _loginField(
                hint: "Password", 
                inputController: _passController,
                isPassword: true,
                isLogin: _isLoggedIn
              ),

              SizedBox(
                height: 20,
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: BorderSide()
                  ),
                  onPressed: (){
                  // print("Dipencet");
                  _login(
                    user: _userController.text,
                    password: _passController.text
                  );

                }, child: Text("Login")),
              )
            ],
            ),
        )
        ),
      ),
    );
  }

  Widget _loginField ({
    required String hint,
    required TextEditingController inputController,
    bool isPassword = false,
    bool isLogin = false
  }){
    return TextField(
      controller: inputController,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: isLogin ? Colors.blue : Colors.red
          )
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isLogin ? Colors.blue : Colors.red
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: isLogin ? Colors.blue : Colors.red)
        )
      ),
    );
  }
}
