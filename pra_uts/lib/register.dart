import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pra_uts/login.dart';


import '../model/model_register.dart';



class PageRegister extends StatefulWidget {
  const PageRegister({super.key});

  @override
  State<PageRegister> createState() => _PageRegisterState();
}

class _PageRegisterState extends State<PageRegister> {
  TextEditingController nama = TextEditingController();
  TextEditingController nobp = TextEditingController();
  TextEditingController nohp = TextEditingController();
  TextEditingController email = TextEditingController();

  GlobalKey<FormState> keyform = GlobalKey<FormState>();
  bool isLoading = false;
  bool isPasswordVisible = false;

  Future<void> registerAccount() async {
    if (!keyform.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      http.Response res = await http.post(
        Uri.parse("http://localhost/latihan_uts/daftar.php"),
        body: {
          "nama": nama.text,
          "nobp": nobp.text,
          "nohp": nohp.text,
          "email": email.text,
        },
      );

      ModelRegister data = modelRegisterFromJson(res.body);

      if (data.status == "success") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${data.message}',
              textAlign: TextAlign.center,
            ),
          ),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Login()),
              (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${data.message}',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    } 
    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
            textAlign: TextAlign.center,
          ),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Register Form'),
      ),
      body: Form(
        key: keyform,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: nama,
                  validator: (val) {
                    return val!.isEmpty ? "Nama is required" : null;
                  },
                  decoration: InputDecoration(
                    hintText: "Nama",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: nobp,
                  validator: (val) {
                    return val!.isEmpty ? "No BP is required" : null;
                  },
                  decoration: InputDecoration(
                    hintText: 'No BP',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: nohp,
                  validator: (val) {
                    return val!.isEmpty ? "No HP is Required" : null;
                  },
                  decoration: InputDecoration(
                    hintText: 'No HP',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: email,
                  validator: (val) {
                    return val!.isEmpty ? "Email is Required!" : null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {
                    //cek kondisi & get data inputan
                    if (keyform.currentState?.validate() == true) {
                      //panggil func register
                      registerAccount();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    // backgroundColor: Colors.tealAccent,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 30)),
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Sign Up'),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const Login()),
                    );
                  },
                  child: const Text('Already have an account? Login here'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}