import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  TextEditingController conUser = TextEditingController();
  TextEditingController conPw = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/loginbg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 100,
              child: Image.asset('assets/logintitulo.png', width: 350),
            ),
            Positioned(
              bottom: 250,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color.fromARGB(211, 7, 75, 46),
                ),
                width: 350,
                height: 210,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'deltarune',
                        color: Colors.white,
                      ),
                      controller: conUser,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(
                          fontSize: 20,
                          fontFamily: 'deltarune',
                          color: Colors.white,
                        ),
                        label: Text('User'),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'deltarune',
                        color: Colors.white,
                      ),
                      controller: conPw,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelStyle: TextStyle(
                          fontSize: 20,
                          fontFamily: 'deltarune',
                          color: Colors.white,
                        ),
                        label: Text('Password'),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 580,
              child: InkWell(
                onTap: () {},
                child: OutlinedButton(
                  onPressed: () {
                    isLoading = true;
                    setState(() {});

                    Future.delayed(const Duration(seconds: 4)).then((value) {
                      Navigator.pushNamed(context, "/dash");
                    });

                    /*Navigator.push(
                     context, 
                     MaterialPageRoute(
                       builder: (context) => const DashboardScreen(),
                     )
                   );*/
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromARGB(255, 246, 11, 104),
                    side: BorderSide(
                      color: Color.fromARGB(255, 0, 1, 238),
                      width: 6,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Log in",
                    style: TextStyle(fontSize: 30, fontFamily: 'deltarune'),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 620,
              child:
                  isLoading
                      ? Lottie.asset('assets/loading.json', height: 200)
                      : Container(),
            ),
          ],
        ),
      ),
    );
  }
}
