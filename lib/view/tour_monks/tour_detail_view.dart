import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/color/app_color.dart';
import 'package:intl/intl.dart';

class TourDetailView extends StatelessWidget {
  const TourDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = Get.arguments;
    final String type = arguments['type'];
    final dynamic data = arguments['data'];

    String displayName = data.name;

    return Scaffold(
      backgroundColor: AppColor.kColorBackground,
      appBar: AppBar(
        title: Text('Tour $type Details'),
        backgroundColor: AppColor.kColorPrimary,
        foregroundColor: AppColor.whiteColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailHeader(displayName, type),
            const SizedBox(height: 24),
            _buildDetailsList(type, data),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailHeader(String name, String type) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColor.cardBorderColor),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: AppColor.kColorPrimary.withOpacity(0.1),
            child: Text(
              name.isNotEmpty ? name[0].toUpperCase() : '?',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColor.kColorPrimary),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            name,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColor.kColorTextPrimary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            type,
            style: const TextStyle(color: AppColor.kColorTextSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsList(String type, dynamic data) {
    final Map<String, String> details = {};

    // Common fields
    if (data.email != null) details['Email'] = data.email;
    
    // Model specific fields
    if (type == 'Contact') {
      details['Phone'] = '${data.code ?? ""} ${data.phone}'.trim();
      if (data.destination != null) details['Destination'] = data.destination!;
      if (data.preferredDate != null) details['Preferred Date'] = data.preferredDate!;
      if (data.groupSize != null) details['Group Size'] = data.groupSize!;
      if (data.subject != null) details['Subject'] = data.subject!;
      if (data.message != null) details['Message'] = data.message!;
    } else if (type == 'Customize') {
      details['Phone'] = '${data.code ?? ""} ${data.phone}'.trim();
      details['Destination'] = data.destination;
      details['Travel Date'] = data.date;
      details['Adults'] = data.adultsNum;
      details['Children'] = data.childrenNum;
      details['Country'] = data.country;
      details['Message'] = data.message;
    } else if (type == 'Book') {
      details['Phone'] = '${data.code ?? ""} ${data.phone}'.trim();
      if (data.tourName != null) details['Tour Name'] = data.tourName!;
      if (data.tourPlanName != null) details['Plan Name'] = data.tourPlanName!;
      if (data.travelDate != null) details['Travel Date'] = data.travelDate!;
      if (data.noPersons != null) details['No. of Persons'] = data.noPersons!;
      if (data.message != null) details['Message'] = data.message!;
    } else if (type == 'Enquiry') {
      details['Phone'] = '${data.code ?? ""} ${data.phone}'.trim();
      if (data.tourName != null) details['Tour Name'] = data.tourName!;
      if (data.selectedPlan != null) details['Selected Plan'] = data.selectedPlan!;
      if (data.people != null) details['People'] = data.people!;
      if (data.totalPrice != null) details['Total Price'] = data.totalPrice!;
      if (data.travelDate != null) details['Travel Date'] = data.travelDate!;
      if (data.city != null) details['City'] = data.city!;
      if (data.country != null) details['Country'] = data.country!;
      if (data.message != null) details['Message'] = data.message!;
    } else if (type == 'Confirm') {
      details['Phone'] = data.phoneNo;
      if (data.tourPlanName != null) details['Tour Plan'] = data.tourPlanName!;
      if (data.totalPrice != null) details['Total Price'] = data.totalPrice!;
    }

    // Add Date
    if (data.createdAt != null) {
      details['Created At'] = DateFormat('dd MMM yyyy, hh:mm a').format(data.createdAt);
    }

    return Column(
      children: details.entries.map((entry) => _buildDetailItem(entry.key, entry.value)).toList(),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.cardBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600, color: AppColor.kColorTextSecondary, fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, color: AppColor.kColorTextPrimary, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
