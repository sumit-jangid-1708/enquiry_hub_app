import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/color/app_color.dart';
import 'package:intl/intl.dart';

class AhitDetailView extends StatelessWidget {
  const AhitDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = Get.arguments;
    final String type = arguments['type'];
    final dynamic data = arguments['data'];

    String displayName = '';
    if (type == 'Quotation') {
      displayName = '${data.fname} ${data.lname}';
    } else if (type == 'Analysis') {
      displayName = data.username;
    } else {
      displayName = data.name;
    }

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
      details['Phone'] = '${data.countryCode ?? ""} ${data.phone}'.trim();
      details['Company'] = data.company ?? 'N/A';
      details['Message'] = data.message ?? 'N/A';
    } else if (type == 'Quotation') {
      details['Phone'] = '${data.code ?? ""} ${data.phone}'.trim();
      details['Service'] = data.service;
      details['Main Service'] = data.mainservice;
      details['Priority'] = data.priority ?? 'N/A';
      details['Web Address'] = data.webAddress;
      details['Duration'] = '${data.duration ?? ""} - ${data.endduration ?? ""}'.trim();
      if (details['Duration'] == '-') details['Duration'] = 'N/A';
      details['Total Price'] = data.totalPrice ?? 'N/A';
      details['Service Price'] = data.servicePrice ?? 'N/A';
      details['Priority Price'] = data.priorityPrice ?? 'N/A';
      details['Description'] = data.description;
    } else if (type == 'Hire') {
      details['Phone'] = '${data.code ?? ""} ${data.phone}'.trim();
      details['Message'] = data.message;
    } else if (type == 'Analysis') {
      details['Website'] = data.website;
      details['Message'] = data.message;
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
