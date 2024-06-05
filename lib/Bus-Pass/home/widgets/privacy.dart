import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
      // appBar: AppBar(
      //   title: Text('Privacy Policy'),
      // ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: ListView(
          children: <Widget>[
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Privacy Policy',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(39, 66, 129, 1),
                  ),
                ),
              ],
            ),
            // SizedBox(
            //   height: 20,
            // ),
            // Text(
            //   'Privacy Policy',
            //   style: TextStyle(
            //       fontSize: 24,
            //       fontWeight: FontWeight.bold,
            //       color: Color.fromRGBO(39, 66, 129, 1)),
            // ),
            const SizedBox(height: 20),
            const Text(
              'Introduction',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Your privacy is important to us. This privacy policy explains how we collect, use, and protect your information when you use our bus reservation system app.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Information We Collect',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'We collect information that you provide to us directly, such as when you create an account, make a reservation, or contact customer support. This information may include your name, email address, phone number, payment information, and travel details.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'How We Use Your Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'We use your information to provide, maintain, and improve our services. This includes processing your reservations, sending you updates and notifications, and responding to your inquiries.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Sharing Your Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'We do not share your personal information with third parties except as necessary to provide our services, comply with the law, or protect our rights. This may include sharing information with payment processors, transportation providers, and regulatory authorities.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Security',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'We take reasonable measures to protect your information from unauthorized access, disclosure, alteration, and destruction. However, no security system is completely secure, and we cannot guarantee the absolute security of your information.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Your Choices',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'You have the right to access, update, or delete your personal information. You can do this by contacting us at support@example.com. You may also choose to opt-out of receiving marketing communications from us by following the unsubscribe instructions in those communications.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Changes to This Policy',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'We may update this privacy policy from time to time. We will notify you of any changes by posting the new policy on our app and updating the effective date at the top of this policy. We encourage you to review this policy periodically to stay informed about how we are protecting your information.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            // Center(
            //   child: ElevatedButton(
            //     onPressed: () {
            //       // Add your navigation to the main page or other functionality here
            //     },
            //     child: Text('Back to Home'),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
