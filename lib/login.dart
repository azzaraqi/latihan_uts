import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pra_uts/Model/model_login.dart';
import 'package:pra_uts/berita.dart';
import 'package:pra_uts/register.dart';
import 'package:pra_uts/splashscreen.dart';

import 'utils/cek_session.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  bool isLoading = false;

  Future<ModelLogin?> loginAccount() async {
    try {
      setState(() {
        isLoading = true;
      });

      http.Response res = await http.post(
        Uri.parse('http://localhost/latihan_uts/login.php'),
        body: {
          "email": txtUsername.text,
          "nobp": txtEmail.text,
        },
      );
      ModelLogin data = modelLoginFromJson(res.body);
      //cek kondisi (ini berdasarkan value respon api
      //value ,1 (ada data login),dan 0 (gagal)
      if (data.status == "success") {
        setState(() {
          //save session
          // session.saveSession(
          //   data. ?? 0,
          //   data.id_user ?? "",
          //   data.name ?? "",
          //   data.email ?? "",
          // ); // Tambahkan pemanggilan saveSession di sini

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("${data.message}"),
          ));
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => PageListBerita()),
            (route) => false,
          );
        });
      } 
      //else if (data.status == 2) {
      //   setState(() {
      //     isLoading = false;
      //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //       content: Text("${data.message}"),
      //     ));
      //   });
      // } 
      else {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("${data.message}"),
          ));
        });
      }
      // if (data.email != null) {
      //   session.saveSession(
      //     data.value ?? 0,
      //     data.id ?? "",
      //     data.name ?? "",
      //     data.email!,
      //   );
      // }
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
        ));
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        centerTitle: true,
        title: Text(
          'Login Form ',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("gambar/2.jpg"), // Ganti dengan path gambar Anda
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: keyForm,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 150),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                        controller: txtUsername,
                        validator: (val) {
                          return val!.isEmpty ? "Tidak Boleh Kosong" : null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Name',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                        controller: txtEmail,
                        validator: (val) {
                          return val!.isEmpty ? "Tidak Boleh Kosong" : null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Email',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  MaterialButton(
                    onPressed: () {
                      //cek kondisi dan get data inputan
                      if (keyForm.currentState?.validate() == true) {
                        //kita panggil function login
                        loginAccount();
                      }
                    },
                    color: Colors.blue,
                    textColor: Colors.white,
                    height: 45,
                    child: Text('Login'),
                  ),
                  SizedBox(height: 170),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: BorderSide(width: 1, color: Colors.green),
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => PageRegister()),
              (route) => false,
            );
          },
          child: Text('Anda Belum Punya Akun ? Silahkan Register'),
        ),
      ),
    );
  }
}
