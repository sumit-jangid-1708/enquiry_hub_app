import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/color/app_color.dart';
import '../../res/components/filter_chip_widget.dart';
import '../../res/components/enquiry_data_card.dart';
import '../../view_models/controller/bbsmit_controller.dart';
import '../../res/routes/routes_names.dart';
import 'package:intl/intl.dart';

class BbsmitView extends StatelessWidget {
  const BbsmitView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BbsmitController());

    return Scaffold(
      backgroundColor: AppColor.kColorBackground,
      appBar: AppBar(
        title: const Text('BBSMIT Details'),
        backgroundColor: AppColor.kColorPrimary,
        foregroundColor: AppColor.whiteColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          // Filter Chips
          SizedBox(
            height: 50,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: controller.filters.length,
              itemBuilder: (context, index) {
                return Obx(
                  () => FilterChipWidget(
                    title: controller.filters[index],
                    isSelected: controller.selectedFilterIndex.value == index,
                    onTap: () => controller.setFilterIndex(index),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          // Data List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              final index = controller.selectedFilterIndex.value;

              switch (index) {
                case 0:
                  return _buildContactList(controller);
                case 1:
                  return _buildEnquiryList(controller);
                case 2:
                  return _buildRscitList(controller);
                case 3:
                  return _buildEnrollmentList(controller);
                case 4:
                  return _buildFacultyList(controller);
                case 5:
                  return _buildUniversityList(controller);
                default:
                  return const Center(child: Text('No Data'));
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildContactList(BbsmitController controller) {
    if (controller.bbsmitContacts.isEmpty)
      return const Center(child: Text('No Contacts Found'));
    return ListView.builder(
      itemCount: controller.bbsmitContacts.length,
      itemBuilder: (context, index) {
        final item = controller.bbsmitContacts[index];
        return EnquiryDataCard(
          title: item.name,
          subtitle: item.subject,
          date: DateFormat('dd MMM yyyy, hh:mm a').format(item.createdAt),
          onTap: () => Get.toNamed(
            RouteName.bbsmitDetailView,
            arguments: {'type': 'Contact', 'data': item},
          ),
        );
      },
    );
  }

  Widget _buildEnquiryList(BbsmitController controller) {
    if (controller.bbsmitEnquiries.isEmpty)
      return const Center(child: Text('No Enquiries Found'));
    return ListView.builder(
      itemCount: controller.bbsmitEnquiries.length,
      itemBuilder: (context, index) {
        final item = controller.bbsmitEnquiries[index];
        return EnquiryDataCard(
          title: item.name,
          subtitle: item.subject,
          date: DateFormat('dd MMM yyyy, hh:mm a').format(item.createdAt),
          onTap: () => Get.toNamed(
            RouteName.bbsmitDetailView,
            arguments: {'type': 'Enquiry', 'data': item},
          ),
        );
      },
    );
  }

  Widget _buildRscitList(BbsmitController controller) {
    if (controller.bbsmitRscits.isEmpty)
      return const Center(child: Text('No RSCIT Data Found'));
    return ListView.builder(
      itemCount: controller.bbsmitRscits.length,
      itemBuilder: (context, index) {
        final item = controller.bbsmitRscits[index];
        return EnquiryDataCard(
          title: item.name,
          subtitle: item.message,
          date: DateFormat('dd MMM yyyy, hh:mm a').format(item.createdAt),
          onTap: () => Get.toNamed(
            RouteName.bbsmitDetailView,
            arguments: {'type': 'RSCIT', 'data': item},
          ),
        );
      },
    );
  }

  Widget _buildEnrollmentList(BbsmitController controller) {
    if (controller.bbsmitEnrollments.isEmpty)
      return const Center(child: Text('No Enrollments Found'));
    return ListView.builder(
      itemCount: controller.bbsmitEnrollments.length,
      itemBuilder: (context, index) {
        final item = controller.bbsmitEnrollments[index];
        return EnquiryDataCard(
          title: item.name,
          subtitle: item.subject,
          date: DateFormat('dd MMM yyyy, hh:mm a').format(item.createdAt),
          onTap: () => Get.toNamed(
            RouteName.bbsmitDetailView,
            arguments: {'type': 'Enrollment', 'data': item},
          ),
        );
      },
    );
  }

  Widget _buildFacultyList(BbsmitController controller) {
    if (controller.bbsmitFaculties.isEmpty)
      return const Center(child: Text('No Faculty Found'));
    return ListView.builder(
      itemCount: controller.bbsmitFaculties.length,
      itemBuilder: (context, index) {
        final item = controller.bbsmitFaculties[index];
        return EnquiryDataCard(
          title: item.name,
          subtitle: item.jobRole,
          date: DateFormat('dd MMM yyyy, hh:mm a').format(item.createdAt),
          onTap: () => Get.toNamed(
            RouteName.bbsmitDetailView,
            arguments: {'type': 'Faculty', 'data': item},
          ),
        );
      },
    );
  }

  Widget _buildUniversityList(BbsmitController controller) {
    if (controller.bbsmitUniversities.isEmpty)
      return const Center(child: Text('No University Data Found'));
    return ListView.builder(
      itemCount: controller.bbsmitUniversities.length,
      itemBuilder: (context, index) {
        final item = controller.bbsmitUniversities[index];
        return EnquiryDataCard(
          title: item.name,
          subtitle: '${item.course} - ${item.university}',
          date: DateFormat('dd MMM yyyy, hh:mm a').format(item.createdAt),
          onTap: () => Get.toNamed(
            RouteName.bbsmitDetailView,
            arguments: {'type': 'University', 'data': item},
          ),
        );
      },
    );
  }
}
