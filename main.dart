import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(const NoorApp());

class NoorApp extends StatelessWidget {
  const NoorApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Noor Islamic Calendar',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF087D68)), useMaterial3: true),
    home: const HomePage(),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime month = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final count = DateUtils.getDaysInMonth(month.year, month.month);
    final offset = DateTime(month.year, month.month, 1).weekday % 7;
    return Scaffold(
      appBar: AppBar(title: const Text('🌙 Noor Islamic Calendar'), actions: [
        IconButton(icon: const Icon(Icons.account_circle_outlined), onPressed: () => showAboutDialog(
          context: context, applicationName: 'Noor Islamic Calendar',
          children: const [Text('এই অ্যাপটি তৈরি করেছেন'), Text('মাসুম — App Developer & Creator')],
        )),
      ]),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFF075B50), Color(0xFF109477)]),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('আসসালামু আলাইকুম', style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 8),
            Text(DateFormat('EEEE, d MMMM yyyy').format(now),
              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text('বাংলা • English • Arabic', style: TextStyle(color: Colors.white)),
            const SizedBox(height: 6),
            const Text('হিজরি তারিখ ও নামাজের সময় সংযুক্তির প্রস্তুতি চলছে',
              style: TextStyle(color: Colors.white70)),
          ]),
        ),
        const SizedBox(height: 18),
        const Text('আজকের নামাজের সময়', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Wrap(spacing: 8, runSpacing: 8, children: [
          PrayerCard('ফজর'), PrayerCard('যোহর'), PrayerCard('আসর'),
          PrayerCard('মাগরিব'), PrayerCard('এশা'),
        ]),
        const SizedBox(height: 18),
        Row(children: [
          const Expanded(child: Text('ক্যালেন্ডার', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold))),
          IconButton(onPressed: () => setState(() => month = DateTime(month.year, month.month - 1)), icon: const Icon(Icons.chevron_left)),
          Text(DateFormat('MMMM yyyy').format(month)),
          IconButton(onPressed: () => setState(() => month = DateTime(month.year, month.month + 1)), icon: const Icon(Icons.chevron_right)),
        ]),
        const Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text('রবি'), Text('সোম'), Text('মঙ্গল'), Text('বুধ'), Text('বৃহঃ'), Text('শুক্র'), Text('শনি'),
        ]),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
          itemCount: offset + count,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, mainAxisSpacing: 5, crossAxisSpacing: 5),
          itemBuilder: (context, i) {
            if (i < offset) return const SizedBox.shrink();
            final d = i - offset + 1;
            final today = now.year == month.year && now.month == month.month && now.day == d;
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: today ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
              ),
              child: Text('$d', style: TextStyle(color: today ? Colors.white : null, fontWeight: FontWeight.bold)),
            );
          },
        ),
        const SizedBox(height: 16),
        const FeatureTile(Icons.wb_sunny_outlined, 'সূর্যোদয় ও সূর্যাস্ত', 'স্থানীয় সময় সংযুক্ত করা বাকি'),
        const FeatureTile(Icons.explore_outlined, 'কিবলা কম্পাস', 'পরবর্তী সংস্করণে'),
        const FeatureTile(Icons.notifications_active_outlined, 'আজান অ্যালার্ম', 'এখনো চালু নয়'),
        const FeatureTile(Icons.event_outlined, 'ইসলামিক ছুটি ও রমজান', 'যাচাইকৃত ডেটা সংযুক্ত করা বাকি'),
        const SizedBox(height: 12),
        const Center(child: Text('Created with credit to Masum', style: TextStyle(color: Colors.grey))),
      ]),
    );
  }
}

class PrayerCard extends StatelessWidget {
  final String name;
  const PrayerCard(this.name, {super.key});
  @override
  Widget build(BuildContext context) => Container(
    width: 100, padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(14), border: Border.all(color: Theme.of(context).colorScheme.outlineVariant)),
    child: Column(children: [Text(name, style: const TextStyle(fontWeight: FontWeight.bold)), const SizedBox(height: 5), const Text('--:--')]),
  );
}

class FeatureTile extends StatelessWidget {
  final IconData icon; final String title; final String subtitle;
  const FeatureTile(this.icon, this.title, this.subtitle, {super.key});
  @override
  Widget build(BuildContext context) => Card(child: ListTile(
    leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
    title: Text(title), subtitle: Text(subtitle),
  ));
}
