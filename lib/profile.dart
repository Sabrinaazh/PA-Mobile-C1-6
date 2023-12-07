import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petshop/Auth.dart';
import 'package:petshop/Login.dart';



class Profile extends StatefulWidget {
  const Profile({Key? key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? _user;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((User? user) {
      setState(() {
        _user = user;
      });
    });
  }

  Future<void> _showEditProfileDialog(BuildContext context) async {
    TextEditingController usernameController = TextEditingController();
    usernameController.text = _user != null ? _user!.displayName ?? '' : '';

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Edit Profile',
            style: GoogleFonts.secularOne(),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_user != null)
                TextFormField(
                  controller: usernameController,
                  inputFormatters: [LengthLimitingTextInputFormatter(25)],
                  decoration: InputDecoration(
                    hintText: 'Username',
                    prefixIcon: Icon(Icons.person),
                    prefixIconColor: Color(0xFF255e36),
                  ),
                ),
              SizedBox(height: 16),
              Text(
                'Are you sure you want to edit your profile?',
                style: GoogleFonts.inter(),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(),
              ),
            ),
            TextButton(
              onPressed: () async {
                // Update username
                await _updateUsername(usernameController.text);

                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Save',
                style: GoogleFonts.inter(),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateUsername(String newUsername) async {
    try {
      await _user!.updateProfile(displayName: newUsername);
      setState(() {
        _user = FirebaseAuth.instance.currentUser;
      });
    } catch (e) {
      print("Error updating username: $e");
    }
  }

  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Logout Confirmation',
            style: GoogleFonts.secularOne(),
          ),
          content: Text(
            'Are you sure you want to log out?',
            style: GoogleFonts.inter(),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(),
              ),
            ),
            TextButton(
              onPressed: () async {
                await Auth().signOut();
                // Navigate to the login page when log out is confirmed
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Login()),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text(
                'Logout',
                style: GoogleFonts.inter(),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 242, 255),
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 90, 83, 170),
        ),
        title: Text(
          "Profile",
          style: GoogleFonts.secularOne(
            textStyle: TextStyle(
              color: Color.fromARGB(255, 90, 83, 170),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: InkWell(
              onTap: () => _showEditProfileDialog(context),
              child: Text(
                'Edit',
                style: TextStyle(
                  color: Color.fromARGB(255, 90, 83, 170),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () => _showLogoutConfirmationDialog(context),
            icon: Icon(
              Icons.logout,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _isDarkMode = !_isDarkMode;
              });
              // Call a function to handle the toggle of dark mode
              _toggleDarkMode();
            },
            icon: Icon(
              _isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 8, right: 8),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background/bg2-icon.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'My Account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage('assets/tanoo.jpg'),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    _user != null ? _user!.displayName ?? 'Tamu' : 'Tamu',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    _user != null
                        ? _user!.email ?? 'Email not available'
                        : 'Email not available',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildAccountOptionRow(
      BuildContext context, String title, String content) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (content == 'changeUsername')
                    AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(25)
                            ],
                            decoration: InputDecoration(
                              hintText: 'Nama',
                              prefixIcon: Icon(Icons.person),
                              prefixIconColor: Color(0xFF255e36),
                            ),
                          )
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Batal'),
                        ),
                        TextButton(onPressed: () {}, child: Text('Ubah')),
                      ],
                    )
                  else if (content == 'changeTheme')
                    Text('Menu ganti tema')
                  else
                    Text('Belum dipasang')
                ],
              ),
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.green[600],
              ),
            ),
            Icon(
              Icons.arrow_back_outlined,
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  // Function to handle toggling dark mode
  void _toggleDarkMode() {
    // Implement your dark mode toggle logic here
    // You can use packages like 'provider' to manage the app's state
    // and toggle the dark mode accordingly.
    // Example:
    // Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
    // Note: You need to set up the 'ThemeProvider' accordingly in your app.
  }
}
