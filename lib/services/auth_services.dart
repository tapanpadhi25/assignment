import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


// tapan2@gmail.com

Future<void> signUpUser(String name, String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    String uid = userCredential.user!.uid;

    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'uid': uid,
      'name': name,
      'email': email,
      'createdAt': Timestamp.now(),
    });
    print('User signed up and data stored in Firestore.');
  } catch (e) {
    print('Error during sign up: $e');
  }
}


Future<void> printUserDetails() async {
  final user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    final uid = user.uid;
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (doc.exists) {
      final data = doc.data();
      print("User details:");
      print("Name: ${data?['name']}");
      print("Email: ${data?['email']}");
      // print other fields if needed
    } else {
      print("No user document found for uid: $uid");
    }
  } else {
    print("User is not logged in");
  }
}


Future<String?> signInUser(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    String uid = userCredential.user!.uid;
    DocumentSnapshot userDoc =
    await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (userDoc.exists) {
      String name = userDoc['name'];
     return "success";
    } else {
      return "failure";
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

// Forgot password
Future<bool> isEmailRegistered(String email) async {
  try {
    final methods =
    await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
    return methods.isNotEmpty;
  } catch (e) {
    print('Error checking email: $e');
    return false;
  }
}

Future<String> updatePassword(String newPassword) async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updatePassword(newPassword);
      print("Password updated successfully.");
      throw "Password updated successfully.";
    } else {
      throw "User is not logged in.";
    }
  } catch (e) {
    throw "Failed to update password: $e";
  }
}

