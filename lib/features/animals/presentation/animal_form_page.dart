import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_theme.dart';
import '../domain/animal.dart';
import 'animal_ui.dart';
import 'animals_controller.dart';

class AnimalFormPage extends StatefulWidget {
  const AnimalFormPage({super.key, required this.controller, this.animal});

  final AnimalsController controller;
  final Animal? animal;

  @override
  State<AnimalFormPage> createState() => _AnimalFormPageState();
}

class _AnimalFormPageState extends State<AnimalFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _commonNameController;
  late final TextEditingController _scientificNameController;
  late final TextEditingController _quantityController;
  late final TextEditingController _notesController;
  late Habitat _habitat;
  late ConservationStatus _status;
  bool _isSaving = false;

  bool get _isEditing => widget.animal != null;

  @override
  void initState() {
    super.initState();
    final animal = widget.animal;
    _commonNameController = TextEditingController(
      text: animal?.commonName ?? '',
    );
    _scientificNameController = TextEditingController(
      text: animal?.scientificName ?? '',
    );
    _quantityController = TextEditingController(
      text: animal?.quantity.toString() ?? '1',
    );
    _notesController = TextEditingController(text: animal?.notes ?? '');
    _habitat = animal?.habitat ?? Habitat.terrestre;
    _status = animal?.status ?? ConservationStatus.preocupacionMenor;
  }

  @override
  void dispose() {
    _commonNameController.dispose();
    _scientificNameController.dispose();
    _quantityController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isSaving = true);
    try {
      await widget.controller.save(
        Animal(
          id: widget.animal?.id,
          commonName: _commonNameController.text,
          scientificName: _scientificNameController.text,
          habitat: _habitat,
          quantity: int.parse(_quantityController.text),
          status: _status,
          notes: _notesController.text,
          updatedAt: DateTime.now(),
        ),
      );
      if (mounted) Navigator.of(context).pop(true);
    } catch (_) {
      if (!mounted) return;
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se pudo guardar el registro. Intenta nuevamente.'),
        ),
      );
    }
  }

  String? _requiredText(String? value, String field) {
    final text = value?.trim() ?? '';
    if (text.isEmpty) return 'Ingresa $field.';
    if (text.length < 2) return 'Usa al menos 2 caracteres.';
    return null;
  }

  String? _validateQuantity(String? value) {
    final quantity = int.tryParse(value ?? '');
    if (quantity == null) return 'Ingresa una cantidad válida.';
    if (quantity < 1) return 'La cantidad debe ser mayor que cero.';
    if (quantity > 9999) return 'La cantidad máxima es 9999.';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar especie' : 'Nueva especie'),
        backgroundColor: AppColors.ivory,
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: Form(
                key: _formKey,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _isEditing
                              ? 'Actualiza el registro'
                              : 'Registra una especie',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Los datos se guardan localmente y permanecen disponibles sin conexión.',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: AppColors.charcoal.withValues(
                                  alpha: 0.7,
                                ),
                              ),
                        ),
                        const SizedBox(height: 28),
                        TextFormField(
                          controller: _commonNameController,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: const InputDecoration(
                            labelText: 'Nombre común',
                            hintText: 'Ej. Oso de anteojos',
                            prefixIcon: Icon(Icons.pets_outlined),
                          ),
                          validator: (value) =>
                              _requiredText(value, 'el nombre común'),
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _scientificNameController,
                          decoration: const InputDecoration(
                            labelText: 'Nombre científico',
                            hintText: 'Ej. Tremarctos ornatus',
                            prefixIcon: Icon(Icons.biotech_outlined),
                          ),
                          validator: (value) =>
                              _requiredText(value, 'el nombre científico'),
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 16),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final habitatField =
                                DropdownButtonFormField<Habitat>(
                                  initialValue: _habitat,
                                  decoration: const InputDecoration(
                                    labelText: 'Hábitat',
                                    prefixIcon: Icon(Icons.public_outlined),
                                  ),
                                  items: Habitat.values
                                      .map(
                                        (habitat) => DropdownMenuItem(
                                          value: habitat,
                                          child: Text(habitat.label),
                                        ),
                                      )
                                      .toList(growable: false),
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() => _habitat = value);
                                    }
                                  },
                                );
                            final statusField =
                                DropdownButtonFormField<ConservationStatus>(
                                  initialValue: _status,
                                  decoration: const InputDecoration(
                                    labelText: 'Estado de conservación',
                                    prefixIcon: Icon(Icons.shield_outlined),
                                  ),
                                  items: ConservationStatus.values
                                      .map(
                                        (status) => DropdownMenuItem(
                                          value: status,
                                          child: Text(status.label),
                                        ),
                                      )
                                      .toList(growable: false),
                                  onChanged: (value) {
                                    if (value != null) {
                                      setState(() => _status = value);
                                    }
                                  },
                                );

                            if (constraints.maxWidth < 620) {
                              return Column(
                                children: [
                                  habitatField,
                                  const SizedBox(height: 16),
                                  statusField,
                                ],
                              );
                            }
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: habitatField),
                                const SizedBox(width: 16),
                                Expanded(child: statusField),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _quantityController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            labelText: 'Cantidad de ejemplares',
                            prefixIcon: Icon(Icons.numbers_rounded),
                          ),
                          validator: _validateQuantity,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _notesController,
                          maxLines: 4,
                          maxLength: 300,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: const InputDecoration(
                            labelText: 'Observaciones (opcional)',
                            alignLabelWithHint: true,
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(bottom: 64),
                              child: Icon(Icons.notes_rounded),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: _isSaving
                                  ? null
                                  : () => Navigator.of(context).pop(),
                              child: const Text('Cancelar'),
                            ),
                            const SizedBox(width: 12),
                            FilledButton.icon(
                              onPressed: _isSaving ? null : _submit,
                              icon: _isSaving
                                  ? const SizedBox.square(
                                      dimension: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Icon(Icons.check_rounded),
                              label: Text(
                                _isEditing
                                    ? 'Guardar cambios'
                                    : 'Registrar especie',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
