import 'dart:async'; // Required for StreamSubscription
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:untitled/LoginPage.dart';
import 'package:untitled/PregnancyGuideScreen.dart';
import 'AnonymousCrimereporting.dart';
import 'SafetytipScreen.dart';
import 'SelfdefensetutorialScreen.dart';
import 'ShakeFeaturePage.dart';
import 'AnonymousCrimeReportPage.dart';
import 'ReportListPage.dart'; // New import for the reports page

// New imports for the features you added
import 'safety_tips_screen.dart';
import 'self_defense_tutorial_screen.dart';

// --- Theme Definitions ---
class AppThemes {
  static final ThemeData morningTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.amber[200],
    scaffoldBackgroundColor: Colors.yellow[50],
    colorScheme: ColorScheme.light(
      primary: Colors.amber[400]!,
      secondary: Colors.orangeAccent,
      surface: Colors.white,
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: Colors.black87,
      error: Colors.redAccent,
      onError: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.amber[300],
      foregroundColor: Colors.black87,
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(color: Colors.black54),
      titleMedium: TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    iconTheme: IconThemeData(color: Colors.orange[700]),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: Colors.orange[800]),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
          ) {
        if (states.contains(WidgetState.selected)) {
          return Colors.orange[700];
        }
        return Colors.black54;
      }),
    ),
  );

  static final ThemeData afternoonTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.deepOrange[300],
    scaffoldBackgroundColor: Colors.orange[50],
    colorScheme: ColorScheme.light(
      primary: Colors.deepOrange[500]!,
      secondary: Colors.redAccent,
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,

      onSurface: Colors.pinkAccent,
      error: Colors.red,
      onError: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.deepOrange[400],
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(color: Colors.black54),
      titleMedium: TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    iconTheme: IconThemeData(color: Colors.red[700]),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: Colors.red[800]),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
          ) {
        if (states.contains(WidgetState.selected)) {
          return Colors.red[700];
        }
        return Colors.black54;
      }),
    ),
  );

  static final ThemeData eveningTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.deepPurple[300],
    scaffoldBackgroundColor: Colors.pinkAccent,
    colorScheme: ColorScheme.dark(
      primary: Colors.deepPurple[400]!,
      secondary: Colors.purpleAccent,

      surface: Colors.grey[800]!,
      onPrimary: Colors.white,
      onSecondary: Colors.white,

      onSurface: Colors.white70,
      error: Colors.redAccent,
      onError: Colors.black,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0),
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(color: Colors.white70),
      titleMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    cardTheme: CardThemeData(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.grey[800],
    ),
    iconTheme: IconThemeData(color: Colors.purpleAccent[100]),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: Colors.purpleAccent[100]),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color?>((
          Set<WidgetState> states,
          ) {
        if (states.contains(WidgetState.selected)) {
          return Colors.purpleAccent[100];
        }
        return Colors.white70;
      }),
    ),
  );
}

// --- Feature Data ---
class FeatureItem {
  final IconData icon;
  final String name;
  final VoidCallback onTap;

  FeatureItem({required this.icon, required this.name, required this.onTap});
}

// Global features now need a context to navigate
List<FeatureItem> globalFeatures(BuildContext context) => [
  FeatureItem(
    icon: Icons.route_outlined,
    name: 'Select Best Route',
    onTap: () => print('Route tapped'),
  ),
  FeatureItem(
    icon: Icons.sos_outlined,
    name: 'SOS Button',
    onTap: () => print('SOS tapped'),
  ),
  FeatureItem(
    icon: Icons.sports_kabaddi_outlined,
    name: 'Self Defense Tutorial',
    onTap: () { // Corrected navigation logic
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SelfDefenseTutorialScreen()),
      );
    },
  ),
  FeatureItem(
    icon: Icons.shield_outlined,
    name: 'Trusted Circle',
    onTap: () => print('Trusted Circle tapped'),
  ),
  FeatureItem(
    icon: Icons.call_outlined,
    name: 'Emergency Call',
    onTap: () => print('Emergency Call tapped'),
  ),
  FeatureItem(
    icon: Icons.location_on_outlined,
    name: 'Geo Fencing',
    onTap: () => print('Geo Fencing tapped'),
  ),
  FeatureItem(
    icon: Icons.report_problem_outlined,
    name: 'Anonymous Crime Reporting',
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AnonymousCrimeReportPage(),
        ),
      );
    },
  ),
  FeatureItem(
    icon: Icons.list_alt_outlined,
    name: 'View Recent Reports',
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ReportListPage(),
        ),
      );
    },
  ),
  FeatureItem(
    icon: Icons.lightbulb_outline,
    name: 'Safety Tips',
    onTap: () { // Corrected navigation logic
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SafetyTipsScreen()),
      );
    },
  ),
];

// Mother mode features also need a context
List<FeatureItem> motherModeFeatures(BuildContext context) => [
  FeatureItem(
    icon: Icons.restaurant_menu_outlined,
    name: 'Pregnancy Diet Plan',
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PregnancyGuideScreen(),
        ),
      );
    },
  ),
  FeatureItem(
    icon: Icons.calendar_today_outlined,
    name: 'Doctor Appointment Reminders',
    onTap: () => print('Appointments tapped'),
  ),
  FeatureItem(
    icon: Icons.local_hospital_outlined,
    name: 'Maternity Emergency',
    onTap: () => print('Maternity Emergency tapped'),
  ),
  FeatureItem(
    icon: Icons.self_improvement_outlined,
    name: 'Mental Health',
    onTap: () => print('Mental Health tapped'),
  ),
  FeatureItem(
    icon: Icons.track_changes_outlined,
    name: 'Fetal Movement & Contraction Tracker',
    onTap: () => print('Tracker tapped'),
  ),
];

// --- User Mode ---
enum UserMode { normal, mother }

// --- GlobalFeaturesPage ---
class GlobalFeaturesPage extends StatefulWidget {
  final String userName;

  const GlobalFeaturesPage({super.key, this.userName = "User"});

  @override
  State<GlobalFeaturesPage> createState() => _GlobalFeaturesPageState();
}

class _GlobalFeaturesPageState extends State<GlobalFeaturesPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  UserMode _selectedMode = UserMode.normal;
  ThemeData _currentTheme = AppThemes.morningTheme;
  String _greeting = "Good Morning";

  StreamSubscription? _accelerometerSubscription;
  double _lastX = 0.0, _lastY = 0.0, _lastZ = 0.0;
  DateTime? _lastShakeTime;
  final double _shakeThreshold = 15.0;
  final int _shakeCooldownMillis = 2000;

  @override
  void initState() {
    super.initState();
    _updateThemeAndGreeting();
    _startListeningToShake();
  }

  void _startListeningToShake() {
    _accelerometerSubscription = accelerometerEventStream(
      samplingPeriod: SensorInterval.uiInterval,
    ).listen(
          (AccelerometerEvent event) {
        double x = event.x;
        double y = event.y;
        double z = event.z;

        double deltaX = (x - _lastX).abs();
        double deltaY = (y - _lastY).abs();
        double deltaZ = (z - _lastZ).abs();

        if (deltaX > _shakeThreshold ||
            deltaY > _shakeThreshold ||
            deltaZ > _shakeThreshold) {
          DateTime now = DateTime.now();
          if (_lastShakeTime == null ||
              now.difference(_lastShakeTime!).inMilliseconds >
                  _shakeCooldownMillis) {
            _lastShakeTime = now;
            print("Shake Detected on GlobalFeaturesPage!");
            _triggerSOS();
          }
        }
        _lastX = x;
        _lastY = y;
        _lastZ = z;
      },
      onError: (error) {
        print("Error listening to accelerometer: $error");
      },
      cancelOnError: true,
    );
  }

  void _triggerSOS() {
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SOSActivationPage()),
    );
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    super.dispose();
  }

  void _updateThemeAndGreeting() {
    final hour = DateTime.now().hour;
    setState(() {
      if (hour < 12) {
        _greeting = "Good Morning, ${widget.userName}!";
        _currentTheme = AppThemes.morningTheme;
      } else if (hour < 18) {
        _greeting = "Good Afternoon, ${widget.userName}!";
        _currentTheme = AppThemes.afternoonTheme;
      } else {
        _greeting = "Good Evening, ${widget.userName}!";
        _currentTheme = AppThemes.eveningTheme;
      }
    });
  }

  void _onModeChanged(UserMode? value) {
    if (value != null) {
      if (_selectedMode != value) {
        setState(() {
          _selectedMode = value;
          print("Mode changed to: $_selectedMode");
        });
      }
      Navigator.pop(context);
    }
  }

  void _logout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
    print("Logout tapped");
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _currentTheme,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            _selectedMode == UserMode.mother ? "Mother Mode" : "Global Features",
          ),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
        ),
        drawer: _buildDrawer(),
        body: _buildBody(),
      ),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFFB5293B),
      child: Builder(
        builder: (drawerContext) {
          final theme = Theme.of(drawerContext);
          return ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(color: Color(0xFFB5293B)),
                child: Text(
                  'App Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Text("Switch Mode", style: theme.textTheme.titleMedium),
              ),
              RadioListTile<UserMode>(
                title: Text(
                  'Normal Mode',
                  style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                ),
                value: UserMode.normal,
                groupValue: _selectedMode,
                onChanged: _onModeChanged,
                activeColor: theme.radioTheme.fillColor?.resolve({
                  WidgetState.selected,
                }),
              ),
              RadioListTile<UserMode>(
                title: Text(
                  'Mother Mode',
                  style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                ),
                value: UserMode.mother,
                groupValue: _selectedMode,
                onChanged: _onModeChanged,
                activeColor: theme.radioTheme.fillColor?.resolve({
                  WidgetState.selected,
                }),
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.info_outline, color: theme.iconTheme.color),
                title: Text(
                  'About',
                  style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                ),
                onTap: () {
                  Navigator.pop(drawerContext);
                },
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextButton(
                  onPressed: _logout,
                  style: theme.textButtonTheme.style,
                  child: const Text('Logout', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    final featuresToShow = _selectedMode == UserMode.mother
        ? motherModeFeatures(context)
        : globalFeatures(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_greeting, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 24),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 0.9,
            ),
            itemCount: featuresToShow.length,
            itemBuilder: (context, index) {
              final feature = featuresToShow[index];
              return _buildFeatureCard(feature);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(FeatureItem feature, {VoidCallback? onTap}) {
    final cardGradient = LinearGradient(
      colors: [Colors.pink[300]!, Colors.pink[100]!],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
    const cardTextStyle = TextStyle(
      color: Color.fromARGB(255, 14, 14, 14),
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    final cardIconColor = Colors.pink[700];

    return Card(
      elevation: Theme.of(context).cardTheme.elevation ?? 2,
      shape: Theme.of(context).cardTheme.shape ??
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap ?? feature.onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            gradient: cardGradient,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(feature.icon, size: 40.0, color: cardIconColor),
              const SizedBox(height: 12),
              Text(
                feature.name,
                textAlign: TextAlign.center,
                style: cardTextStyle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}