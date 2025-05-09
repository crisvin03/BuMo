import 'package:BuMo/screens/driver-side/driver_maps_screen.dart';
import 'package:BuMo/screens/rider-side/rider_maps_screen.dart';
import 'package:BuMo/screens/registration/register_number_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _addDefaultAccounts();
  }

  /// Adds default driver & rider accounts if they don't exist
  Future<void> _addDefaultAccounts() async {
    final defaultUsers = [
      {
        "email": "driver@test.com",
        "password": "driver123",
        "firstName": "Test",
        "lastName": "Driver",
        "phoneNumber": "09123456789",
        "userType": "driver"
      },
      {
        "email": "rider@test.com",
        "password": "rider123",
        "firstName": "Test",
        "lastName": "Rider",
        "phoneNumber": "09876543210",
        "userType": "rider"
      }
    ];

    for (var user in defaultUsers) {
      try {
        var existingUser =
            await _auth.fetchSignInMethodsForEmail(user['email']!);
        if (existingUser.isEmpty) {
          // Create user in Firebase Auth
          UserCredential newUser = await _auth.createUserWithEmailAndPassword(
            email: user['email']!,
            password: user['password']!,
          );

          // Save user details in Firestore
          await _firestore.collection("users").doc(newUser.user!.uid).set({
            "emailID": user['email'],
            "firstName": user['firstName'],
            "lastName": user['lastName'],
            "phoneNumber": user['phoneNumber'],
            "userID": newUser.user!.uid,
            "userType": user['userType'],
          });

          debugPrint(
              "✅ User added: ${user['email']} with UID ${newUser.user!.uid}");
        } else {
          debugPrint("⚠️ User already exists: ${user['email']}");
        }
      } catch (e) {
        debugPrint("❌ Error adding default user: $e");
      }
    }
  }

  /// Handles user sign-in and redirects based on role
  Future<void> _signIn() async {
    setState(() => isLoading = true);

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      String userId = userCredential.user!.uid;
      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists && userDoc.data() != null) {
        String userType = userDoc.data()!['userType'];

        if (userType == "driver") {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => DriverMapsScreen(driverID: userId),
              ));
        } else if (userType == "rider") {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => RiderMapsScreen(passengerID: userId),
              ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Unknown user type")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("❌ User data not found in Firestore")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Login failed: ${e.toString()}")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 14, right: 14),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/images/BuMo.png'),
                  const SizedBox(height: 10),
                  Text('Welcome',
                      style: Theme.of(context).textTheme.headlineMedium),
                  Text(
                      'Welcome to BuMo Ride! Easy and safe ride-sharing in Bulan, Sorsogon.',
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
              const SizedBox(height: 30),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.direct_right),
                        labelText: 'Email',
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.password_check),
                        labelText: 'Password',
                        suffixIcon: Icon(Iconsax.eye_slash),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : _signIn,
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text('Sign In'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const SignUpScreen();
                          }));
                        },
                        child: const Text('Create Account'),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
