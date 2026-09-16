import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

/// Design system catalog page demonstrating all variants and states of
/// [MechanixCircularProgressIndicator] and [MechanixLinearProgressIndicator].
class ProgressIndicatorPreview extends StatefulWidget {
  const ProgressIndicatorPreview({super.key});

  @override
  State<ProgressIndicatorPreview> createState() =>
      _ProgressIndicatorPreviewState();
}

class _ProgressIndicatorPreviewState extends State<ProgressIndicatorPreview> {
  double _progressValue = 0.65;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Page Header
        _buildPageHeader(context),
        const SizedBox(height: 28),

        // 2. Interactive Control
        _buildInteractiveController(context),
        const SizedBox(height: 32),

        // 3. Grid of Linear & Circular Indicators
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 900;
            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLinearDeterminateSection(context),
                        const SizedBox(height: 32),
                        _buildLinearIndeterminateSection(context),
                      ],
                    ),
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildCircularDeterminateSection(context),
                        const SizedBox(height: 32),
                        _buildCircularIndeterminateSection(context),
                      ],
                    ),
                  ),
                ],
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLinearDeterminateSection(context),
                const SizedBox(height: 32),
                _buildLinearIndeterminateSection(context),
                const SizedBox(height: 32),
                _buildCircularDeterminateSection(context),
                const SizedBox(height: 32),
                _buildCircularIndeterminateSection(context),
              ],
            );
          },
        ),

        const SizedBox(height: 36),

        // 4. Building Blocks & Variations
        _buildBuildingBlocksSection(context),
      ],
    );
  }

  Widget _buildPageHeader(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.refresh_rounded,
            size: 28,
            color: colorScheme.primary,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Progress Indicators',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Text(
                'Progress indicators inform users about the status of ongoing processes, such as loading an app, submitting a form, or saving updates. They communicate an app\'s state and indicate available actions, such as whether users can navigate away from the current screen.',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInteractiveController(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      color: colorScheme.surfaceContainerLow,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Interactive Playground',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  '${(_progressValue * 100).toInt()}%',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Slider(
              value: _progressValue,
              onChanged: (val) {
                setState(() {
                  _progressValue = val;
                });
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Standard Linear (4px)',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 8),
                      MechanixLinearProgressIndicator(value: _progressValue),
                      const SizedBox(height: 16),
                      Text(
                        'Large Linear (8px)',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 8),
                      MechanixLinearProgressIndicator.large(
                        value: _progressValue,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 32),
                Column(
                  children: [
                    Text(
                      'Standard Circular',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    MechanixCircularProgressIndicator(value: _progressValue),
                  ],
                ),
                const SizedBox(width: 24),
                Column(
                  children: [
                    Text(
                      'Large Circular',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    MechanixCircularProgressIndicator.large(
                      value: _progressValue,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLinearDeterminateSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    const values = [0.0, 0.25, 0.5, 0.75, 1.0];

    return Card(
      color: colorScheme.surfaceContainerLow,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.linear_scale, size: 20, color: colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Linear - Determinate',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Standard Variant (4.0 px height)',
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            for (final val in values) ...[
              Row(
                children: [
                  SizedBox(
                    width: 44,
                    child: Text(
                      '${(val * 100).toInt()}%',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Expanded(child: MechanixLinearProgressIndicator(value: val)),
                ],
              ),
              const SizedBox(height: 10),
            ],
            const SizedBox(height: 16),
            Text(
              'Large Variant (8.0 px height)',
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            for (final val in values) ...[
              Row(
                children: [
                  SizedBox(
                    width: 44,
                    child: Text(
                      '${(val * 100).toInt()}%',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  Expanded(
                    child: MechanixLinearProgressIndicator.large(value: val),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLinearIndeterminateSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      color: colorScheme.surfaceContainerLow,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.more_horiz, size: 20, color: colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Linear - Indeterminate',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Standard (4.0 px)',
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            const MechanixLinearProgressIndicator(),
            const SizedBox(height: 20),
            Text(
              'Large (8.0 px)',
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            const MechanixLinearProgressIndicator.large(),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularDeterminateSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    const values = [0.0, 0.25, 0.5, 0.75, 1.0];

    return Card(
      color: colorScheme.surfaceContainerLow,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.data_usage, size: 20, color: colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Circular - Determinate',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'Standard (40x40 / 4px)',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Large (44x44 / 8px)',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            for (final val in values) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 80,
                    child: Column(
                      children: [
                        MechanixCircularProgressIndicator(value: val),
                        const SizedBox(height: 4),
                        Text(
                          '${(val * 100).toInt()}%',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: Column(
                      children: [
                        MechanixCircularProgressIndicator.large(value: val),
                        const SizedBox(height: 4),
                        Text(
                          '${(val * 100).toInt()}%',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCircularIndeterminateSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      color: colorScheme.surfaceContainerLow,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.loop, size: 20, color: colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Circular - Indeterminate',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    MechanixCircularProgressIndicator(),
                    SizedBox(height: 8),
                    Text('Standard (40x40)'),
                  ],
                ),
                Column(
                  children: [
                    MechanixCircularProgressIndicator.large(),
                    SizedBox(height: 8),
                    Text('Large (44x44)'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBuildingBlocksSection(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      color: colorScheme.surfaceContainerLow,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Building Blocks & Customization',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Progress indicators can be styled with custom colors, stroke caps, and sizes.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 32,
              runSpacing: 24,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Stroke Cap: Round (Default)',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const MechanixCircularProgressIndicator.large(
                      value: 0.6,
                      strokeCap: StrokeCap.round,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Stroke Cap: Square',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const MechanixCircularProgressIndicator.large(
                      value: 0.6,
                      strokeCap: StrokeCap.square,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Custom Accent Color',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 8),
                    MechanixCircularProgressIndicator.large(
                      value: 0.7,
                      color: colorScheme.error,
                      backgroundColor: colorScheme.errorContainer,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
