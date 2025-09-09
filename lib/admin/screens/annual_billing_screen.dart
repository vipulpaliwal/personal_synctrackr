import 'package:flutter/material.dart';

class AnnualBillingScreen extends StatefulWidget {
  const AnnualBillingScreen({super.key});

  @override
  State<AnnualBillingScreen> createState() => _AnnualBillingScreenState();
}

class _AnnualBillingScreenState extends State<AnnualBillingScreen> {
  int _selectedAnnualPlan = 0;
  bool _autoRenew = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Enable auto renewal",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF212529)),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Checking this will auto-renew your plan after it expires",
                      style: TextStyle(
                          fontSize: 12, color: Color(0xFF6C757D)),
                    ),
                  ],
                ),
                Switch(
                  value: _autoRenew,
                  onChanged: (value) {
                    setState(() {
                      _autoRenew = value;
                    });
                  },
                  activeColor: const Color(0xFF4C6FFF),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: _buildPlanCard(
                  title: "Basic Plan",
                  price: "₹699/month",
                  features: "Ideal for small offices that require simple visitor management with team collaboration.",
                  isSelected: _selectedAnnualPlan == 0,
                  onTap: () => setState(() => _selectedAnnualPlan = 0),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _buildPlanCard(
                  title: "Standard Plan",
                  price: "₹1,299/month",
                  features: "Designed for growing businesses with multi-device support and advanced visitor validation.",
                  isSelected: _selectedAnnualPlan == 1,
                  onTap: () => setState(() => _selectedAnnualPlan = 1),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: _buildPlanCard(
                  title: "Premium Plan",
                  price: "₹2,499/month",
                  features: "A comprehensive solution for large organizations with advanced security and flexible visitor handling.",
                  isSelected: _selectedAnnualPlan == 2,
                  onTap: () => setState(() => _selectedAnnualPlan = 2),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildEnterpriseCard(),
        ],
      ),
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String price,
    required String features,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4C6FFF).withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF4C6FFF) : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF212529)),
                ),
                if (isSelected)
                  const Icon(
                    Icons.check_circle,
                    color: Color(0xFF4C6FFF),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              price,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212529)),
            ),
            const SizedBox(height: 4),
            const Text(
              "View Features",
              style: TextStyle(
                  color: Color(0xFF4C6FFF),
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline),
            ),
            const SizedBox(height: 10),
            Text(
              features,
              style: const TextStyle(color: Color(0xFF6C757D), fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEnterpriseCard() {
    return Stack(
      children: [
        // This is the gradient background for the thin border
        Container(
          width: double.infinity,
          height: 128, // Height is now correct
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              // Subtle pink gradient colors
              colors: [Color(0xFFFDE8F1), Color(0xFFF9B8D8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        // This is the main white container with a margin to create the border effect
        Container(
          width: double.infinity,
          height: 125, // Height is now correct
          margin: const EdgeInsets.all(1.5), // This value controls the border thickness
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.5), // Adjusted radius for a smooth look
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Enterprise Plan",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF212529)),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Available",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Personalized Prices | Completely Customized to Your Company",
                      style: TextStyle(color: Color(0xFF6C757D), fontSize: 12),
                    ),
                    Text(
                      "A visitor management system that can grow with your business and be fully customized to fit your needs.",
                      style: TextStyle(color: Color(0xFF6C757D), fontSize: 12),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4C6FFF),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: const Text("Connect with Us"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}