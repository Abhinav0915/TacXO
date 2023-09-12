import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../util/appbar.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  final TextEditingController _nameController = TextEditingController();
  String enteredName = '';

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF011627),
      appBar: MyAppBar(
        title: 'TacXO',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Enter Your Name',
              style: TextStyle(
                fontFamily: GoogleFonts.blackOpsOne().fontFamily,
                fontSize: 24.0,
                letterSpacing: 3.0,
                fontWeight: FontWeight.bold,
                color: Colors.green,

              ),
            ),
            const SizedBox(height:40.0),
            TextField(

              controller: _nameController,
              onChanged: (value) {
                setState(() {
                  enteredName = value;
                });
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Enter your name',
                labelStyle: TextStyle(
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  fontSize: 20.0,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                        _nameController.clear();
                    },

                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      padding: const EdgeInsets.all(16.0),
                    ),
                    child:  const Text(
                      'Reset',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: enteredName.isNotEmpty
                        ? () {
                      Navigator.pushNamed(
                        context,
                        '/game',
                        arguments: enteredName,
                      );
                    }
                        : null, // Disable the button when enteredName is empty
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.all(16.0),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),


              ],
            )


          ],
        ),
      ),
    );
  }
}
