import 'package:flutter/material.dart';
import 'package:dimsumnuraosxpress/core/theme/app_colors.dart';
import 'package:dimsumnuraosxpress/core/theme/app_text_styles.dart';
import 'package:dimsumnuraosxpress/core/widgets/app_image.dart';
import 'package:dimsumnuraosxpress/features/menu/state/cart_provider.dart';

class MenuDetailSheet extends StatelessWidget {
  const MenuDetailSheet({
    required this.item,
    required this.relatedItems,
    required this.formatPrice,
    required this.onAdd,
    required this.onOpenRelated,
    super.key,
  });

  final CartItem item;
  final List<CartItem> relatedItems;
  final String Function(double amount) formatPrice;
  final ValueChanged<CartItem> onAdd;
  final ValueChanged<CartItem> onOpenRelated;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: DraggableScrollableSheet(
        initialChildSize: 0.82,
        minChildSize: 0.55,
        maxChildSize: 0.94,
        expand: false,
        builder: (context, scrollController) {
          return ListView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
            children: [
              Center(
                child: Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.outlineVariant,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              AppImage(
                source: item.image,
                height: 190,
                width: double.infinity,
                borderRadius: BorderRadius.circular(18),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: AppTextStyles.headlineMd.copyWith(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item.merchantName,
                          style: AppTextStyles.bodySm.copyWith(
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    formatPrice(item.price),
                    style: AppTextStyles.labelMd.copyWith(
                      color: AppColors.primary,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _InfoChip(
                    icon: Icons.star,
                    text: item.rating.toStringAsFixed(1),
                  ),
                  _InfoChip(
                    icon: Icons.local_fire_department,
                    text: item.badge,
                  ),
                  _InfoChip(
                    icon: Icons.storefront,
                    text: item.merchantDistance,
                  ),
                  _InfoChip(icon: Icons.shopping_bag, text: item.soldCount),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Deskripsi Menu',
                style: AppTextStyles.labelMd.copyWith(fontSize: 17),
              ),
              const SizedBox(height: 8),
              Text(
                item.description,
                style: AppTextStyles.bodyMd.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 52,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => onAdd(item),
                  icon: const Icon(Icons.add_shopping_cart),
                  label: Text(
                    'Tambah ke Keranjang',
                    style: AppTextStyles.labelMd.copyWith(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Menu lain dari ${item.merchantName}',
                style: AppTextStyles.labelMd.copyWith(fontSize: 17),
              ),
              const SizedBox(height: 12),
              if (relatedItems.isEmpty)
                Text(
                  'Belum ada menu terkait dari mitra ini.',
                  style: AppTextStyles.bodySm,
                )
              else
                for (final related in relatedItems)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _RelatedMenuTile(
                      item: related,
                      price: formatPrice(related.price),
                      onTap: () => onOpenRelated(related),
                      onAdd: () => onAdd(related),
                    ),
                  ),
            ],
          );
        },
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.primary, size: 15),
          const SizedBox(width: 5),
          Text(
            text,
            style: AppTextStyles.labelSm.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _RelatedMenuTile extends StatelessWidget {
  const _RelatedMenuTile({
    required this.item,
    required this.price,
    required this.onTap,
    required this.onAdd,
  });

  final CartItem item;
  final String price;
  final VoidCallback onTap;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppColors.outlineVariant.withValues(alpha: 0.35),
          ),
        ),
        child: Row(
          children: [
            AppImage(
              source: item.image,
              width: 58,
              height: 58,
              borderRadius: BorderRadius.circular(12),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.labelMd.copyWith(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodySm.copyWith(fontSize: 12),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    price,
                    style: AppTextStyles.labelSm.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filled(
              style: IconButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              onPressed: onAdd,
              icon: const Icon(Icons.add, size: 18),
            ),
          ],
        ),
      ),
    );
  }
}
