import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/email_provider.dart'; // Import your EmailProvider
import 'send_mail_screen.dart';
import 'profile_screen.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // List of widgets for each screen
  static const List<Widget> _widgetOptions = <Widget>[
    HomeContent(),
    SendMailScreen(),
    ProfileScreen(),
  ];

  // List of titles for each screen
  static const List<String> _titles = <String>[
    'Home',
    'Send Mail',
    'Profile',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(_titles[_selectedIndex],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)), // Change title based on selected index
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Send Mail',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

// Home content widget
class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  @override
  void initState() {
    super.initState();
    // Schedule the fetchEmails call after the current frame has completed.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Call your fetchEmails method here.
      Provider.of<EmailProvider>(context, listen: false).fetchEmails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EmailProvider>(
      builder: (context, emailProvider, child) {
        if (emailProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (emailProvider.emails.isEmpty) {
          return const Center(child: Text('No emails found.'));
        } else {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.deepPurpleAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: AnimatedList(
              key: _listKey,
              initialItemCount: emailProvider.emails.length,
              itemBuilder: (context, index, animation) {
                final email = emailProvider.emails[index];
                return _buildEmailCard(email, animation);
              },
            ),
          );
        }
      },
    );
  }

  Widget _buildEmailCard(Map<String, dynamic> email, Animation<double> animation) {
    // Parse the dateTime string into a DateTime object
    DateTime dateTime = DateTime.parse(email['dateTime']);

    // Format the date and time
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    String formattedTime = DateFormat('hh:mm a').format(dateTime); // 12-hour format

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(animation),
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Colors.deepPurple, width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Email subject
                    Expanded(
                      child: Text(
                        email['subject'],
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    // Date and Time
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.calendar_today, color: Colors.orangeAccent), // Icon for date
                            const SizedBox(width: 10),
                            Text(formattedDate),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.access_time, color: Colors.purpleAccent), // Icon for time
                            const SizedBox(width: 30),
                            Text(formattedTime),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Recipient
                Row(
                  children: [
                    Icon(Icons.person, color: Colors.blueAccent),
                    const SizedBox(width: 5),
                    Text(email['recipient']),
                  ],
                ),
                const SizedBox(height: 5),
                // Message Body
                Row(
                  children: [
                    Icon(Icons.message, color: Colors.greenAccent),
                    const SizedBox(width: 5),
                    Expanded(child: Text(email['msgBody'], maxLines: 3, overflow: TextOverflow.ellipsis)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
