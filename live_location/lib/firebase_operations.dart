

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<int> login(String email, String password) async {
  try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email ,
      password: password,
    );
    return 1;
  }
  on FirebaseAuthException catch (e) {
    print(e.code);
    if(e.code == "network-request-failed"){
      return -1;
    }
    else{
      return -2;
    }

  }
}

Future<String> signUp(String userEmail, String userPassword, String wardNumber) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: userEmail,
      password: userPassword,
    );

    User? user = userCredential.user;

    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'email': userEmail,
        'ward_number': int.parse(wardNumber),
      });
    }
    return "1";
  } catch (e) {
    print(e.toString());
    return e.toString();
  }
}

Future<Map<String, dynamic>> fetchCombinedData() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Map<String, dynamic> user = await fetchCurrentUserData() ;

  final vehicleSnapshot = await firestore
      .collection('vehicles')
      .where('ward_no', isEqualTo: user['ward_number'])
      .get();
  final wardSnapshot = await firestore.collection('wards').get();

  final vehicles = vehicleSnapshot.docs.map((doc) {
    return  Map<String, dynamic>.from(doc.data() as Map);
  }).toList();

  final wardsMap = Map.fromEntries(
    wardSnapshot.docs.map((doc) {
      final data = Map<String, dynamic>.from(doc.data() as Map); // Safely cast to Map<String, dynamic>
      return MapEntry(
        data['number'].toString(),  // Ensure ward_no is a String
        data['name'].toString(), // Ensure ward_name is a String
      );
    }),
  );

  return {
    'vehicles': vehicles,
    'wards': wardsMap,
  };
}

Future<Map<String, dynamic>> fetchCurrentUserData() async {
  final User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    final userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (userSnapshot.exists) {
      final userData = userSnapshot.data() as Map<String, dynamic>;
      print("User data: $userData");
      return userData;
    } else {
      print("User document does not exist.");
    }
  } else {
    print("No user is logged in.");
  }
  return Map();
}

