import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50], // Light background color
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Photo
              Center(
                child: ClipOval(
                  child: Image.network(
                    'https://via.placeholder.com/150', // Placeholder image
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, size: 50, color: Colors.white),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // First Name
              _buildProfileField(
                icon: Icons.person,
                title: 'First Name',
                value: 'John',
              ),
              const SizedBox(height: 10),

              // Last Name
              _buildProfileField(
                icon: Icons.person_outline,
                title: 'Last Name',
                value: 'Doe',
              ),
              const SizedBox(height: 10),

              // Email
              _buildProfileField(
                icon: Icons.email,
                title: 'Email',
                value: 'johndoe@example.com',
              ),
              const SizedBox(height: 10),

              // Phone Number
              _buildProfileField(
                icon: Icons.phone,
                title: 'Phone Number',
                value: '+1 (234) 567-8901',
              ),
              const SizedBox(height: 10),

              // Address
              _buildProfileField(
                icon: Icons.home,
                title: 'Address',
                value: '123 Main St, Springfield, USA',
              ),
              const SizedBox(height: 20),

              // Additional Info Section
              _buildProfileField(
                icon: Icons.info,
                title: 'Additional Info',
                value:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileField({required IconData icon, required String title, required String value}) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.deepPurple, Colors.purpleAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.transparent, // Make card background transparent to show gradient
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 30, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(
                      value,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
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
