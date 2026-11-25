import 'package:material_ui/material_ui.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../shared/widgets/app_smart_image.dart';

/// Fullscreen pinch-to-zoom swipeable photo gallery for kos property images.
class PhotoGalleryViewerScreen extends StatefulWidget {
  const PhotoGalleryViewerScreen({
    super.key,
    required this.photoUrls,
    this.initialIndex = 0,
    this.title = 'Galeri Foto',
  });

  final List<String> photoUrls;
  final int initialIndex;
  final String title;

  @override
  State<PhotoGalleryViewerScreen> createState() =>
      _PhotoGalleryViewerScreenState();
}

class _PhotoGalleryViewerScreenState extends State<PhotoGalleryViewerScreen> {
  late final PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex.clamp(
      0,
      widget.photoUrls.isEmpty ? 0 : widget.photoUrls.length - 1,
    );
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceDark,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceDark,
        foregroundColor: Colors.white,
        shape: const Border(),
        title: Text(
          widget.photoUrls.isEmpty
              ? widget.title
              : '${_currentIndex + 1} / ${widget.photoUrls.length}',
          style: AppTypography.headingSm.copyWith(color: Colors.white),
        ),
      ),
      body: widget.photoUrls.isEmpty
          ? const Center(
              child: Text(
                'Foto tidak tersedia.',
                style: TextStyle(color: Colors.white70),
              ),
            )
          : PageView.builder(
              controller: _pageController,
              itemCount: widget.photoUrls.length,
              onPageChanged: (index) => setState(() => _currentIndex = index),
              itemBuilder: (context, index) {
                return InteractiveViewer(
                  minScale: 1,
                  maxScale: 4,
                  child: Center(
                    child: AppSmartImage(
                      source: widget.photoUrls[index],
                      fit: BoxFit.contain,
                      placeholder: const CircularProgressIndicator(
                        color: Colors.white,
                      ),
                      errorWidget: const Icon(
                        Icons.broken_image_outlined,
                        color: Colors.white54,
                        size: 48,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
