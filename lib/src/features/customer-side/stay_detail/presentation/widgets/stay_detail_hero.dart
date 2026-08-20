import 'package:aquabook/src/core/theme/app_colors.dart';
import 'package:aquabook/src/features/customer-side/dashboard/domain/models/stay_listing.dart';
import 'package:aquabook/src/features/customer-side/stay_detail/presentation/widgets/stay_detail_action_button.dart';
import 'package:aquabook/src/features/customer-side/stay_detail/presentation/widgets/stay_detail_page_dot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StayDetailHero extends HookWidget {
  const StayDetailHero({
    super.key,
    required this.stay,
    required this.onBack,
    required this.isSaved,
    required this.onSaved,
  });

  final StayListing stay;
  final VoidCallback onBack;
  final bool isSaved;
  final VoidCallback onSaved;

  @override
  Widget build(BuildContext context) {
    final galleryImages = stay.imageUrls.isEmpty
        ? [stay.imageUrl]
        : stay.imageUrls;
    final activePage = useState(0);
    final pageController = usePageController();

    return SizedBox(
      height: 362,
      child: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: galleryImages.length,
            onPageChanged: (page) => activePage.value = page,
            itemBuilder: (_, index) => Image.network(
              galleryImages[index],
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) =>
                  const ColoredBox(color: AppColors.surfaceHighlight),
            ),
          ),
          const IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black38, Colors.transparent, Colors.black54],
                ),
              ),
            ),
          ),
          Positioned(
            top: 45,
            left: 18,
            child: StayDetailActionButton(
              icon: Icons.arrow_back,
              onPressed: onBack,
            ),
          ),
          Positioned(
            top: 45,
            right: 76,
            child: StayDetailActionButton(icon: Icons.ios_share_outlined),
          ),
          Positioned(
            top: 45,
            right: 18,
            child: StayDetailActionButton(
              icon: isSaved ? Icons.favorite : Icons.favorite_border,
              onPressed: onSaved,
              iconColor: isSaved ? Colors.red : Colors.white,
            ),
          ),
          if (galleryImages.length > 1)
            Positioned(
              bottom: 18,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var index = 0; index < galleryImages.length; index++)
                    StayDetailPageDot(active: index == activePage.value),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
