import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synctrackr/admin/controllers/pagination_controller.dart';
// if it's in another file

class CustomPagination extends StatelessWidget {
  final PaginationController controller = Get.put(PaginationController());

   CustomPagination({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: controller.currentPage.value > 1
                ? () => controller.currentPage.value--
                : null,
            icon: const Icon(Icons.chevron_left),
          ),
          const SizedBox(width: 8),
          ...List.generate(4, (index) {
            final page = index + 1;
            return GestureDetector(
              onTap: () => controller.currentPage.value = page,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: controller.currentPage.value == page
                      ? const Color(0xFF4F46E5)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  page.toString(),
                  style: TextStyle(
                    color: controller.currentPage.value == page
                        ? Colors.white
                        : const Color(0xFF6B7280),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }),
          const SizedBox(width: 8),
          IconButton(
            onPressed: controller.currentPage.value < 4
                ? () => controller.currentPage.value++
                : null,
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
