import 'package:flutter/material.dart';
import '../constants.dart';

class GuildScreen extends StatelessWidget {
  const GuildScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Guilds'),
          bottom: const TabBar(
            labelColor: AppColors.primaryGreen,
            unselectedLabelColor: AppColors.textLight,
            indicatorColor: AppColors.primaryGreen,
            tabs: [
              Tab(text: 'My Guild'),
              Tab(text: 'Leaderboard'),
              Tab(text: 'Chat'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildMyGuildTab(context),
            _buildGuildLeaderboardTab(),
            _buildGuildChatTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildMyGuildTab(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(Icons.shield, size: 80, color: AppColors.primaryGreen),
          const SizedBox(height: 24),
          const Text(
            'You are not in a guild!',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            'Join a guild to capture larger territories and compete globally.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textLight),
          ),
          const SizedBox(height: 32),
          ElevatedButton(onPressed: () {}, child: const Text('Join a Guild')),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primaryOrange,
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: AppColors.primaryOrange),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Create a Guild', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildGuildLeaderboardTab() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: AppColors.backgroundLight,
            child: Text('${index + 1}', style: const TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold)),
          ),
          title: Text('Guild Alpha ${index + 1}'),
          subtitle: Text('${10000 - (index * 500)} Points'),
          trailing: const Icon(Icons.chevron_right),
        );
      },
    );
  }

  Widget _buildGuildChatTab() {
    return const Center(
      child: Text('Join a guild to access chat.', style: TextStyle(color: AppColors.textLight)),
    );
  }
}
