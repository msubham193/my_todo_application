import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todoapp/pages/Home.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Auth {
  // var currentUser = FirebaseAuth.instance.currentUser!.email;
  GoogleSignIn googlesignin = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final storage = new FlutterSecureStorage();
  Future<void> googleSignin(BuildContext context) async {
    try {
      GoogleSignInAccount? googlesigninaccount = await googlesignin.signIn();

      if (googlesigninaccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googlesigninaccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);

        try {
          UserCredential userCredential =
              await firebaseAuth.signInWithCredential(credential);

          storeTokenData(userCredential);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => HomePage()),
              (route) => false);
        } catch (e) {
          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      } else {
        // ignore: prefer_const_constructors
        final snackbar = SnackBar(content: Text("server error !"));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    } catch (e) {
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  Future<void> storeTokenData(UserCredential userCredential) async {
    await storage.write(
        key: "Token", value: userCredential.credential!.token.toString());
     await storage.write(
         key: "userCredential", value: userCredential.toString());
    // await storage.write(key: "Email", value: currentUser);
  }

  Future<String?> getToken() async {
    return await storage.read(key: "Token");
  }

  Future<void> logout() async {
    try {
      await googlesignin.signOut();
      await firebaseAuth.signOut();
      await storage.delete(key: "Token");
    } catch (e) {}
  }

  Future<String?> getEmail() async {
    return await storage.read(key: "Email");
  }
}
