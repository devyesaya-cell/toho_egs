import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/person.dart';
import '../../../../core/models/contractor.dart';
import '../../../../core/repositories/app_repository.dart';
import '../../../../core/state/auth_state.dart';

class PersonEditDialog extends ConsumerStatefulWidget {
  final Person person;

  const PersonEditDialog({super.key, required this.person});

  @override
  ConsumerState<PersonEditDialog> createState() => _PersonEditDialogState();
}

class _PersonEditDialogState extends ConsumerState<PersonEditDialog> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _driverIdController;
  late TextEditingController _passwordController;
  // Url controller is used for custom input if needed, but we mainy use selection
  late TextEditingController _picUrlController;
  // Contractor controller for text is replaced by selection state
  String? _selectedContractor;
  String? _selectedPicUrl;

  final List<String> _availableImages = [
    'images/driver_exca.png',
    'images/ic_supir.png',
    'images/setup_driver.png',
    'images/mng_1.png',
    'images/ic_setProfile.png',
  ];

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.person.firstName);
    _lastNameController = TextEditingController(text: widget.person.lastName);
    _driverIdController = TextEditingController(text: widget.person.driverID);
    _passwordController = TextEditingController(text: widget.person.password);
    _picUrlController = TextEditingController(text: widget.person.picURL);

    _selectedContractor = widget.person.kontraktor;
    _selectedPicUrl = widget.person.picURL;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _driverIdController.dispose();
    _passwordController.dispose();
    _picUrlController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final updatedPerson = widget.person
      ..firstName = _firstNameController.text
      ..lastName = _lastNameController.text
      ..driverID = _driverIdController.text
      ..password = _passwordController.text
      ..picURL = _selectedPicUrl
      ..kontraktor = _selectedContractor;

    // Save to DB
    await ref.read(appRepositoryProvider).savePerson(updatedPerson);

    // Update Auth State if necessary
    final authNotifier = ref.read(authProvider.notifier);
    final currentUser = ref.read(authProvider).currentUser;
    if (currentUser?.uid == updatedPerson.uid) {
      authNotifier.login(updatedPerson, ref.read(authProvider).mode);
    }

    if (mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF1E293B),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(24),
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Edit Profile',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildTextField('First Name', _firstNameController),
                    _buildTextField('Last Name', _lastNameController),
                    _buildTextField('Driver ID', _driverIdController),

                    // Contractor Dropdown
                    _buildContractorDropdown(),

                    const SizedBox(height: 16),
                    // Image Selection
                    _buildImageSelection(),

                    const SizedBox(height: 16),
                    _buildTextField(
                      'Password',
                      _passwordController,
                      obscureText: true,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white54),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Save Changes'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContractorDropdown() {
    return FutureBuilder<List<Contractor>>(
      future: ref.read(appRepositoryProvider).getAllContractors(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const LinearProgressIndicator();
        }
        final contractors = snapshot.data!;

        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Contractor',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              const SizedBox(height: 4),
              DropdownButtonFormField<String>(
                value: _selectedContractor,
                dropdownColor: const Color(0xFF1E293B),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black26,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                ),
                items: contractors.map((c) {
                  return DropdownMenuItem<String>(
                    value: c.name,
                    child: Text(c.name ?? 'Unknown'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedContractor = value;
                  });
                },
                hint: const Text(
                  'Select Contractor',
                  style: TextStyle(color: Colors.white38),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImageSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Profile Picture',
          style: TextStyle(color: Colors.white70, fontSize: 12),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 70,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _availableImages.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final imagePath = _availableImages[index];
              final isSelected = _selectedPicUrl == imagePath;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedPicUrl = imagePath;
                  });
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    border: isSelected
                        ? Border.all(color: Colors.greenAccent, width: 3)
                        : Border.all(color: Colors.white12, width: 1),
                    borderRadius: BorderRadius.circular(30), // Circle
                    color: Colors.black26,
                  ),
                  padding: const EdgeInsets.all(4), // Spacing for border
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.error, color: Colors.red, size: 20),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool obscureText = false,
    String? hint,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 4),
          TextField(
            controller: controller,
            obscureText: obscureText,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.black26,
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.white12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
