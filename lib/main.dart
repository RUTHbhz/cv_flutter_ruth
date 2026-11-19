import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const ink = Color(0xFF0D1011);
const paper = Color(0xFFF4F9FC);
const copper = Color(0xFFC87843);
const copperLight = Color(0xFFE3A06D);
const muted = Color(0xFF718087);

void main() => runApp(const CvApp());

class CvApp extends StatelessWidget {
  const CvApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ruth — CV mobile',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: paper,
        colorScheme: ColorScheme.fromSeed(seedColor: copper, brightness: Brightness.light),
        fontFamily: 'Arial',
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final user = TextEditingController();
  final password = TextEditingController();
  bool hidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, c) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(26),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: c.maxHeight - 52),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const SizedBox(height: 44),
                Container(width: 52, height: 52, alignment: Alignment.center, decoration: BoxDecoration(color: ink, borderRadius: BorderRadius.circular(17)), child: const Text('R', style: TextStyle(color: copperLight, fontSize: 26, fontWeight: FontWeight.w800))),
                const SizedBox(height: 42),
                const Text('Bienvenue.', style: TextStyle(color: ink, fontSize: 38, fontWeight: FontWeight.w800, letterSpacing: -1.2)),
                const SizedBox(height: 10),
                const Text('Découvrez mon univers professionnel\net personnel.', style: TextStyle(color: muted, fontSize: 16, height: 1.5)),
                const SizedBox(height: 38),
                _field('IDENTIFIANT', 'Identifiant', user, Icons.person_outline),
                const SizedBox(height: 16),
                TextField(controller: password, obscureText: hidden, decoration: _decoration('MOT DE PASSE', Icons.lock_outline).copyWith(suffixIcon: IconButton(onPressed: () => setState(() => hidden = !hidden), icon: Icon(hidden ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: muted)))),
                const SizedBox(height: 26),
                SizedBox(width: double.infinity, height: 56, child: FilledButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Shell())), style: FilledButton.styleFrom(backgroundColor: ink, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))), child: const Text('Se connecter', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)))),
                const SizedBox(height: 24),
                const Center(child: Text('CV personnel • Goma · RDC', style: TextStyle(color: muted, fontSize: 12))),
                const SizedBox(height: 26),
              ]),
            ),
          );
        }),
      ),
    );
  }

  Widget _field(String label, String hint, TextEditingController controller, IconData icon) => TextField(controller: controller, decoration: _decoration(label, icon).copyWith(hintText: hint));
  InputDecoration _decoration(String label, IconData icon) => InputDecoration(labelText: label, labelStyle: const TextStyle(color: muted, fontSize: 11, letterSpacing: 1.2, fontWeight: FontWeight.w700), prefixIcon: Icon(icon, color: copper), filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: copper, width: 1.5)));
}

class Shell extends StatefulWidget {
  const Shell({super.key});
  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  int index = 0;
  final pages = const [AccueilPage(), FamilyPage(), ContactPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: NavigationBar(selectedIndex: index, onDestinationSelected: (i) => setState(() => index = i), backgroundColor: Colors.white, indicatorColor: copper.withOpacity(.15), destinations: const [NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded, color: copper), label: 'Accueil'), NavigationDestination(icon: Icon(Icons.people_outline), selectedIcon: Icon(Icons.people, color: copper), label: 'Famille'), NavigationDestination(icon: Icon(Icons.alternate_email), selectedIcon: Icon(Icons.alternate_email, color: copper), label: 'Contact')]),
    );
  }
}

class AccueilPage extends StatelessWidget {
  const AccueilPage({super.key});
  @override
  Widget build(BuildContext context) {
    return _page(
      'ACCUEIL',
      SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 22, 24, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _TopBar(title: 'ACCUEIL'),
            const SizedBox(height: 24),
            _hero(),
            const SizedBox(height: 34),
            _section('IDENTITÉ', const _IdentityCard()),
            const SizedBox(height: 30),
            _section(
              'PROFIL PROFESSIONNEL',
              const Text(
                'Étudiante en troisième année de Licence en Génie Logiciel à ISIG Goma, passionnée par le développement logiciel, les technologies web et la résolution de problèmes informatiques. Développeuse orientée JavaScript et SQL, avec des compétences en création d’applications web modernes et en gestion de bases de données. Je possède également des compétences en communication et storytelling, me permettant de transmettre des idées de manière claire, créative et impactante.',
                style: TextStyle(color: ink, fontSize: 16, height: 1.5, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 30),
            _section(
              'ÉDUCATION',
              const Column(
                children: [
                  _TimelineItem(year: '2023 — présent', title: 'Baccalauréat en Génie Logiciel', place: 'ISIG Goma · Goma, RDC', active: true),
                  _TimelineItem(year: '2017 — 2023', title: 'Diplôme d’État — Section Sciences', place: 'Institut Isidore Bakanja · Goma, RDC'),
                  _TimelineItem(year: '2011 — 2017', title: 'Certificat d’Études Primaires', place: 'École Primaire BUSIMBA · Goma, RDC'),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _section('COMPÉTENCES LOGICIELLES', const _SkillGrid()),
            const SizedBox(height: 30),
            _section('OUTILS & TECHNOLOGIES', const Text('Git & GitHub  •  Développement Web Front-end  •  Conception de bases de données  •  Résolution de problèmes algorithmiques', style: TextStyle(color: muted, fontSize: 15, height: 1.5))),
            const SizedBox(height: 30),
            _section('EXPÉRIENCE BÉNÉVOLE', const Column(children: [
              _TimelineItem(year: '2022 — présent', title: 'Volontaire et encadreur', place: 'Organisation pour les Enfants Démunis · Goma', active: true),
              _TimelineItem(year: '2023', title: 'Sensibilisation environnementale', place: 'Campagnes contre le réchauffement climatique · Goma'),
            ])),
            const SizedBox(height: 30),
            _section('LANGUES & QUALITÉS', const Text('Kiswahili : langue maternelle\nFrançais : courant\nAnglais : courant\n\nEsprit d’analyse et de créativité · communication · travail en équipe · adaptabilité et autonomie · passion pour la technologie · storytelling et rédaction', style: TextStyle(color: muted, fontSize: 15, height: 1.5))),
            const SizedBox(height: 30),
            _section('BREVETS & CERTIFICATS', const Text('1st & 2nd level — English training at PYE\nFormation de montage de dossier artistique — ECLOSION HUB\nJENGA HACKATON 2024\nTestDome — JavaScript & SQL', style: TextStyle(color: muted, fontSize: 15, height: 1.5))),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final String title;
  const _TopBar({required this.title});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(color: copper, fontSize: 11, letterSpacing: 1.8, fontWeight: FontWeight.w800)),
            Container(width: 48, height: 48, decoration: BoxDecoration(color: ink, borderRadius: BorderRadius.circular(16)), child: const Center(child: Text('BBR', style: TextStyle(color: copperLight, fontSize: 12, fontWeight: FontWeight.w800)))),
          ],
        ),
      );
}

Widget _page(String label, Widget child) => SafeArea(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: child)]));
Widget _section(String title, Widget child) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: copper, fontSize: 11, letterSpacing: 1.8, fontWeight: FontWeight.w800)), const SizedBox(height: 12), child]);
Widget _hero() => Row(crossAxisAlignment: CrossAxisAlignment.center, children: [ClipRRect(borderRadius: BorderRadius.circular(28), child: Image.asset('assets/portraits/ruth-profile.jpeg', width: 96, height: 96, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(width: 96, height: 96, color: copperLight, alignment: Alignment.center, child: const Text('RB', style: TextStyle(color: ink, fontSize: 30, fontWeight: FontWeight.w900))))), const SizedBox(width: 18), const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Ruth Bwiza Bahizi', style: TextStyle(color: ink, fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: -1)), SizedBox(height: 6), Text('Étudiante en Génie Logiciel · ISIG Goma', style: TextStyle(color: muted, fontSize: 14, height: 1.3))]))]);

class _IdentityCard extends StatelessWidget {
  const _IdentityCard();
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: const Column(children: [
          _InfoLine(label: 'Nom complet', value: 'BWIZA BAHIZI RUTH'),
          _InfoLine(label: 'Sexe · Nationalité', value: 'Femme · Congolaise'),
          _InfoLine(label: 'État civil', value: 'Célibataire'),
          _InfoLine(label: 'Naissance', value: 'Goma, le 24/10/2006'),
          _InfoLine(label: 'Adresse', value: 'Goma ville, commune de Goma, Q. Kyeshero n°78'),
        ]),
      );
}

class _InfoLine extends StatelessWidget {
  final String label;
  final String value;
  const _InfoLine({required this.label, required this.value});
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.only(bottom: 12), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [SizedBox(width: 112, child: Text(label, style: const TextStyle(color: muted, fontSize: 12, fontWeight: FontWeight.w700))), Expanded(child: Text(value, style: const TextStyle(color: ink, fontSize: 13, fontWeight: FontWeight.w700, height: 1.3)))]));
}

class _SkillGrid extends StatelessWidget {
  const _SkillGrid();
  @override
  Widget build(BuildContext context) => Wrap(spacing: 8, runSpacing: 8, children: ['HTML / CSS · bien', 'Bootstrap · bien', 'jQuery · bien', 'PHP · intermédiaire', 'SQL · intermédiaire', 'JavaScript · intermédiaire'].map((skill) => Chip(label: Text(skill), side: BorderSide.none, backgroundColor: Colors.white, labelStyle: const TextStyle(color: ink, fontWeight: FontWeight.w600, fontSize: 12))).toList());
}

class _TimelineItem extends StatelessWidget { final String year, title, place; final bool active; const _TimelineItem({required this.year, required this.title, required this.place, this.active = false}); @override Widget build(BuildContext context) => Padding(padding: const EdgeInsets.only(bottom: 18), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Container(width: 10, height: 10, margin: const EdgeInsets.only(top: 5, right: 14), decoration: BoxDecoration(color: active ? copper : copperLight, shape: BoxShape.circle)), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(year, style: const TextStyle(color: copper, fontSize: 12, fontWeight: FontWeight.w700)), const SizedBox(height: 3), Text(title, style: const TextStyle(color: ink, fontSize: 16, fontWeight: FontWeight.w700)), Text(place, style: const TextStyle(color: muted, fontSize: 13))]))])); }

class FamilyPage extends StatelessWidget {
  const FamilyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final members = [
      ('Maman', 'KABERA', 'Commerçante', 'assets/portraits/family-mother.jpeg', 'K'),
      ('Papa', 'BAHIZI', 'Enseignant', 'assets/portraits/family-father.jpeg', 'B'),
      ('Sœur', 'BAKUNZI', 'Comptable', 'assets/portraits/family-sister.jpeg', 'B'),
      ('Frère', 'NISHIMWE', 'Ingénieur', 'assets/portraits/family-brother.jpeg', 'N'),
    ];
    return _page(
      'MON CERCLE',
      SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 22, 24, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _TopBar(title: 'MA FAMILLE'),
            const SizedBox(height: 26),
            const Text('Une famille,\nune force.', style: TextStyle(color: ink, fontSize: 34, fontWeight: FontWeight.w800, height: 1.1)),
            const SizedBox(height: 10),
            const Text('Les personnes qui m’inspirent au quotidien.', style: TextStyle(color: muted, fontSize: 15)),
            const SizedBox(height: 26),
            ...members.map((f) => Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  elevation: 0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                    leading: _FamilyAvatar(asset: f.$4, initials: f.$5),
                    title: Text(f.$2, style: const TextStyle(color: ink, fontWeight: FontWeight.w800)),
                    subtitle: Text('${f.$1} · ${f.$3}', style: const TextStyle(color: muted)),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 15, color: copper),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class _FamilyAvatar extends StatelessWidget {
  final String asset;
  final String initials;
  const _FamilyAvatar({required this.asset, required this.initials});

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 52,
      child: CircleAvatar(
        radius: 26,
        backgroundColor: copperLight,
        foregroundImage: AssetImage(asset),
        onForegroundImageError: (_, __) {},
        child: Text(initials, style: const TextStyle(color: ink, fontSize: 20, fontWeight: FontWeight.w800)),
      ),
    );
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _page(
      'ME CONTACTER',
      SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 22, 24, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _TopBar(title: 'ME CONTACTER'),
            const SizedBox(height: 30),
            const Text('Parlons de\nvos projets.', style: TextStyle(color: ink, fontSize: 34, fontWeight: FontWeight.w800, height: 1.1)),
            const SizedBox(height: 12),
            const Text('Une idée, une collaboration ou simplement envie d’échanger ? Ma boîte mail est ouverte.', style: TextStyle(color: muted, fontSize: 15, height: 1.4)),
            const SizedBox(height: 30),
            _contact(context, Icons.phone_outlined, 'Téléphone', '+27 71 234 5678', 'tel:+27712345678'),
            _contact(context, Icons.mail_outline, 'E-mail', 'ruthbahizi04@gmail.com', 'mailto:ruthbahizi04@gmail.com'),
            _contact(context, Icons.location_on_outlined, 'Adresse', 'Goma, Q. Kyeshero n°78', null),
            const SizedBox(height: 28),
            _section('SUR LE WEB', Row(children: [_social(context, 'in', 'LinkedIn', 'https://linkedin.com'), const SizedBox(width: 12), _social(context, 'gh', 'GitHub', 'https://github.com')])),
          ],
        ),
      ),
    );
  }
  Widget _contact(BuildContext c, IconData icon, String label, String value, String? url) {
    return InkWell(
      onTap: url == null ? null : () => launchUrl(Uri.parse(url)),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
        child: Row(
          children: [
            Icon(icon, color: copper),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label.toUpperCase(), style: const TextStyle(color: muted, fontSize: 10, letterSpacing: 1.2, fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(color: ink, fontSize: 15, fontWeight: FontWeight.w700)),
              ],
            ),
            const Spacer(),
            if (url != null) const Icon(Icons.open_in_new_rounded, size: 17, color: copper),
          ],
        ),
      ),
    );
  }

  Widget _social(BuildContext c, String mark, String label, String url) {
    return Expanded(
      child: InkWell(
        onTap: () => launchUrl(Uri.parse(url)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(color: ink, borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              Text(mark, style: const TextStyle(color: copperLight, fontSize: 19, fontWeight: FontWeight.w900)),
              const SizedBox(height: 4),
              Text(label, style: const TextStyle(color: paper, fontSize: 12, fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ),
    );
  }
}
