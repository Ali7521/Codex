import 'package:flutter/material.dart';
import '../constants.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> rewards = const [
    {'name': 'Territory Go Water Bottle', 'icon': Icons.local_drink, 'points': 5000},
    {'name': 'Megabyte T-Shirt', 'icon': Icons.checkroom, 'points': 12000},
    {'name': 'Premium Wireless Headphones', 'icon': Icons.headphones, 'points': 25000},
    {'name': 'Gym Duffle Bag', 'icon': Icons.backpack, 'points': 18000},
    {'name': '500 Bonus XP', 'icon': Icons.star, 'points': 1000},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Rewards'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            width: double.infinity,
            color: AppColors.primaryGreen.withOpacity(0.1),
            child: Column(
              children: [
                const Text('Your Reward Points', style: TextStyle(color: AppColors.textLight)),
                const SizedBox(height: 8),
                const Text('4,250', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppColors.primaryGreen)),
                const SizedBox(height: 16),
                LinearProgressIndicator(
                  value: 4250 / 5000,
                  backgroundColor: Colors.white,
                  color: AppColors.primaryOrange,
                  minHeight: 12,
                  borderRadius: BorderRadius.circular(6),
                ),
                const SizedBox(height: 8),
                const Text('750 points until next reward!', style: TextStyle(fontSize: 12, color: AppColors.textDark)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: rewards.length,
              itemBuilder: (context, index) {
                final reward = rewards[index];
                bool canRedeem = 4250 >= reward['points'];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundLight,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(reward['icon'], size: 40, color: AppColors.textDark),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(reward['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              const SizedBox(height: 8),
                              Text('${reward['points']} Points', style: const TextStyle(color: AppColors.primaryOrange, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: canRedeem ? () {} : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: canRedeem ? AppColors.primaryGreen : Colors.grey.shade300,
                            foregroundColor: canRedeem ? Colors.white : Colors.grey.shade600,
                          ),
                          child: const Text('Redeem'),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
