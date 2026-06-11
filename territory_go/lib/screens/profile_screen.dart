import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../providers/game_state_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameStateProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Player Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundColor: AppColors.primaryGreen,
              child: Icon(Icons.person, size: 80, color: Colors.white),
            ),
            const SizedBox(height: 16),
            const Text('PlayerOne', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            Text('Level ${gameState.level} Conqueror', style: const TextStyle(fontSize: 18, color: AppColors.primaryOrange)),
            const SizedBox(height: 32),
            _buildStatsRow(gameState.playerXP, gameState.streakCount),
            const SizedBox(height: 32),
            _buildBadgesSection(),
            const SizedBox(height: 32),
            _buildStreakHistory(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow(int xp, int streak) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem('Total XP', '$xp', Icons.star),
        Container(height: 50, width: 1, color: Colors.grey.shade300),
        _buildStatItem('Daily Streak', '$streak', Icons.local_fire_department),
        Container(height: 50, width: 1, color: Colors.grey.shade300),
        _buildStatItem('Zones', '42', Icons.flag),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppColors.textLight),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textDark)),
        Text(label, style: const TextStyle(color: AppColors.textLight, fontSize: 12)),
      ],
    );
  }

  Widget _buildBadgesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Earned Badges', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark)),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _buildBadge(Icons.directions_walk, 'Marathoner', AppColors.primaryGreen),
            _buildBadge(Icons.flag, 'First Capture', AppColors.primaryOrange),
            _buildBadge(Icons.local_police, 'Defender', AppColors.privateZone),
            _buildBadge(Icons.groups, 'Team Player', AppColors.neutralZone),
          ],
        )
      ],
    );
  }

  Widget _buildBadge(IconData icon, String label, Color color) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color, size: 30),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildStreakHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Streak History', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark)),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surfaceWhite,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (index) {
              bool isAchieved = index < 5;
              return Column(
                children: [
                  Text(['M', 'T', 'W', 'T', 'F', 'S', 'S'][index], style: const TextStyle(color: AppColors.textLight, fontSize: 12)),
                  const SizedBox(height: 8),
                  Icon(
                    isAchieved ? Icons.check_circle : Icons.circle_outlined,
                    color: isAchieved ? AppColors.primaryGreen : Colors.grey.shade300,
                  ),
                ],
              );
            }),
          ),
        )
      ],
    );
  }
}
