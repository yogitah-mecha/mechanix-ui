/// Defines the shape variant of the [MechanixButton].
enum ButtonType {
  /// Sharp / minimal corner radius (Square corners)
  square,

  /// Fully rounded pill shape
  rounded,
}

/// Defines the visual style variant of the [MechanixButton].
enum ButtonVariant {
  /// Filled background button style.
  filled,

  /// Outlined border button style with transparent background.
  outline,
}

/// Defines the pre-set sizing scale of the [MechanixButton].
enum ButtonSize { xSmall, small, medium, large, xLarge }

/// Sizing strategy for width or height layout.
enum ButtonLayoutSizing {
  /// Hug / fit content tightly based on label and icon.
  hug,

  /// Fill available space (expand to maximum width/height).
  fill,

  /// Fixed explicitly provided dimension value.
  fixed,
}
