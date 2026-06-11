import 'package:flutter/material.dart';
import '../constants.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Top Players'),
          bottom: const TabBar(
            labelColor: AppColors.primaryOrange,
            unselectedLabelColor: AppColors.textLight,
            indicatorColor: AppColors.primaryOrange,
            tabs: [
              Tab(text: 'Daily Tops'),
              Tab(text: 'Monthly Tops'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildPlayerList('Daily'),
            _buildPlayerList('Monthly'),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerList(String period) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 20,
      itemBuilder: (context, index) {
        bool isTopThree = index < 3;
        return Card(
          elevation: isTopThree ? 4 : 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isTopThree 
                ? BorderSide(color: index == 0 ? Colors.amber : (index == 1 ? Colors.grey : Colors.brown), width: 2)
                : BorderSide.none,
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: isTopThree ? AppColors.primaryOrange.withOpacity(0.2) : AppColors.backgroundLight,
              child: Text(
                '${index + 1}',
                style: TextStyle(
                  color: isTopThree ? AppColors.primaryOrange : AppColors.textDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text('Player ${index + 1}'),
            subtitle: Text('Territories Captured: ${50 - index}'),
            trailing: Text(
              '${(10000 - (index * 400))} XP',
              style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryGreen),
            ),
          ),
        );
      },
    );
  }
}
