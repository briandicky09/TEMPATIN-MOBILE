import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/theme/app_colors.dart';

/// Unified image renderer supporting bundled `assets/...`, local files,
/// and remote `http(s)://...` URLs with consistent local fallback.
class AppSmartImage extends StatelessWidget {
  const AppSmartImage({
    super.key,
    required this.source,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.placeholder,
    this.errorWidget,
  });

  final String? source;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Widget? placeholder;
  final Widget? errorWidget;

  static bool isAssetPath(String value) => value.startsWith('assets/');

  static bool isNetworkUrl(String value) =>
      value.startsWith('http://') || value.startsWith('https://');

  @override
  Widget build(BuildContext context) {
    final raw = source?.trim() ?? '';
    if (raw.isEmpty) {
      return errorWidget ?? _defaultFallback();
    }

    if (isAssetPath(raw)) {
      return Image.asset(
        raw,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, _, _) => errorWidget ?? _defaultFallback(),
      );
    }

    if (isNetworkUrl(raw)) {
      return CachedNetworkImage(
        imageUrl: raw,
        width: width,
        height: height,
        fit: fit,
        placeholder: (_, _) =>
            placeholder ?? Container(color: AppColors.skeletonBase),
        errorWidget: (_, _, _) => errorWidget ?? _defaultFallback(),
      );
    }

    final filePath = raw.startsWith('file://')
        ? Uri.tryParse(raw)?.toFilePath() ?? raw
        : raw;
    final file = File(filePath);
    if (file.existsSync()) {
      return Image.file(
        file,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, _, _) => errorWidget ?? _defaultFallback(),
      );
    }

    return errorWidget ?? _defaultFallback();
  }

  Widget _defaultFallback() {
    return Container(
      width: width,
      height: height,
      color: AppColors.neutralBg,
      alignment: Alignment.center,
      child: Image.asset(
        'assets/images/kos/placeholder.jpg',
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, _, _) => const Icon(
          LucideIcons.imageOff,
          size: 24,
          color: AppColors.inkSecondary,
        ),
      ),
    );
  }
}
