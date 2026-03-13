import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../routes/app_routes.dart';
import '../providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.locale,
    required this.onToggleTheme,
    required this.onChangeLocale,
    required this.colorIndex,
    required this.onChangeColor,
    required this.fontIndex,
    required this.onChangeFont,
  });

  final Locale locale;
  final VoidCallback onToggleTheme;
  final void Function(Locale) onChangeLocale;
  final int colorIndex;
  final void Function(int) onChangeColor;
  final int fontIndex;
  final void Function(int) onChangeFont;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                  child: Icon(Icons.person, size: 40),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.qr_code_scanner),
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.camera);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              auth.user?.emailOrPhone ?? 'Guest',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Welcome back to Coffee App!',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: onToggleTheme,
              child: Text(
                'Appearance',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                FilterChip(
                  label: const Text('Light/Dark'),
                  selected: false,
                  onSelected: (_) => onToggleTheme(),
                ),
                ChoiceChip(
                  label: const Text('Orange'),
                  selected: colorIndex == 0,
                  onSelected: (_) => onChangeColor(0),
                ),
                ChoiceChip(
                  label: const Text('Brown'),
                  selected: colorIndex == 1,
                  onSelected: (_) => onChangeColor(1),
                ),
                ChoiceChip(
                  label: const Text('Teal'),
                  selected: colorIndex == 2,
                  onSelected: (_) => onChangeColor(2),
                ),
              ],
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => onChangeFont((fontIndex + 1) % 3),
              child: Text(
                'Font',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('Default'),
                  selected: fontIndex == 0,
                  onSelected: (_) => onChangeFont(0),
                ),
                ChoiceChip(
                  label: const Text('Serif'),
                  selected: fontIndex == 1,
                  onSelected: (_) => onChangeFont(1),
                ),
                ChoiceChip(
                  label: const Text('Mono'),
                  selected: fontIndex == 2,
                  onSelected: (_) => onChangeFont(2),
                ),
              ],
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                if (locale.languageCode == 'en') {
                  onChangeLocale(const Locale('km'));
                } else if (locale.languageCode == 'km') {
                  onChangeLocale(const Locale('zh'));
                } else {
                  onChangeLocale(const Locale('en'));
                }
              },
              child: Text(
                'Language',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('English'),
                  selected: locale.languageCode == 'en',
                  onSelected: (_) => onChangeLocale(const Locale('en')),
                ),
                ChoiceChip(
                  label: const Text('Khmer'),
                  selected: locale.languageCode == 'km',
                  onSelected: (_) => onChangeLocale(const Locale('km')),
                ),
                ChoiceChip(
                  label: const Text('Chinese'),
                  selected: locale.languageCode == 'zh',
                  onSelected: (_) => onChangeLocale(const Locale('zh')),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.receipt_long),
              title: const Text('Order History'),
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.orders);
              },
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () async {
                await auth.logout();
                if (context.mounted) {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(AppRoutes.login, (_) => false);
                }
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}



