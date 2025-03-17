import 'package:flutter/material.dart';
import 'package:linkai/core/models/company_model.dart';
import 'package:linkai/core/utils/app_styles.dart';

class DetailsSection extends StatelessWidget {
  const DetailsSection({super.key, required this.company});

  final CompanyModel company;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailItem(
            context,
            'Description',
            company.description,
            Icons.description,
          ),
          const SizedBox(height: 16),
          _buildDetailItem(
            context,
            'Email',
            company.companyEmail,
            Icons.email,
          ),
          const SizedBox(height: 16),
          _buildDetailItem(
            context,
            'Location',
            company.address,
            Icons.location_on,
          ),
          const SizedBox(height: 16),
          _buildDetailItem(
            context,
            'Industry',
            company.industry,
            Icons.business,
          ),
          const SizedBox(height: 16),
          _buildDetailItem(
            context,
            'Company Size',
            '${company.minEmployees} - ${company.maxEmployees} employees',
            Icons.people,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(BuildContext context, String label, String? value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppStyles.semiBold16(
                    context,
                    Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value ?? 'Not specified',
                  style: AppStyles.normal16(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
