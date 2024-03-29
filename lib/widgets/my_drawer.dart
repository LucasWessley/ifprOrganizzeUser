import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:organizzeuser/auth_screens/auth_screen.dart';
import 'package:organizzeuser/global/global.dart';
import 'package:organizzeuser/models/my_subscriptios_screen.dart';
import 'package:organizzeuser/screens/certificate_screen.dart';

import '../splashScreen/my_splash_screen.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          //CABEÇALHO
          Container(
            padding: EdgeInsets.only(top: 26, bottom: 12),
            child: Column(
              children: [
                Container(
                  height: 120,
                  width: 120,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      sharedPreferences!.getString("photoUrl")!,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                //Nome usuario
                Text(
                  sharedPreferences!.getString("name")!,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),

          //CORPO
          Container(
            padding: EdgeInsets.only(top: 1),
            child: Column(
              children: [
                // Divider(
                //   height: 10,
                //   color: Colors.black,
                //   thickness: 1,
                // ),

                //HOME

                ListTile(
                    leading: Icon(
                      Icons.home,
                      color: Colors.black,
                    ),
                    title: Text(
                      "Home",
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (c) => MySplashScreen()));
                    }),
                // Divider(
                //   height: 10,
                //   color: Colors.black,
                //   thickness: 1,
                // ),

                //Meus Certificados
                ListTile(
                    leading: Icon(
                      Icons.picture_as_pdf_outlined,
                      color: Colors.black,
                    ),
                    title: Text(
                      "Certificados",
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (c) => CertificateScreen()));
                    }),
                ListTile(
                    leading: Icon(
                      Icons.checklist,
                      color: Colors.black,
                    ),
                    title: Text(
                      "Minhas Inscrições",
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      Navigator.push(context,
                      MaterialPageRoute(builder: (c) => MySubsScreen()));
                    }),
                ListTile(
                    leading: Icon(
                      Icons.check,
                      color: Colors.black,
                    ),
                    title: Text(
                      "Validar Presença",
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (c) => MySplashScreen(),
                      //   ),
                      // );
                    }),

                ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    title: Text(
                      "Perfil",
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (c) => MySplashScreen(),
                      //   ),
                      // );
                    }),
                //SAIR
                ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                    title: Text(
                      "Sair",
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (c) => MySplashScreen()));
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
