import 'package:flutter/material.dart';

// You can remove these if the files are not being used in your project anymore.
// import 'package:untitled/MotherModeFeaturesPage.dart';
// import 'package:untitled/logo.dart';
// import 'GlobalFeautures.dart';
// import 'LoginPage.dart';



class PregnancyGuideScreen extends StatefulWidget {
  const PregnancyGuideScreen({super.key});

  @override
  _PregnancyGuideScreenState createState() => _PregnancyGuideScreenState();
}

class _PregnancyGuideScreenState extends State<PregnancyGuideScreen> {
  String? _selectedMonth;

  final Map<String, Map<String, String>> _monthData = {
    '1': {
      'diet': 'Focus on folic acid-rich foods (leafy greens, citrus fruits, beans) to prevent neural tube defects. Include protein and complex carbs for energy.',
      'exercise': 'Gentle exercises like walking, swimming, and prenatal yoga are safe and beneficial. Avoid high-impact or strenuous activities.',
      'health': 'Schedule your first prenatal appointment. Start taking prenatal vitamins. Stay hydrated and get plenty of rest to combat fatigue.',
    },
    '2': {
      'diet': 'Continue with folic acid. Add iron-rich foods (lean meats, lentils, spinach) to support increased blood volume. Combat morning sickness with small, frequent meals and ginger.',
      'exercise': 'Listen to your body. Light cardio and strength training with light weights are good options.',
      'health': 'Manage morning sickness. Discuss any food aversions or cravings with your doctor.',
    },
    '3': {
      'diet': 'A balanced diet is key. Include calcium for bone development (dairy, fortified plant milks). Focus on whole foods and avoid processed snacks.',
      'exercise': 'As nausea may subside, you can increase the duration of your walks or swims.',
      'health': 'Discuss your pregnancy with your doctor. Address any concerns about weight gain or appetite.',
    },
    '4': {
      'diet': 'Your appetite may return. Continue with a balanced diet, adding more calories to support fetal growth. Focus on healthy fats (avocado, nuts) and fiber to prevent constipation.',
      'exercise': 'This is often a great time for exercise. Continue with moderate activity, but avoid lying flat on your back after the first trimester.',
      'health': 'Prepare for your mid-pregnancy ultrasound. Monitor your blood pressure and weight gain.',
    },
    '5': {
      'diet': 'Ensure you are getting enough iron, as blood volume continues to increase. Include healthy sources of iodine (seafood, dairy) for brain development.',
      'exercise': 'Continue with moderate activity. Listen to your body and don\'t overdo it.',
      'health': 'You may start to feel the baby move! Your doctor will check for the baby\'s growth and position.',
    },
    '6': {
      'diet': 'Continue with your balanced diet. Focus on vitamin C (citrus, bell peppers) to help with iron absorption.',
      'exercise': 'Gentle stretching and pelvic floor exercises can be helpful.',
      'health': 'Discuss your birth plan with your doctor. Address any symptoms like swelling or back pain.',
    },
    '7': {
      'diet': 'Continue to eat a nutrient-rich diet. Ensure you\'re getting enough calcium and iron.',
      'exercise': 'Gentle activities are still a good idea. Focus on walking and stretching.',
      'health': 'Discuss signs of preterm labor with your doctor. Your appointments will likely become more frequent.',
    },
    '8': {
      'diet': 'Focus on a balanced diet and stay hydrated. You may need to eat smaller, more frequent meals to accommodate a crowded stomach.',
      'exercise': 'Pelvic tilts and other exercises to prepare for labor are helpful.',
      'health': 'Prepare for your hospital bag and discuss your pain management options for labor.',
    },
    '9': {
      'diet': 'Focus on nutrient-dense foods to keep your energy up for labor.',
      'exercise': 'Continue with walking and stretching if you feel up to it.',
      'health': 'Pay close attention to your body for signs of labor. Ensure you have a plan for getting to the hospital.',
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF06292),
      appBar: AppBar(
        title: const Text('Pregnancy Diet & Care Guide'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Select a month to get personalized tips for diet, exercise, and health care.',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Choose a Month',
                border: OutlineInputBorder(),
              ),
              value: _selectedMonth,
              items: const [
                DropdownMenuItem(
                  value: '1',
                  child: Text('Month 1 (First Trimester)'),
                ),
                DropdownMenuItem(
                  value: '2',
                  child: Text('Month 2 (First Trimester)'),
                ),
                DropdownMenuItem(
                  value: '3',
                  child: Text('Month 3 (First Trimester)'),
                ),
                DropdownMenuItem(
                  value: '4',
                  child: Text('Month 4 (Second Trimester)'),
                ),
                DropdownMenuItem(
                  value: '5',
                  child: Text('Month 5 (Second Trimester)'),
                ),
                DropdownMenuItem(
                  value: '6',
                  child: Text('Month 6 (Second Trimester)'),
                ),
                DropdownMenuItem(
                  value: '7',
                  child: Text('Month 7 (Third Trimester)'),
                ),
                DropdownMenuItem(
                  value: '8',
                  child: Text('Month 8 (Third Trimester)'),
                ),
                DropdownMenuItem(
                  value: '9',
                  child: Text('Month 9 (Third Trimester)'),
                ),
              ],
              onChanged: (String? newValue) {
                setState(() {
                  _selectedMonth = newValue;
                });
              },
            ),
            const SizedBox(height: 20.0),
            if (_selectedMonth != null) _buildMonthInfo(_selectedMonth!),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthInfo(String month) {
    final data = _monthData[month];
    if (data == null) {
      return const Text(
        'No information available for this month.',
        style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildInfoCard('Diet 🥗', data['diet']!),
        const SizedBox(height: 16.0),
        _buildInfoCard('Exercise 🤸‍♀️', data['exercise']!),
        const SizedBox(height: 16.0),
        _buildInfoCard('Health Care ❤️', data['health']!),
      ],
    );
  }

  Widget _buildInfoCard(String title, String content) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFAD1457),
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              content,
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}