import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controllers/auth_controller.dart';
import '../controllers/note_controller.dart';
import '../models/note_model.dart';
import '../utils/constants.dart';
import 'add_note_page.dart';
import 'edit_note_page.dart';
import 'profile_page.dart';
import 'about_page.dart';

/// DashboardPage - Main page dengan bottom navigation
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  // Pages untuk bottom navigation
  final List<Widget> _pages = [
    const NotesPage(),
    const ProfilePage(),
    const AboutPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF0061A4),
        unselectedItemColor: const Color(0xFF707883),
        selectedLabelStyle: const TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w400,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.note_alt_outlined),
            activeIcon: Icon(Icons.note_alt),
            label: 'Catatan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            activeIcon: Icon(Icons.info),
            label: 'Tentang Kami',
          ),
        ],
      ),
    );
  }
}

/// NotesPage - Halaman daftar catatan
class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final AuthController _authController = AuthController();
  final NoteController _noteController = NoteController();
  final TextEditingController _searchController = TextEditingController();
  
  List<NoteModel> _notes = [];
  String _selectedCategory = 'Semua';
  String _selectedSort = 'Latest';
  bool _isLoading = true;
  bool _isSearching = false;
  int? _currentUserId;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    
    _currentUserId = await _authController.getCurrentUserId();
    if (_currentUserId != null) {
      await _loadNotes();
    }
    
    setState(() => _isLoading = false);
  }

  Future<void> _loadNotes() async {
    if (_currentUserId == null) return;
    
    List<NoteModel> notes;
    
    // Jika sedang search, gunakan search method
    if (_isSearching && _searchController.text.isNotEmpty) {
      notes = await _noteController.searchNotes(
        userId: _currentUserId!,
        keyword: _searchController.text,
        category: _selectedCategory == 'Semua' ? null : _selectedCategory,
        sortBy: _selectedSort,
      );
    } else {
      // Jika tidak search, load notes biasa
      notes = await _noteController.getNotesFiltered(
        userId: _currentUserId!,
        category: _selectedCategory == 'Semua' ? null : _selectedCategory,
        sortBy: _selectedSort,
      );
    }
    
    setState(() => _notes = notes);
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        _loadNotes();
      }
    });
  }

  void _onSearchChanged(String value) {
    // Debounce search untuk performa lebih baik
    Future.delayed(const Duration(milliseconds: 300), () {
      if (value == _searchController.text) {
        _loadNotes();
      }
    });
  }

  Future<void> _deleteNote(int noteId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Catatan'),
        content: const Text('Apakah Anda yakin ingin menghapus catatan ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await _noteController.deleteNote(noteId);
      await _loadNotes();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Catatan berhasil dihapus')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Cari catatan...',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                onChanged: _onSearchChanged,
              )
            : const Text(
                'Catatan Saya',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
        actions: [
          // Search Button
          IconButton(
            icon: Icon(
              _isSearching ? Icons.close : Icons.search,
              color: Colors.white,
            ),
            onPressed: _toggleSearch,
          ),
          // Sort Button
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort, color: Colors.white),
            onSelected: (value) {
              setState(() => _selectedSort = value);
              _loadNotes();
            },
            itemBuilder: (context) => AppConstants.sortOptions
                .map((sort) => PopupMenuItem(
                      value: sort,
                      child: Row(
                        children: [
                          if (_selectedSort == sort)
                            const Icon(Icons.check, size: 20, color: AppColors.primary),
                          if (_selectedSort == sort) const SizedBox(width: 8),
                          Text(sort),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Category Filter
                _buildCategoryFilter(),
                
                // Notes List
                Expanded(
                  child: _notes.isEmpty
                      ? _buildEmptyState()
                      : _buildNotesList(),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNotePage()),
          ).then((_) => _loadNotes());
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: AppConstants.categories.map((category) {
            final isSelected = _selectedCategory == category;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(category),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() => _selectedCategory = category);
                  _loadNotes();
                },
                backgroundColor: Colors.white,
                selectedColor: AppColors.getCategoryColor(category).withValues(alpha: 0.2),
                labelStyle: TextStyle(
                  color: isSelected
                      ? AppColors.getCategoryColor(category)
                      : AppColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
                side: BorderSide(
                  color: isSelected
                      ? AppColors.getCategoryColor(category)
                      : AppColors.border,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _isSearching ? Icons.search_off : Icons.note_add_outlined,
            size: 64,
            color: AppColors.textSecondary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            _isSearching ? 'Catatan tidak ditemukan' : 'Belum ada catatan',
            style: AppTextStyles.subtitle.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _isSearching
                ? 'Coba dengan kata kunci lain'
                : 'Tap tombol + untuk menambah catatan',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _notes.length,
      itemBuilder: (context, index) {
        final note = _notes[index];
        return _buildNoteCard(note);
      },
    );
  }

  Widget _buildNoteCard(NoteModel note) {
    final dateFormat = DateFormat('dd MMM yyyy, HH:mm');
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditNotePage(note: note),
            ),
          ).then((_) => _loadNotes());
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      note.title,
                      style: AppTextStyles.noteTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                    onPressed: () => _deleteNote(note.id!),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                note.content,
                style: AppTextStyles.noteContent,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.getCategoryColor(note.category).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      note.category,
                      style: TextStyle(
                        color: AppColors.getCategoryColor(note.category),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    dateFormat.format(note.createdAt),
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
