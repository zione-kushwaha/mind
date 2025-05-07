import 'package:flutter/material.dart';
import '../../../../core/local/component.dart';
import 'flipcardgame.dart';
import 'data.dart';

class MemoryHomePage extends StatefulWidget {
  static const String routeName = '/memory_home_page';
  @override
  _MemoryHomePageState createState() => _MemoryHomePageState();
}

class _MemoryHomePageState extends State<MemoryHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A2980), Color(0xFF26D0CE)],
          ),
        ),
        child: Column(
          children: [
            CustombackAppBar(context, () {
              Navigator.pop(context);
            }),
            SizedBox(height: 20),
            Text(
              'Memory Game',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.3),
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
            Text(
              'Choose Difficulty Level',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20),
                itemCount: _list.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: AnimatedLevelCard(
                      details: _list[index],
                      index: index,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedLevelCard extends StatefulWidget {
  final Details details;
  final int index;

  const AnimatedLevelCard({
    required this.details,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  _AnimatedLevelCardState createState() => _AnimatedLevelCardState();
}

class _AnimatedLevelCardState extends State<AnimatedLevelCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.97,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _elevationAnimation = Tween<double>(
      begin: 8.0,
      end: 2.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
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
          child: Material(
            elevation: _elevationAnimation.value,
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 500),
                    pageBuilder: (_, __, ___) => widget.details.goto,
                    transitionsBuilder: (_, animation, __, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  ),
                );
              },
              onTapDown: (_) => _controller.forward(),
              onTapUp: (_) => _controller.reverse(),
              onTapCancel: () => _controller.reverse(),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      widget.details.primarycolor,
                      widget.details.secomdarycolor,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -20,
                      top: -20,
                      child: Opacity(
                        opacity: 0.2,
                        child: Icon(
                          Icons.memory,
                          size: 100,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.details.name,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: Offset(1, 1),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              ...List.generate(
                                widget.details.noOfstar,
                                (index) => Icon(
                                  Icons.star,
                                  color: Colors.yellow[300],
                                  size: 24,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                '${widget.details.noOfstar * 4} pairs',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Details {
  final String name;
  final Color primarycolor;
  final Color secomdarycolor;
  final Widget goto;
  final int noOfstar;

  Details({
    required this.name,
    required this.primarycolor,
    required this.secomdarycolor,
    required this.noOfstar,
    required this.goto,
  });
}

final List<Details> _list = [
  Details(
    name: "Easy",
    primarycolor: Color(0xFF4CAF50),
    secomdarycolor: Color(0xFF8BC34A),
    noOfstar: 1,
    goto: FlipCardGane(Level.Easy),
  ),
  Details(
    name: "Medium",
    primarycolor: Color(0xFFFF9800),
    secomdarycolor: Color(0xFFFFC107),
    noOfstar: 2,
    goto: FlipCardGane(Level.Medium),
  ),
  Details(
    name: "Hard",
    primarycolor: Color(0xFFF44336),
    secomdarycolor: Color(0xFFFF5252),
    noOfstar: 3,
    goto: FlipCardGane(Level.Hard),
  ),
];
