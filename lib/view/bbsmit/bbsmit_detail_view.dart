import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/color/app_color.dart';
import 'package:intl/intl.dart';

class BbsmitDetailView extends StatelessWidget {
  const BbsmitDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = Get.arguments;
    final String type = arguments['type'];
    final dynamic data = arguments['data'];

    return Scaffold(
      backgroundColor: AppColor.kColorBackground,
      appBar: AppBar(
        title: Text('$type Details'),
        backgroundColor: AppColor.kColorPrimary,
        foregroundColor: AppColor.whiteColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailHeader(data.name, type),
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
    if (type == 'Contact' || type == 'Enquiry' || type == 'Enrollment') {
      details['Phone'] = data.number ?? 'N/A';
      details['Subject'] = data.subject ?? 'N/A';
      details['Country'] = data.countrysName ?? 'N/A';
      details['State'] = data.statesName ?? 'N/A';
      details['City'] = data.citiesName ?? 'N/A';
      details['Status'] = data.status == '1' ? 'Read' : 'Unread';
    } else if (type == 'RSCIT') {
      details['Phone'] = data.number ?? 'N/A';
      details['Message'] = data.message ?? 'N/A';
    } else if (type == 'Faculty') {
      details['Phone'] = '${data.countryCode} ${data.phone}';
      details['Education'] = data.education ?? 'N/A';
      details['Job Role'] = data.jobRole ?? 'N/A';
      details['Address'] = data.address ?? 'N/A';
      details['Location'] = '${data.citiesName}, ${data.statesName}, ${data.countrysName}';
    } else if (type == 'University') {
      details['Phone'] = '${data.countryCode} ${data.phone}';
      details['University'] = data.university ?? 'N/A';
      details['Course'] = data.course ?? 'N/A';
      details['Subject'] = data.subject ?? 'N/A';
      details['Scholarship'] = data.scholarship ?? 'N/A';
      details['Payment Status'] = data.payment ?? 'N/A';
      details['Transaction ID'] = data.transactionId ?? 'N/A';
      details['Counselling Slot'] = data.counsellingSlot ?? 'N/A';
      details['Appointment'] = '${data.date} at ${data.time}';
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
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.cardBorderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600, color: AppColor.kColorTextSecondary),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, color: AppColor.kColorTextPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
