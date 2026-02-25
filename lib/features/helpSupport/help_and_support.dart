import 'package:flutter/material.dart';
import 'package:think_and_wash/core/app_colors.dart';

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(
          "Help & Support",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
        children: [
          /// Categories
          _sectionTitle("Support"),

          _supportTile(
            icon: Icons.wechat,
            title: "Chat with us ",
            subtitle: "92XXXXX776",
            context: context,
          ),

          _supportTile(
            icon: Icons.call_outlined,
            title: "Call support",
            subtitle: "92XXXXX776",
            context: context,
          ),

          _supportTile(
            icon: Icons.email_outlined,
            title: "Email us",
            subtitle: "supportthinkandwash@gmail.com",
            context: context,
          ),

          const SizedBox(height: 24),

          _sectionTitle("Common Issues"),

          _supportTile(
            icon: Icons.local_laundry_service_outlined,
            title: "Order related help",
            subtitle: "Pickup, delay, missing items",
            context: context,
          ),

          _supportTile(
            icon: Icons.payment_outlined,
            title: "Payment & refund",
            subtitle: "Billing issues",
            context: context,
          ),

          const SizedBox(height: 24),
          SizedBox(child: Image.asset("assets/help-support.webp")),
        ],
      ),
    );
  }

  /// Section title
  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }

  /// Tile
  Widget _supportTile({
    required IconData icon,
    required String title,
    required String subtitle,
    BuildContext? context,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          color: AppColors.background,
          boxShadow: [
            BoxShadow(
              color: AppColors.boxShadowPink,
              blurRadius: 10,
              spreadRadius: -5,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Icon(icon, color: AppColors.boxShadowblue),
      ),
      title: Text(title),
      subtitle: Text(subtitle, style: Theme.of(context!).textTheme.bodySmall),

      onTap: () {},
    );
  }
}
