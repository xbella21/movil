import 'package:flutter/material.dart';
import '../Models/user_model.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;
  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de usuario'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // ── Cabecera con avatar ──
          Container(
            width: double.infinity,
            color: Colors.teal,
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Text(
                    user.name[0].toUpperCase(),
                    style: const TextStyle(fontSize: 32, color: Colors.teal),
                  ),
                ),
                const SizedBox(height: 10),
                Text(user.name,
                    style: const TextStyle(color: Colors.white,
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),

          // ── Datos del usuario ──
          ListTile(
            leading: const Icon(Icons.email, color: Colors.teal),
            title: const Text('Email'),
            subtitle: Text(user.email),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.phone, color: Colors.teal),
            title: const Text('Teléfono'),
            subtitle: Text(user.phone),
          ),
        ],
      ),
    );
  }
}