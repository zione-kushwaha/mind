import 'package:abc/features/home/learn/activities/view/activities.dart';
import 'package:abc/features/home/major_learn/view/animal/animal_screen.dart';
import 'package:abc/features/home/major_learn/view/color/color_screen.dart';
import 'package:abc/features/home/major_learn/view/conversation/conversation.dart';
import 'package:abc/features/home/major_learn/view/feeling/felling_screen.dart';
import 'package:abc/features/home/major_learn/view/food/food_screen.dart';
import 'package:abc/features/home/major_learn/view/people/people.dart';
import 'package:abc/features/home/major_learn/view/school/school_screen.dart';
import 'package:flutter/material.dart';

class ContentScreenLearning extends StatefulWidget {
  static const String routeName = '/content';
  const ContentScreenLearning({super.key});

  @override
  State<ContentScreenLearning> createState() => _ContentScreenLearningState();
}

class _ContentScreenLearningState extends State<ContentScreenLearning> {
  final List<Map<String, dynamic>> categories = [
    {'title': 'People', 'icon': Icons.people, 'color': Colors.blue[600]!},
    {
      'title': 'Conversations',
      'icon': Icons.chat,
      'color': Colors.purple[600]!,
    },
    {'title': 'School', 'icon': Icons.school, 'color': Colors.green[600]!},
    {'title': 'Animals', 'icon': Icons.pets, 'color': Colors.orange[600]!},
    {'title': 'Colors', 'icon': Icons.color_lens, 'color': Colors.red[600]!},
    {'title': 'Food', 'icon': Icons.fastfood, 'color': Colors.brown[600]!},
    {
      'title': 'Feeling',
      'icon': Icons.emoji_emotions,
      'color': Colors.pink[600]!,
    },
    {
      'title': 'Activities',
      'icon': Icons.directions_run,
      'color': Colors.teal[600]!,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(title: const Text('Learning'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20.0,
            mainAxisSpacing: 20.0,

            childAspectRatio: 1.0,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return AnimatedCategoryCard(
              title: categories[index]['title'],
              icon: categories[index]['icon'],
              color: categories[index]['color'],
              index: index,
            );
          },
        ),
      ),
    );
  }
}

class AnimatedCategoryCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;
  final int index;

  const AnimatedCategoryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.index,
  });

  @override
  State<AnimatedCategoryCard> createState() => _AnimatedCategoryCardState();
}

class _AnimatedCategoryCardState extends State<AnimatedCategoryCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500 + (widget.index * 100)),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(opacity: _opacityAnimation.value, child: child),
        );
      },
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        shadowColor: widget.color.withOpacity(0.3),
        child: InkWell(
          borderRadius: BorderRadius.circular(20.0),
          onTap: () {
            _controller.reset();
            _controller.forward();

            // Navigate to the corresponding screen based on the category
            switch (widget.title) {
              case 'People':
                Navigator.pushNamed(context, PeopleScreen.routeName);
                break;
              case 'Conversations':
                Navigator.pushNamed(context, ConversationScreen.routeName);
                break;
              case 'School':
                Navigator.pushNamed(context, SchoolScreen.routeName);
                break;
              case 'Animals':
                Navigator.pushNamed(context, AnimalScreen.routeName);
                break;
              case 'Colors':
                Navigator.pushNamed(context, ColorScreen.routeName);
                break;
              case 'Food':
                Navigator.pushNamed(context, FoodScreen.routeName);
                break;
              case 'Feeling':
                Navigator.pushNamed(context, FeelingScreen.routeName);
                break;

              case 'Activities':
                Navigator.pushNamed(context, ActivityScreen.routeName);
                break;
              default:
                break;
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  widget.color.withOpacity(0.9),
                  widget.color.withOpacity(0.7),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(widget.icon, size: 40, color: Colors.white),
                const SizedBox(height: 12),
                FittedBox(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
