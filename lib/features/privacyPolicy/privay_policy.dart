import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class PrivayPolicy extends StatelessWidget {
  const PrivayPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.background,
        title: Text(
          'Privacy & Policy',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionTitle("General Policies", context),

          _policyText(
            "No query will be retained regarding damage or missing products after 1 hour of delivery.",
            context,
          ),

          _policyText(
            "Help & Support call and chat services are available from 10:00 AM to 5:00 PM.",
            context,
          ),

          _policyText(
            "Fast delivery within 24 hours (next-day delivery).",
            context,
          ),

          _policyText(
            "Minimum order value must be greater than ₹150 for free delivery.",
            context,
          ),

          const SizedBox(height: 24),

          _sectionTitle("Watch & Earn Policy", context),

          _policyText("Watch ads to earn coins.", context),
          _policyText(
            "Use coins to make your next order free or to pay partially.",
            context,
          ),

          const SizedBox(height: 24),

          _sectionTitle("Customer Support", context),

          _supportLine(
            "We are always available for you and your laundry needs.",
            context,
          ),
          _supportLine("Your feedback matters to us.", context),
          _supportLine("Show love by sharing your experience.", context),
          _supportLine(
            "Our team works continuously to provide faster and better service.",
            context,
          ),
          _supportLine(
            "Thank you for trusting us — we care for your clothes like our own ❤️",
            context,
          ),

          const SizedBox(height: 30),

          Center(
            child: Text(
              "Last updated: Today",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  /// Section title
  Widget _sectionTitle(String text, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(text, style: Theme.of(context).textTheme.bodyLarge),
    );
  }

  Widget _policyText(String text, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: Icon(Icons.circle, size: 8),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      ),
    );
  }

  Widget _supportLine(String text, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: Theme.of(context).textTheme.bodySmall),
    );
  }
}
