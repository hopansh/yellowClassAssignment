// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class LoginScreen extends StatelessWidget {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();

//   bool isSignIn = false;
//   bool google = false;
//   User _user;
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;

//     return Scaffold(
//         appBar: AppBar(
//           toolbarHeight: 0,
//         ),
//         body: Container(
//             height: height * 0.9,
//             child: Center(
//                 child: Container(
//               height: height * 0.1,
//               width: double.infinity,
//               margin: EdgeInsets.all(30),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: Colors.deepOrange,
//               ),
//               child: TextButton.icon(
//                   onPressed: () async {
//                     signInWithGoogle().then((value) =>
//                         Navigator.pushReplacementNamed(context, "/"));
//                     // .then((User user) {
//                     //   Navigator.of(context).pushNamedAndRemoveUntil(
//                     //       "/", (Route<dynamic> route) => false);
//                     // }).catchError((e) => print(e));
//                   },
//                   icon: Icon(
//                     Icons.login,
//                     size: 40,
//                     color: Colors.white,
//                   ),
//                   label: Text(
//                     "Login with google",
//                     style: TextStyle(color: Colors.white, fontSize: 24),
//                   )),
//             ))));
//   }

//   Future<String> signInWithGoogle() async {
//     final GoogleSignInAccount account = await _googleSignIn.signIn();
//     final GoogleSignInAuthentication authentication =
//         await account.authentication;

//     final GoogleAuthCredential credential = GoogleAuthProvider.credential(
//         idToken: authentication.idToken,
//         accessToken: authentication.accessToken);

//     final UserCredential authResult =
//         await _auth.signInWithCredential(credential);
//     final User user = authResult.user;
//     print("signedIn $user");
//     return 'signInWithGoogle succeeded: $user';
//   }
// }
