import 'package:flutter/material.dart';
import '../Models/user_model.dart';
import '../Service/api_service.dart';
import 'user_form_screen.dart';
import 'user_detail_screen.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final ApiService _api = ApiService();

  List<User> _allUsers = [];
  List<User> _filtered = [];

  final TextEditingController _searchCtrl = TextEditingController();

  bool _loading = true;
  bool _ascending = true;
  bool _isGrid = false;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  // ── Cargar usuarios ──
  Future<void> _loadUsers() async {
    setState(() => _loading = true);
    try {
      final users = await _api.getUsers();
      setState(() {
        _allUsers = users;
        _filtered = users;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      _showError('Error al cargar usuarios');
    }
  }

  // ── Buscar ──
  void _onSearch() {
    final query = _searchCtrl.text.toLowerCase();

    setState(() {
      _filtered = _allUsers
          .where((u) => u.name.toLowerCase().contains(query))
          .toList();
    });
  }

  // ── Ordenar ──
  void _toggleSort() {
    setState(() {
      _ascending = !_ascending;

      _filtered.sort(
        (a, b) => _ascending
            ? a.name.compareTo(b.name)
            : b.name.compareTo(a.name),
      );
    });
  }

  // ── Abrir formulario ──
  Future<void> _openForm([User? user]) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UserFormScreen(user: user),
      ),
    );

    if (result == true) _loadUsers();
  }

  // ── Eliminar usuario ──
  Future<void> _deleteUser(User user) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar usuario'),
        content: Text('¿Eliminar a ${user.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Eliminar',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await _api.deleteUser(user.id!);
        _loadUsers();
      } catch (e) {
        _showError('No se pudo eliminar el usuario');
      }
    }
  }

  // ── Mostrar error ──
  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              _ascending ? Icons.sort_by_alpha : Icons.sort,
            ),
            tooltip: _ascending ? 'Orden Z→A' : 'Orden A→Z',
            onPressed: _toggleSort,
          ),
          IconButton(
            icon: Icon(_isGrid ? Icons.list : Icons.grid_view),
            tooltip: _isGrid
                ? 'Vista de lista'
                : 'Vista de cuadrícula',
            onPressed: () =>
                setState(() => _isGrid = !_isGrid),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // ── Buscador ──
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    controller: _searchCtrl,
                    onChanged: (_) => _onSearch(),
                    decoration: InputDecoration(
                      hintText: 'Buscar por nombre...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon:
                          _searchCtrl.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    _searchCtrl.clear();
                                    _onSearch();
                                  },
                                )
                              : null,
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(10),
                      ),
                      filled: true,
                    ),
                  ),
                ),

                // ── Lista / Grid ──
                Expanded(
                  child: _filtered.isEmpty
                      ? const Center(
                          child: Text('Sin resultados'),
                        )
                      : _isGrid
                          ? GridView.builder(
                              padding:
                                  const EdgeInsets.all(12),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 0.85,
                              ),
                              itemCount: _filtered.length,
                              itemBuilder: (_, i) {
                                final u = _filtered[i];

                                return Card(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment
                                            .center,
                                    children: [
                                      CircleAvatar(
                                        radius: 28,
                                        backgroundColor:
                                            Colors.teal,
                                        child: Text(
                                          u.name[0]
                                              .toUpperCase(),
                                          style:
                                              const TextStyle(
                                            color:
                                                Colors.white,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                          height: 10),
                                      Text(
                                        u.name,
                                        textAlign:
                                            TextAlign.center,
                                        style:
                                            const TextStyle(
                                          fontWeight:
                                              FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                      const SizedBox(
                                          height: 4),
                                      Text(
                                        u.email,
                                        textAlign:
                                            TextAlign.center,
                                        style:
                                            const TextStyle(
                                          fontSize: 11,
                                          color:
                                              Colors.grey,
                                        ),
                                        overflow:
                                            TextOverflow
                                                .ellipsis,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          : RefreshIndicator(
                              onRefresh: _loadUsers,
                              color: Colors.teal,
                              child: ListView.builder(
                                physics:
                                    const AlwaysScrollableScrollPhysics(),
                                itemCount:
                                    _filtered.length,
                                itemBuilder: (_, i) {
                                  final user =
                                      _filtered[i];

                                  return Card(
                                    margin:
                                        const EdgeInsets
                                            .symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    child: ListTile(
                                      leading:
                                          CircleAvatar(
                                        backgroundColor:
                                            Colors.teal,
                                        child: Text(
                                          user.name[0]
                                              .toUpperCase(),
                                          style:
                                              const TextStyle(
                                            color: Colors
                                                .white,
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        user.name,
                                        style:
                                            const TextStyle(
                                          fontWeight:
                                              FontWeight
                                                  .bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                          user.email),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                UserDetailScreen(
                                              user: user,
                                            ),
                                          ),
                                        );
                                      },
                                      trailing: Row(
                                        mainAxisSize:
                                            MainAxisSize
                                                .min,
                                        children: [
                                          IconButton(
                                            icon:
                                                const Icon(
                                              Icons.edit,
                                              color: Colors
                                                  .blue,
                                            ),
                                            onPressed: () =>
                                                _openForm(
                                                    user),
                                          ),
                                          IconButton(
                                            icon:
                                                const Icon(
                                              Icons.delete,
                                              color: Colors
                                                  .red,
                                            ),
                                            onPressed: () =>
                                                _deleteUser(
                                                    user),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                ),
              ],
            ),
    );
  }
}