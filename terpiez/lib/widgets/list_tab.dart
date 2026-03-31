import 'package:flutter/material.dart';

import 'package:terpiez/models/terpiez_type.dart';
import 'package:terpiez/screens/terpiez_details_screen.dart';

class ListTab extends StatelessWidget {
  const ListTab({super.key});

  static const List<TerpiezType> terpiezTypes = [
    TerpiezType(name: 'Fire Terpiez', icon: Icons.local_fire_department),
    TerpiezType(name: 'Water Terpiez', icon: Icons.water_drop),
    TerpiezType(name: 'Grass Terpiez', icon: Icons.grass),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: terpiezTypes.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final terpiezType = terpiezTypes[index];

        return Card(
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            leading: Icon(terpiezType.icon, size: 28),
            title: Text(terpiezType.name),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) =>
                      TerpiezDetailsScreen(terpiezType: terpiezType),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
