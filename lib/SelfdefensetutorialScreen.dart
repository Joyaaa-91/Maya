// lib/self_defense_tutorial_screen.dart
import 'package:flutter/material.dart';

// --- Placeholder Data Models (you'd likely fetch this from a backend) ---
class TutorialVideo {
  final String id;
  final String title;
  final String thumbnailUrl; // URL or asset path
  final String description;
  final String videoUrl; // For actual video playback

  TutorialVideo({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.description,
    required this.videoUrl,
  });
}

class Instructor {
  final String id;
  final String name;
  final String specialization;
  final String imageUrl; // URL or asset path
  final double rating;
  final String bio;

  Instructor({
    required this.id,
    required this.name,
    required this.specialization,
    required this.imageUrl,
    required this.rating,
    required this.bio,
  });
}

// --- Placeholder Screens (to be implemented later) ---
class TutorialViewerScreen extends StatelessWidget {
  final TutorialVideo video;
  const TutorialViewerScreen({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(video.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // In a real app, you'd use a video_player plugin here
            Image.network(video.thumbnailUrl, height: 200, fit: BoxFit.cover, errorBuilder: (c, o, s) => Icon(Icons.videocam_off, size: 100)), // Placeholder
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Playing: ${video.title}\nVideo URL: ${video.videoUrl}", textAlign: TextAlign.center),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(video.description),
            ),
          ],
        ),
      ),
    );
  }
}

class BookInstructorScreen extends StatelessWidget {
  final Instructor? instructor; // Optional, if navigating from a specific instructor
  const BookInstructorScreen({super.key, this.instructor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(instructor != null ? "Book ${instructor!.name}" : "Find & Book Instructor")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            instructor != null
                ? "Booking form for ${instructor!.name}.\nSpecialization: ${instructor!.specialization}"
                : "List of available instructors and booking options will appear here.",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}


class SelfDefenseTutorialScreen extends StatefulWidget {
  const SelfDefenseTutorialScreen({super.key});

  @override
  State<SelfDefenseTutorialScreen> createState() => _SelfDefenseTutorialScreenState();
}

class _SelfDefenseTutorialScreenState extends State<SelfDefenseTutorialScreen> {
  // --- Sample Data (replace with actual data fetching) ---
  final List<TutorialVideo> _tutorialVideos = [
    TutorialVideo(id: '1', title: 'Basic Escape Techniques', thumbnailUrl: 'https://youtu.be/M4_8PoRQP8w?si=sf-NnxrSTjYaR7Ws', description: 'Learn how to escape common grabs and holds.', videoUrl: 'https://youtu.be/M4_8PoRQP8w?si=sf-NnxrSTjYaR7Ws'),
    TutorialVideo(id: '2', title: 'Striking Fundamentals', thumbnailUrl: 'https://via.placeholder.com/150/FFB6C1/000000?Text=Video2', description: 'Master basic punches, kicks, and elbow strikes.', videoUrl: 'video2_url'),
    TutorialVideo(id: '3', title: 'Ground Defense Basics', thumbnailUrl: 'https://via.placeholder.com/150/FF69B4/000000?Text=Video3', description: 'What to do if you find yourself on the ground.', videoUrl: 'video3_url'),
    TutorialVideo(id: '4', title: 'Using Everyday Objects for Defense', thumbnailUrl: 'https://via.placeholder.com/150/DB7093/000000?Text=Video4', description: 'Learn to use keys, pens, or bags for protection.', videoUrl: 'video4_url'),
  ];

  final List<Instructor> _instructors = [
    Instructor(id: 'i1', name: 'Farhana Mojumder Namira', specialization: 'Taekwondo, Hapkido', imageUrl: 'https://via.placeholder.com/100/ADD8E6/000000?Text=Alex', rating: 4.8, bio: '10+ years experience, focuses on practical self-defense for women.'),
    Instructor(id: 'i2', name: 'Rubida Zakir Joya', specialization: 'Krav Maga', imageUrl: 'https://via.placeholder.com/100/90EE90/000000?Text=Maria', rating: 4.9, bio: 'Certified Krav Maga instructor, empowering students with real-world skills.'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Will inherit the pink theme

    return DefaultTabController(
      length: 2, // For "Tutorials" and "Book Instructor"
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Self Defense Hub"),
          bottom: const TabBar(
            indicatorColor: Colors.white, // Or theme.colorScheme.onPrimary
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(icon: Icon(Icons.video_library_outlined), text: "Tutorials"),
              Tab(icon: Icon(Icons.person_search_outlined), text: "Find Instructor"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // --- Tutorials Tab ---
            _buildTutorialsList(theme),
            // --- Find Instructor Tab ---
            _buildInstructorsList(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildTutorialsList(ThemeData theme) {
    if (_tutorialVideos.isEmpty) {
      return const Center(child: Text("No tutorial videos available yet."));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _tutorialVideos.length,
      itemBuilder: (context, index) {
        final video = _tutorialVideos[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16.0),
          elevation: 3.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          clipBehavior: Clip.antiAlias, // Important for the image to respect border radius
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TutorialViewerScreen(video: video)),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.network(
                  video.thumbnailUrl,
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 180,
                    color: Colors.grey[300],
                    child: Icon(Icons.broken_image, size: 50, color: Colors.grey[600]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(video.title, style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: theme.primaryColorDark)),
                      const SizedBox(height: 4),
                      Text(video.description, style: theme.textTheme.bodyMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInstructorsList(ThemeData theme) {
    if (_instructors.isEmpty) {
      return const Center(child: Text("No instructors listed yet."));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _instructors.length,
      itemBuilder: (context, index) {
        final instructor = _instructors[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16.0),
          elevation: 2.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(instructor.imageUrl),
              onBackgroundImageError: (e,s) => print('Image Error'), // Placeholder for error
              child: NetworkImage(instructor.imageUrl).url.isEmpty ? Icon(Icons.person) : null,
            ),
            title: Text(instructor.name, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(instructor.specialization, style: theme.textTheme.bodySmall),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(instructor.rating.toString(), style: theme.textTheme.bodySmall),
                  ],
                ),
              ],
            ),
            trailing: Icon(Icons.calendar_today_outlined, color: theme.primaryColor),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookInstructorScreen(instructor: instructor)),
              );
            },
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
        );
      },
    );
  }
}