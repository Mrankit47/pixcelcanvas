import 'package:equatable/equatable.dart';

/// Palette preset model descriptor.
class PalettePreset extends Equatable {
  /// Creates a [PalettePreset].
  const PalettePreset({
    required this.name,
    required this.colorsHex,
    required this.description,
  });

  final String name;
  final List<String> colorsHex;
  final String description;

  /// Default built-in palette presets.
  static final List<PalettePreset> defaults = [
    const PalettePreset(
      name: 'Default ARGB 16',
      colorsHex: ['#000000', '#FFFFFF', '#FF0000', '#00FF00', '#0000FF', '#FFFF00', '#00FFFF', '#FF00FF'],
      description: 'Standard 8 primary colors',
    ),
    const PalettePreset(
      name: 'PICO-8 16',
      colorsHex: ['#000000', '#1D2B53', '#7E2553', '#008751', '#AB5236', '#5F574F', '#C2C3C7', '#FFF1E8', '#FF004D', '#FFA300', '#FFEC27', '#00E436', '#29ADFF', '#83769C', '#FF77A8', '#FFCCAA'],
      description: 'Classic PICO-8 retro console 16-color palette',
    ),
    const PalettePreset(
      name: 'GameBoy 4',
      colorsHex: ['#0F380F', '#306230', '#8BAC0F', '#9BBC0F'],
      description: 'Monochrome green 4-color GameBoy palette',
    ),
    const PalettePreset(
      name: 'DawnBringer 16',
      colorsHex: ['#140C1C', '#442434', '#30346D', '#4E4A4E', '#854C30', '#346524', '#D04648', '#757161', '#597DCE', '#D27D2C', '#8595A1', '#6DAA2C', '#D2AA99', '#6DC2CA', '#EEC39A', '#EBE5CE'],
      description: 'DB16 curated pixel art color palette',
    ),
  ];

  @override
  List<Object?> get props => [name, colorsHex, description];
}
