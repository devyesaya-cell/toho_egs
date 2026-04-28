import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/person.dart';
import '../../../../core/models/contractor.dart';
import '../../../../core/models/equipment.dart';
import '../../../../core/repositories/app_repository.dart';
import '../../../../core/state/auth_state.dart';
import '../../../../core/utils/app_theme.dart';

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
  late TextEditingController _picUrlController;
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
    final nowSec = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final personToSave = widget.person ?? Person();
    final isNew = widget.person == null;

    if (isNew) {
      // Generate 2-byte random hex UID (4 chars)
      final rand = Random().nextInt(65536);
      personToSave.uid = rand.toRadixString(16).padLeft(4, '0').toUpperCase();
    }

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
      ..lastUpdate = nowSec
      ..loginState = 'ON'
      ..user = _firstNameController.text.toLowerCase();

    await ref.read(appRepositoryProvider).savePerson(personToSave);

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
    final theme = AppTheme.of(context);

    return Dialog(
      backgroundColor: theme.pageBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.cardBorderColor),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        width: 900,
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
                    Icon(Icons.person_add, color: theme.appBarAccent),
                    const SizedBox(width: 12),
                    Text(
                      widget.person == null
                          ? 'ADD NEW OPERATOR'
                          : 'EDIT OPERATOR',
                      style: TextStyle(
                        color: theme.textOnSurface,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.close, color: theme.textSecondary),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Divider(color: theme.dividerColor),
            const SizedBox(height: 32),

            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Column: Image Picker
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'OPERATOR PORTRAIT',
                          style: TextStyle(
                            color: theme.textSecondary,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.1,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: theme.inputFocusedBorder,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              color: theme.inputFill,
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
                                      Icon(
                                        Icons.camera_alt_outlined,
                                        size: 48,
                                        color: theme.inputHintText,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'SELECT IMAGE',
                                        style: TextStyle(
                                          color: theme.inputHintText,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),

                                Positioned.fill(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(12),
                                      onTap: () => _showImagePickerModal(theme),
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
                                      color: theme.primaryButtonBackground,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      'READY',
                                      style: TextStyle(
                                        color: theme.primaryButtonText,
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
                        Center(
                          child: Text(
                            'SUPPORTED: PNG, JPG\nMAX SIZE: 5MB',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: theme.inputHintText,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 32),

                  // Right Column: Form Fields
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
                                  theme,
                                  'FIRST NAME',
                                  _firstNameController,
                                  hint: 'e.g. Jonas',
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildTextField(
                                  theme,
                                  'LAST NAME',
                                  _lastNameController,
                                  hint: 'e.g. Lindholm',
                                ),
                              ),
                            ],
                          ),
                          _buildTextField(
                            theme,
                            'EMPLOYEE IDENTIFICATION NUMBER',
                            _driverIdController,
                            icon: Icons.badge_outlined,
                            hint: '000-000-000',
                          ),
                          Row(
                            children: [
                              Expanded(child: _buildContractorDropdown(theme)),
                              const SizedBox(width: 16),
                              Expanded(child: _buildEquipmentDropdown(theme)),
                              const SizedBox(width: 16),
                              Expanded(child: _buildRoleDropdown(theme)),
                            ],
                          ),
                          _buildTextField(
                            theme,
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
                      foregroundColor: theme.textOnSurface,
                      side: BorderSide(color: theme.dividerColor),
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
                      backgroundColor: theme.primaryButtonBackground,
                      foregroundColor: theme.primaryButtonText,
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
                  color: theme.appBarAccent.withValues(alpha: 0.5),
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showImagePickerModal(AppThemeData theme) {
    showModalBottomSheet(
      context: context,
      backgroundColor: theme.dialogBackground,
      builder: (context) {
        return Container(
          height: 200,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Portrait',
                style: TextStyle(color: theme.textOnSurface, fontSize: 16),
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

  Widget _buildTextField(
    AppThemeData theme,
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
            style: TextStyle(
              color: theme.labelColor,
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
            style: TextStyle(color: theme.inputTextColor),
            decoration: InputDecoration(
              filled: true,
              fillColor: theme.inputFill,
              hintText: hint,
              hintStyle: TextStyle(color: theme.inputHintText),
              prefixIcon: icon != null
                  ? Icon(icon, color: theme.inputIconColor)
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: theme.inputBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: theme.inputBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: theme.inputFocusedBorder),
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

  Widget _buildContractorDropdown(AppThemeData theme) {
    return FutureBuilder<List<Contractor>>(
      future: ref.read(appRepositoryProvider).getAllContractors(),
      builder: (context, snapshot) {
        final contractors = snapshot.data ?? [];
        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CONTRACTOR',
                style: TextStyle(
                  color: theme.labelColor,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedContractor,
                dropdownColor: theme.dropdownBackground,
                style: TextStyle(color: theme.dropdownItemText),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: theme.inputFill,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: theme.inputBorder),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: theme.inputBorder),
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
                hint: Text(
                  'Select Agency',
                  style: TextStyle(color: theme.dropdownHintText),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEquipmentDropdown(AppThemeData theme) {
    return FutureBuilder<List<Equipment>>(
      future: ref.read(appRepositoryProvider).getAllEquipment(),
      builder: (context, snapshot) {
        final equipments = snapshot.data ?? [];
        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'EQUIPMENT',
                style: TextStyle(
                  color: theme.labelColor,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedEquipment,
                dropdownColor: theme.dropdownBackground,
                style: TextStyle(color: theme.dropdownItemText),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: theme.inputFill,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: theme.inputBorder),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: theme.inputBorder),
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
                hint: Text(
                  'Select Unit',
                  style: TextStyle(color: theme.dropdownHintText),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRoleDropdown(AppThemeData theme) {
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
          Text(
            'ROLE',
            style: TextStyle(
              color: theme.labelColor,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: _selectedRole,
            dropdownColor: theme.dropdownBackground,
            style: TextStyle(color: theme.dropdownItemText),
            decoration: InputDecoration(
              filled: true,
              fillColor: theme.inputFill,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: theme.inputBorder),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: theme.inputBorder),
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
            hint: Text(
              'Select Role',
              style: TextStyle(color: theme.dropdownHintText),
            ),
          ),
        ],
      ),
    );
  }
}
