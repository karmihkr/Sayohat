import 'package:flutter/material.dart';
import 'home_page.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: size.width < 426 ? size.width * 0.7 : 300,
              height: size.height > 600 ? size.height * 0.8 : 500,
              child: Column(
                children: [
                  Container(
                    
                    height: (size.height > 600 ? size.height * 0.8 : 500) * 0.5,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "Sayohat",
                            style: TextStyle(
                              fontFamily: "Comfortaa",
                              fontSize: 35,
                              color: Color(0xFF2D615F),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "Admin",
                            style: TextStyle(
                              fontFamily: "DarkerGrot",
                              fontSize: 42,
                              color: Color(0xFF2D615F),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Image(image: AssetImage("assets/small_logo.png")),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: (size.height > 600 ? size.height * 0.8 : 500) / 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _inputField(hint: 'Телефон', obscure: false),
                        _inputField(hint: 'Пароль', obscure: true),
                        _loginButton(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputField({required String hint, required bool obscure}) {
    return Container(
      height: 50,
      margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xFF2D615F),
          width: 2,
        ),
      ),
      child: TextField(
        obscureText: obscure,
        keyboardType: obscure ? TextInputType.text : TextInputType.number,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Color(0xFF2D615F), fontFamily: "Roboto"),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
        ),
        style: TextStyle(color: Color(0xFF2D615F)),
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
      decoration: BoxDecoration(
        color: Color(0xFF2D615F),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFF2D615F), width: 2),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
        },
        child: Center(
          child: Text(
            'войти',
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
