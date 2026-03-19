import 'package:flutter/material.dart';
import '../Models/user_model.dart';
import '../Service/api_service.dart';

class UserFormScreen extends StatefulWidget {
  final User? user; // null = crear, distinto de null = editar

  const UserFormScreen({super.key, this.user});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService _api = ApiService();

  late TextEditingController _nameCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _phoneCtrl;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    // Si hay usuario, pre-llenar los campos
    _nameCtrl  = TextEditingController(text: widget.user?.name  ?? '');
    _emailCtrl = TextEditingController(text: widget.user?.email ?? '');
    _phoneCtrl = TextEditingController(text: widget.user?.phone ?? '');
  }

  @override
  void dispose() {
    // Liberar memoria de los controladores
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  // Guarda: crea o actualiza según el caso
  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);

    final newUser = User(
      id:    widget.user?.id,
      name:  _nameCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      phone: _phoneCtrl.text.trim(),
    );

    try {
      if (widget.user == null) {
        await _api.createUser(newUser);
      } else {
        await _api.updateUser(newUser);
      }
      if (mounted) Navigator.pop(context, true); // true = hubo cambios
    } catch (e) {
      setState(() => _saving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al guardar'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.user != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Usuario' : 'Nuevo Usuario'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // ── Campo Nombre ──
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nombre completo',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                  validator: (v) {
                    if (v == null || v.trim().length < 3)
                      return 'Mínimo 3 caracteres';
                    if (!RegExp(r'^[a-zA-ZÀ-ÿ\s]+$').hasMatch(v))
                      return 'Solo letras y espacios';
                    return null;
                  },
              ), 
                const SizedBox(height: 16),

              // ── Campo Email ──
              TextFormField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Correo electrónico',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Campo requerido';
                  if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,}$').hasMatch(v))
                    return 'Correo inválido';
                  return null;
                },
              ),  
              const SizedBox(height: 16),

              // ── Campo Teléfono ──
              TextFormField(
                controller: _phoneCtrl,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Teléfono',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                if (v == null || v.length < 7) return 'Mínimo 7 dígitos';
                  if (!RegExp(r'^[\d\s\-\(\)]+$').hasMatch(v))
                    return 'Solo números, guiones y paréntesis';
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // ── Botón Guardar ──
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saving ? null : _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                  ),
                  child: _saving
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(isEditing ? 'Actualizar' : 'Crear Usuario', style: const TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}