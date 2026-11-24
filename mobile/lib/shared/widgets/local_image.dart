import 'dart:io';

import 'package:material_ui/material_ui.dart';

import '../../core/theme/app_theme.dart';

/// Displays either a bundled Flutter asset (`assets/...`) or a persisted local file path.
/// Never performs any HTTP or network image request.
class LocalImage extends StatelessWidget {
  const LocalImage({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.cacheWidth,
  });

  final String path;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final int? cacheWidth;

  static const String placeholderAsset =
      'assets/images/placeholders/kos_placeholder.jpg';

  @override
  Widget build(BuildContext context) {
    final trimmed = path.trim();
    Widget imageWidget;

    if (trimmed.isEmpty) {
      imageWidget = _buildPlaceholder();
    } else if (trimmed.startsWith('assets/')) {
      imageWidget = Image.asset(
        trimmed,
        width: width,
        height: height,
        fit: fit,
        cacheWidth: cacheWidth,
        errorBuilder: (_, _, _) => _buildPlaceholder(),
      );
    } else {
      final file = File(trimmed);
      imageWidget = file.existsSync()
          ? Image.file(
              file,
              width: width,
              height: height,
              fit: fit,
              cacheWidth: cacheWidth,
              errorBuilder: (_, _, _) => _buildPlaceholder(),
            )
          : _buildPlaceholder();
    }

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: imageWidget);
    }
    return imageWidget;
  }

  Widget _buildPlaceholder() {
    return Image.asset(
      placeholderAsset,
      width: width,
      height: height,
      fit: fit,
      cacheWidth: cacheWidth,
      errorBuilder: (_, _, _) => Container(
        width: width,
        height: height,
        color: AppColors.neutralBg,
        alignment: Alignment.center,
        child: const Icon(Icons.home_outlined, color: AppColors.inkMuted),
      ),
    );
  }
}
