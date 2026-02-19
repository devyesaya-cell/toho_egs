import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/person.dart';
import '../../../../core/models/contractor.dart';
import '../../../../core/models/equipment.dart';
import '../../../../core/repositories/app_repository.dart';
import '../../../../core/state/auth_state.dart';

class PersonEditDialog extends ConsumerStatefulWidget {
  final Person? person;

  const PersonEditDialog({super.key, this.person});

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
  String? _selectedEquipment;
  String? _selectedPicUrl;
  String? _selectedRole;

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
    _firstNameController = TextEditingController(
      text: widget.person?.firstName ?? '',
    );
    _lastNameController = TextEditingController(
      text: widget.person?.lastName ?? '',
    );
    _driverIdController = TextEditingController(
      text: widget.person?.driverID ?? '',
    );
    _passwordController = TextEditingController(
      text: widget.person?.password ?? '',
    );
    _picUrlController = TextEditingController(
      text: widget.person?.picURL ?? '',
    );

    _selectedContractor = widget.person?.kontraktor;
    _selectedEquipment = widget.person?.equipment;
    _selectedPicUrl = widget.person?.picURL;
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
    final personToSave = widget.person ?? Person();
    final uid = DateTime.now().millisecondsSinceEpoch.toString();

    personToSave
      ..firstName = _firstNameController.text
      ..lastName = _lastNameController.text
      ..driverID = _driverIdController.text
      ..password = _passwordController.text
      ..picURL = _selectedPicUrl
      ..kontraktor = _selectedContractor
      ..equipment = _selectedEquipment
      ..role = _selectedRole
      ..preset = ref.read(authProvider).mode.name
      ..lastLogin = DateTime.now().millisecondsSinceEpoch
      ..loginState = 'ON'
      ..user = _firstNameController.text.toLowerCase()
      ..uid = uid;

    // Save to DB
    await ref.read(appRepositoryProvider).savePerson(personToSave);

    // Update Auth State if necessary
    final authNotifier = ref.read(authProvider.notifier);
    final currentUser = ref.read(authProvider).currentUser;
    if (currentUser?.uid == personToSave.uid) {
      authNotifier.login(personToSave, ref.read(authProvider).mode);
    }

    if (mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.person == null
                ? 'Person created successfully'
                : 'Profile updated successfully',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF0F1410), // Dark green
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFF1E3A2A)),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        width: 900, // Wider for 2 columns
        height: 600,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.person_add, color: Color(0xFF2ECC71)),
                    const SizedBox(width: 12),
                    Text(
                      widget.person == null
                          ? 'ADD NEW OPERATOR'
                          : 'EDIT OPERATOR',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close, color: Colors.white54),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Divider(color: Colors.white10),
            const SizedBox(height: 32),

            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Column: Image Picker (Expanded 1)
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'OPERATOR PORTRAIT',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.1,
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Big Image Box
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFF2ECC71),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.black26,
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                if (_selectedPicUrl != null)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      _selectedPicUrl!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  )
                                else
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.camera_alt_outlined,
                                        size: 48,
                                        color: Colors.white24,
                                      ),
                                      const SizedBox(height: 8),
                                      const Text(
                                        'SELECT IMAGE',
                                        style: TextStyle(
                                          color: Colors.white24,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),

                                // Selection Overlay (for picking)
                                Positioned.fill(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(12),
                                      onTap: _showImagePickerModal,
                                    ),
                                  ),
                                ),

                                // Ready Badge
                                Positioned(
                                  bottom: -15,
                                  right: 20,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF2ECC71),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Text(
                                      'READY',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Center(
                          child: Text(
                            'SUPPORTED: PNG, JPG\nMAX SIZE: 5MB',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white24,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 32),

                  // Right Column: Form Fields (Expanded 2)
                  Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _buildTextField(
                                  'FIRST NAME',
                                  _firstNameController,
                                  hint: 'e.g. Jonas',
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildTextField(
                                  'LAST NAME',
                                  _lastNameController,
                                  hint: 'e.g. Lindholm',
                                ),
                              ),
                            ],
                          ),
                          _buildTextField(
                            'EMPLOYEE IDENTIFICATION NUMBER',
                            _driverIdController,
                            icon: Icons.badge_outlined,
                            hint: '000-000-000',
                          ),

                          Row(
                            children: [
                              Expanded(child: _buildContractorDropdown()),
                              const SizedBox(width: 16),
                              Expanded(child: _buildEquipmentDropdown()),
                              // Role dropdown is static for now, usually role handles logic
                              // Placeholder for visually matching design
                              const SizedBox(width: 16),
                              Expanded(child: _buildRoleDropdown()),
                            ],
                          ),

                          _buildTextField(
                            'PASSWORD',
                            _passwordController,
                            obscureText: true,
                            icon: Icons.lock_outline,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white24),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('CANCEL'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _save,
                    icon: const Icon(Icons.save_outlined),
                    label: const Text('SAVE PROFILE'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2ECC71),
                      foregroundColor: Colors.black,
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'NODE CONNECTED',
                style: TextStyle(
                  color: const Color(0xFF2ECC71).withOpacity(0.5),
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showImagePickerModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E293B),
      builder: (context) {
        return Container(
          height: 200,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Portrait',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _availableImages.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final path = _availableImages[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedPicUrl = path;
                        });
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        path,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Override buildTextField to match style
  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool obscureText = false,
    String? hint,
    IconData? icon,
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF2ECC71),
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            obscureText: obscureText,
            readOnly: readOnly,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.black26, // Darker input bg
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.white12),
              prefixIcon: icon != null
                  ? Icon(icon, color: Colors.white24)
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.white10),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.white10),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF2ECC71)),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Override Dropdown builders to match style
  Widget _buildContractorDropdown() {
    return FutureBuilder<List<Contractor>>(
      future: ref.read(appRepositoryProvider).getAllContractors(),
      builder: (context, snapshot) {
        final contractors = snapshot.data ?? [];
        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'CONTRACTOR',
                style: TextStyle(
                  color: Color(0xFF2ECC71),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedContractor,
                dropdownColor: const Color(0xFF1E293B),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black26,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.white10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.white10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
                items: contractors.map((c) {
                  return DropdownMenuItem<String>(
                    value: c.name,
                    child: Text(c.name ?? 'Unknown'),
                  );
                }).toList(),
                onChanged: (value) =>
                    setState(() => _selectedContractor = value),
                hint: const Text(
                  'Select Agency',
                  style: TextStyle(color: Colors.white38),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEquipmentDropdown() {
    return FutureBuilder<List<Equipment>>(
      future: ref.read(appRepositoryProvider).getAllEquipment(),
      builder: (context, snapshot) {
        final equipments = snapshot.data ?? [];
        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'EQUIPMENT',
                style: TextStyle(
                  color: Color(0xFF2ECC71),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedEquipment,
                dropdownColor: const Color(0xFF1E293B),
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black26,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.white10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.white10),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
                items: equipments.map((e) {
                  return DropdownMenuItem<String>(
                    value: e.equipName,
                    child: Text(e.equipName ?? 'Unknown'),
                  );
                }).toList(),
                onChanged: (value) =>
                    setState(() => _selectedEquipment = value),
                hint: const Text(
                  'Select Unit',
                  style: TextStyle(color: Colors.white38),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRoleDropdown() {
    final items = <String>[
      'Operator',
      'Helper',
      'Supervisor',
      'Engineer',
      'Admin',
    ];
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ROLE',
            style: TextStyle(
              color: Color(0xFF2ECC71),
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: _selectedRole,
            dropdownColor: const Color(0xFF1E293B),
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.black26,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.white10),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.white10),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
            items: items
                .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                .toList(),
            onChanged: (value) => setState(() => _selectedRole = value),
            hint: const Text(
              'Select Role',
              style: TextStyle(color: Colors.white38),
            ),
          ),
        ],
      ),
    );
  }

  // Deprecated _buildImageSelection in favor of modal
  Widget _buildImageSelection() {
    return const SizedBox.shrink();
  }
}
