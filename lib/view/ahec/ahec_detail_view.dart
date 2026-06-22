import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/color/app_color.dart';

class AhecDetailView extends StatelessWidget {
  const AhecDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments = Get.arguments;
    final String type = arguments['type'];
    final dynamic data = arguments['data'];

    String headerName = 'AHEC User';
    if (type == 'Queries') {
      headerName = data.fullName;
    } else if (type == 'Registration') {
      headerName = data.userName ?? 'User';
    } else if (type == 'FL Registration' || type == 'Affiliate') {
      headerName = data.afName ?? 'User';
    } else if (type == 'Newsletter') {
      headerName = data.qEmail ?? 'Newsletter';
    }

    return Scaffold(
      backgroundColor: AppColor.kColorBackground,
      appBar: AppBar(
        title: Text('AHEC $type Details'),
        backgroundColor: AppColor.kColorPrimary,
        foregroundColor: AppColor.whiteColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailHeader(headerName, type),
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
            textAlign: TextAlign.center,
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

    if (type == 'Queries') {
      details['Email'] = data.enEmail ?? 'N/A';
      details['Phone'] = '${data.phoneCode ?? ''} ${data.enMobile ?? ''}';
      details['Service'] = data.enService ?? 'N/A';
      details['Subject'] = data.enSubjectName ?? data.enSubject ?? 'N/A';
      details['University'] = data.enUniversityName ?? data.univercityName ?? 'N/A';
      details['Price'] = '${data.currencyType ?? ''} ${data.enPrice ?? ''}';
      details['Deadline'] = data.deadline ?? 'N/A';
      details['Order Number'] = data.orderNumber ?? 'N/A';
      details['Query'] = data.enQuery ?? 'N/A';
      details['Created At'] = data.enCreatedAt ?? 'N/A';
    } else if (type == 'Registration') {
      details['Email'] = data.userEmail ?? 'N/A';
      details['Phone'] = '${data.phoneCode ?? ''} ${data.mobile ?? ''}';
      details['University'] = data.univercityName ?? 'N/A';
      details['Status'] = data.userStatus == '1' ? 'Active' : 'Inactive';
      details['Created At'] = data.userCreatedAt ?? 'N/A';
    } else if (type == 'FL Registration') {
      details['Email'] = data.afEmail ?? 'N/A';
      details['Phone'] = '${data.countryCode ?? ''} ${data.afMobile ?? ''}';
      details['Address'] = data.afAddress ?? 'N/A';
      details['Aadhar'] = data.aadharNumber ?? 'N/A';
      details['PAN'] = data.panNumber ?? 'N/A';
      details['Bank'] = '${data.bankName ?? ''} (${data.bankNo ?? ''})';
      details['IFSC'] = data.bankIfsc ?? 'N/A';
      details['Created At'] = data.afCrateedAt ?? 'N/A';
    } else if (type == 'Affiliate') {
      details['Email'] = data.afEmail ?? 'N/A';
      details['Phone'] = '${data.countryCode ?? ''} ${data.afMobile ?? ''}';
      details['Address'] = data.afAddress ?? 'N/A';
      details['Created At'] = data.afCrateedAt ?? 'N/A';
    } else if (type == 'Newsletter') {
      details['Name'] = data.qName ?? 'N/A';
      details['Email'] = data.qEmail ?? 'N/A';
      details['Phone'] = data.qNumber ?? 'N/A';
      details['Message'] = data.qMessage ?? 'N/A';
      details['Created At'] = data.createdAt ?? 'N/A';
    }

    return Column(
      children: details.entries
          .where((e) => e.value.trim().isNotEmpty && e.value != 'null')
          .map((entry) => _buildDetailItem(entry.key, entry.value))
          .toList(),
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
