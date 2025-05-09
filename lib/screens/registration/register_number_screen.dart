import 'package:BuMo/screens/registration/number_verification_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PhoneNumber number = PhoneNumber(isoCode: 'PH');
    final TextEditingController controller = TextEditingController();
    PhoneNumber inputtedNumber = PhoneNumber();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  "Enter your mobile number",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 10),

                // Form Text Fields
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Phone Number Input
                    InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        inputtedNumber = number;
                      },
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        useBottomSheetSafeArea: true,
                      ),
                      hintText: null,
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: const TextStyle(color: Colors.black),
                      initialValue: number,
                      textFieldController: controller,
                      formatInput: true,
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: IntrinsicWidth(
          child: Row(
            children: [
              const Text(
                'We\'re sending you a verification PIN to your mobile \nnumber. We use your number to allow bikers \nand customer service to contact you about bookings.',
                style: TextStyle(fontSize: 10, color: Colors.grey),
                softWrap: true,
              ),
              const SizedBox(width: 30),

              // OTP Verification Button
              InkWell(
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
                onTap: () async {
                  if (inputtedNumber.phoneNumber == null ||
                      inputtedNumber.phoneNumber!.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter a valid phone number."),
                      ),
                    );
                    return;
                  }

                  print("📱 Sending OTP to: ${inputtedNumber.phoneNumber}");

                  try {
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: inputtedNumber.phoneNumber!,
                      verificationCompleted: (PhoneAuthCredential credential) {
                        print("✅ Auto-verification completed.");
                      },
                      verificationFailed: (FirebaseAuthException e) {
                        print("❌ Verification failed: ${e.message}");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Verification failed: ${e.message}"),
                          ),
                        );
                      },
                      codeSent: (String verificationId, int? resendToken) {
                        print("📩 OTP sent! Verification ID: $verificationId");

                        // Navigate to OTP verification screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerificationScreen(
                              verificationID: verificationId,
                              phoneNumber: inputtedNumber.phoneNumber!,
                            ),
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("OTP has been sent to your number."),
                          ),
                        );
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {
                        print("⏳ Auto-retrieval timeout: $verificationId");
                      },
                    );
                  } catch (error) {
                    print("🚨 Error: $error");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error: $error")),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
