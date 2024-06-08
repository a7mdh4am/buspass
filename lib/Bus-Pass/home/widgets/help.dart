import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 241, 241, 1),
      // appBar: AppBar(
      //   title: Text('Help & Support'),
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
                  'Contact Us',
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
            //   'Contact Us',
            //   style: TextStyle(
            //       fontSize: 24,
            //       fontWeight: FontWeight.bold,
            //       color: Color.fromRGBO(39, 66, 129, 1)),
            // ),
            const SizedBox(height: 20),
            const Text(
              'If you need any help, Catch Us:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Row(
              children: <Widget>[
                Icon(Icons.email, size: 25),
                SizedBox(width: 10),
                Text(
                  'Email: bpass1539@gmail.com',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Row(
              children: <Widget>[
                Icon(Icons.phone, size: 25),
                SizedBox(width: 10),
                Text(
                  'Phone: +20 122 273 3443',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 40),
            // Center(
            //   child: ElevatedButton(
            //     onPressed: () {
            //       Navigator.pop(context);
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
