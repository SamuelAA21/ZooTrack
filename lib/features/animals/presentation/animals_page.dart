import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../domain/animal.dart';
import 'animal_form_page.dart';
import 'animal_ui.dart';
import 'animals_controller.dart';

class AnimalsPage extends StatefulWidget {
  const AnimalsPage({super.key, required this.controller});

  final AnimalsController controller;

  @override
  State<AnimalsPage> createState() => _AnimalsPageState();
}

class _AnimalsPageState extends State<AnimalsPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _openForm([Animal? animal]) async {
    final saved = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) =>
            AnimalFormPage(controller: widget.controller, animal: animal),
      ),
    );

    if (!mounted || saved != true) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          animal == null ? 'Especie registrada.' : 'Cambios guardados.',
        ),
      ),
    );
  }

  Future<void> _requestDelete(Animal animal) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.delete_outline_rounded),
        title: const Text('Eliminar registro'),
        content: Text(
          '¿Quieres eliminar a ${animal.commonName}? Esta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
            ),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    try {
      await widget.controller.delete(animal);
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Registro eliminado.')));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se pudo eliminar el registro.')),
      );
    }
  }

  void _clearFilters() {
    _searchController.clear();
    widget.controller.clearFilters();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.controller,
      builder: (context, _) {
        final isWide = MediaQuery.sizeOf(context).width >= 940;

        return Scaffold(
          body: SafeArea(
            child: isWide
                ? _DesktopLayout(
                    controller: widget.controller,
                    searchController: _searchController,
                    onSearch: widget.controller.setSearch,
                    onClearFilters: _clearFilters,
                    onAdd: _openForm,
                    onEdit: _openForm,
                    onDelete: _requestDelete,
                  )
                : _MobileLayout(
                    controller: widget.controller,
                    searchController: _searchController,
                    onSearch: widget.controller.setSearch,
                    onClearFilters: _clearFilters,
                    onEdit: _openForm,
                    onDelete: _requestDelete,
                  ),
          ),
          bottomNavigationBar: isWide
              ? null
              : SafeArea(
                  top: false,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(top: BorderSide(color: AppColors.line)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                      child: FilledButton.icon(
                        onPressed: _openForm,
                        icon: const Icon(Icons.add_rounded),
                        label: const Text('Registrar especie'),
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout({
    required this.controller,
    required this.searchController,
    required this.onSearch,
    required this.onClearFilters,
    required this.onAdd,
    required this.onEdit,
    required this.onDelete,
  });

  final AnimalsController controller;
  final TextEditingController searchController;
  final ValueChanged<String> onSearch;
  final VoidCallback onClearFilters;
  final VoidCallback onAdd;
  final ValueChanged<Animal> onEdit;
  final ValueChanged<Animal> onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 340, child: _OverviewPanel(controller: controller)),
        Expanded(
          child: _InventoryPanel(
            controller: controller,
            searchController: searchController,
            onSearch: onSearch,
            onClearFilters: onClearFilters,
            onAdd: onAdd,
            onEdit: onEdit,
            onDelete: onDelete,
            showAddButton: true,
          ),
        ),
      ],
    );
  }
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout({
    required this.controller,
    required this.searchController,
    required this.onSearch,
    required this.onClearFilters,
    required this.onEdit,
    required this.onDelete,
  });

  final AnimalsController controller;
  final TextEditingController searchController;
  final ValueChanged<String> onSearch;
  final VoidCallback onClearFilters;
  final ValueChanged<Animal> onEdit;
  final ValueChanged<Animal> onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _MobileHeader(controller: controller),
        Expanded(
          child: _InventoryPanel(
            controller: controller,
            searchController: searchController,
            onSearch: onSearch,
            onClearFilters: onClearFilters,
            onAdd: null,
            onEdit: onEdit,
            onDelete: onDelete,
            showAddButton: false,
          ),
        ),
      ],
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand({this.onDark = false});

  final bool onDark;

  @override
  Widget build(BuildContext context) {
    final foreground = onDark ? Colors.white : AppColors.forest;
    return Row(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: onDark
                ? Colors.white.withValues(alpha: 0.12)
                : AppColors.forest,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(
              Icons.nature_people_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ZooTrack',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge
                    ?.copyWith(color: foreground),
              ),
              Text(
                'Inventario de fauna',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: foreground.withValues(alpha: 0.7)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OverviewPanel extends StatelessWidget {
  const _OverviewPanel({required this.controller});

  final AnimalsController controller;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.forest,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(28, 28, 28, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Brand(onDark: true),
            const Spacer(),
            Text(
              'El inventario,\nclaro y al día.',
              style: Theme.of(context).textTheme.displaySmall
                  ?.copyWith(color: Colors.white, fontSize: 37),
            ),
            const SizedBox(height: 12),
            Text(
              'Consulta especies y ejemplares incluso cuando no tengas conexión.',
              style: Theme.of(context).textTheme.bodyLarge
                  ?.copyWith(color: Colors.white.withValues(alpha: 0.72)),
            ),
            const SizedBox(height: 34),
            _DarkMetric(
              value: controller.specimenCount.toString(),
              label: 'Ejemplares',
              icon: Icons.pets_rounded,
            ),
            const Divider(color: Color(0xFF49675F), height: 28),
            _DarkMetric(
              value: controller.speciesCount.toString(),
              label: 'Especies registradas',
              icon: Icons.format_list_bulleted_rounded,
            ),
            const Divider(color: Color(0xFF49675F), height: 28),
            _DarkMetric(
              value: controller.habitatCount.toString(),
              label: 'Hábitats activos',
              icon: Icons.public_rounded,
            ),
            const Spacer(),
            Row(
              children: [
                const Icon(
                  Icons.cloud_off_rounded,
                  color: Color(0xFFB9D7C8),
                  size: 18,
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    'Datos disponibles sin conexión',
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(color: const Color(0xFFB9D7C8)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DarkMetric extends StatelessWidget {
  const _DarkMetric({
    required this.value,
    required this.label,
    required this.icon,
  });

  final String value;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFFB9D7C8), size: 22),
        const SizedBox(width: 14),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium
              ?.copyWith(color: Colors.white),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(color: Colors.white.withValues(alpha: 0.65)),
          ),
        ),
      ],
    );
  }
}

class _MobileHeader extends StatelessWidget {
  const _MobileHeader({required this.controller});

  final AnimalsController controller;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.forest,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _Brand(onDark: true),
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: _CompactMetric(
                    value: controller.specimenCount,
                    label: 'Ejemplares',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _CompactMetric(
                    value: controller.speciesCount,
                    label: 'Especies',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _CompactMetric(
                    value: controller.habitatCount,
                    label: 'Hábitats',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CompactMetric extends StatelessWidget {
  const _CompactMetric({required this.value, required this.label});

  final int value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value.toString(),
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(color: Colors.white),
            ),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: Colors.white.withValues(alpha: 0.68)),
            ),
          ],
        ),
      ),
    );
  }
}

class _InventoryPanel extends StatelessWidget {
  const _InventoryPanel({
    required this.controller,
    required this.searchController,
    required this.onSearch,
    required this.onClearFilters,
    required this.onAdd,
    required this.onEdit,
    required this.onDelete,
    required this.showAddButton,
  });

  final AnimalsController controller;
  final TextEditingController searchController;
  final ValueChanged<String> onSearch;
  final VoidCallback onClearFilters;
  final VoidCallback? onAdd;
  final ValueChanged<Animal> onEdit;
  final ValueChanged<Animal> onDelete;
  final bool showAddButton;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1120),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            MediaQuery.sizeOf(context).width >= 940 ? 38 : 16,
            MediaQuery.sizeOf(context).width >= 940 ? 32 : 20,
            MediaQuery.sizeOf(context).width >= 940 ? 38 : 16,
            0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Inventario',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Busca, filtra y actualiza los registros del zoológico.',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: AppColors.charcoal.withValues(
                                  alpha: 0.65,
                                ),
                              ),
                        ),
                      ],
                    ),
                  ),
                  if (showAddButton) ...[
                    const SizedBox(width: 24),
                    FilledButton.icon(
                      onPressed: onAdd,
                      icon: const Icon(Icons.add_rounded),
                      label: const Text('Registrar especie'),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 24),
              TextField(
                controller: searchController,
                onChanged: onSearch,
                decoration: InputDecoration(
                  hintText: 'Buscar por nombre común o científico',
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: searchController.text.isEmpty
                      ? null
                      : IconButton(
                          tooltip: 'Limpiar búsqueda',
                          onPressed: () {
                            searchController.clear();
                            onSearch('');
                          },
                          icon: const Icon(Icons.close_rounded),
                        ),
                ),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  FilterChip(
                    label: const Text('Todos'),
                    selected: controller.selectedHabitat == null,
                    onSelected: (_) => controller.setHabitat(null),
                  ),
                  ...Habitat.values.map(
                    (habitat) => FilterChip(
                      avatar: Icon(habitat.icon, size: 17),
                      label: Text(habitat.label),
                      selected: controller.selectedHabitat == habitat,
                      selectedColor: habitat.color.withValues(alpha: 0.16),
                      checkmarkColor: habitat.color,
                      onSelected: (_) => controller.setHabitat(habitat),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: _InventoryBody(
                  controller: controller,
                  onClearFilters: onClearFilters,
                  onEdit: onEdit,
                  onDelete: onDelete,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InventoryBody extends StatelessWidget {
  const _InventoryBody({
    required this.controller,
    required this.onClearFilters,
    required this.onEdit,
    required this.onDelete,
  });

  final AnimalsController controller;
  final VoidCallback onClearFilters;
  final ValueChanged<Animal> onEdit;
  final ValueChanged<Animal> onDelete;

  @override
  Widget build(BuildContext context) {
    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.error != null) {
      return _MessageState(
        icon: Icons.sync_problem_rounded,
        title: 'No pudimos abrir el inventario',
        message: 'Revisa el almacenamiento local e intenta nuevamente.',
        actionLabel: 'Reintentar',
        onAction: controller.initialize,
      );
    }

    final animals = controller.animals;
    if (animals.isEmpty) {
      return _MessageState(
        icon: controller.hasActiveFilters
            ? Icons.search_off_rounded
            : Icons.pets_outlined,
        title: controller.hasActiveFilters
            ? 'No hay coincidencias'
            : 'Aún no hay especies',
        message: controller.hasActiveFilters
            ? 'Prueba con otro nombre o limpia los filtros.'
            : 'Registra la primera especie para comenzar el inventario.',
        actionLabel: controller.hasActiveFilters ? 'Limpiar filtros' : null,
        onAction: controller.hasActiveFilters ? onClearFilters : null,
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 28),
      itemCount: animals.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) => _AnimalCard(
        animal: animals[index],
        onEdit: () => onEdit(animals[index]),
        onDelete: () => onDelete(animals[index]),
      ),
    );
  }
}

class _AnimalCard extends StatelessWidget {
  const _AnimalCard({
    required this.animal,
    required this.onEdit,
    required this.onDelete,
  });

  final Animal animal;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: animal.habitat.color.withValues(alpha: 0.13),
                borderRadius: BorderRadius.circular(15),
              ),
              child: SizedBox.square(
                dimension: 52,
                child: Icon(animal.habitat.icon, color: animal.habitat.color),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    animal.commonName,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    animal.scientificName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: AppColors.charcoal.withValues(alpha: 0.62),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      _InfoPill(
                        label: animal.habitat.label,
                        color: animal.habitat.color,
                      ),
                      _InfoPill(
                        label: animal.status.label,
                        color: animal.status.color,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              children: [
                Text(
                  animal.quantity.toString(),
                  style: Theme.of(context).textTheme.headlineMedium
                      ?.copyWith(color: AppColors.forest),
                ),
                Text(
                  animal.quantity == 1 ? 'ejemplar' : 'ejemplares',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.charcoal.withValues(alpha: 0.58),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            PopupMenuButton<String>(
              tooltip: 'Acciones de ${animal.commonName}',
              onSelected: (value) => value == 'edit' ? onEdit() : onDelete(),
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: 'edit',
                  child: ListTile(
                    leading: Icon(Icons.edit_outlined),
                    title: Text('Editar'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: ListTile(
                    leading: Icon(Icons.delete_outline_rounded),
                    title: Text('Eliminar'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall
              ?.copyWith(color: color, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class _MessageState extends StatelessWidget {
  const _MessageState({
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: AppColors.leaf),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(color: AppColors.charcoal.withValues(alpha: 0.64)),
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 18),
              OutlinedButton(onPressed: onAction, child: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}
