import 'package:flutter/material.dart';
import 'booking_screen.dart';

class MovieInfoScreen extends StatelessWidget {
  final ValueNotifier<double> ticketCount = ValueNotifier(1);

  MovieInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Color(0xFF8B0000), 
              Color(0xFFE53935), 
            ],
            stops: [0.0, 0.45, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      height: 420, 
                      width: double.infinity,
                      child: Image.asset(
                        "assets/images/spiderman.jpg",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Peter Parker faces new challenges in this exciting\nchapter full of action and adventure.',
                    style: TextStyle(
                      color: Color(0xFFE0E0E0),
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 24),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF212121),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        _buildInfoRow(Icons.access_time_sharp, 'Duration: 2h 18m'),
                        const SizedBox(height: 16),
                        _buildInfoRow(Icons.theater_comedy, 'Genre: Action'),
                        const SizedBox(height: 16),
                        _buildInfoRow(Icons.calendar_today_outlined, 'Release Year: 2026'),
                        const SizedBox(height: 16),
                        _buildInfoRow(Icons.star, 'Rating: 4.9 / 5'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  ValueListenableBuilder<double>(
                    valueListenable: ticketCount,
                    builder: (context, value, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Number of Tickets: ${value.toInt()}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          
                          const SizedBox(height: 12),
                          
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: Colors.yellow[700],
                              inactiveTrackColor: Colors.yellow.withOpacity(0.3),
                              thumbColor: Colors.yellow[700],
                              overlayColor: Colors.yellow.withOpacity(0.2),
                              tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 2),
                              activeTickMarkColor: Colors.yellow[200],
                              inactiveTickMarkColor: Colors.yellow[200],
                              trackHeight: 4.0,
                            ),
                            child: Slider(
                              value: value,
                              min: 1,
                              max: 10,
                              divisions: 9,
                              onChanged: (newValue) {
                                ticketCount.value = newValue;
                              },
                            ),
                          ),

                          const SizedBox(height: 40),

                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFF44336),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  _createSmoothRoute(BookingScreen()),
                                );
                              },
                              child: const Text(
                                "Go to Booking",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 20),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.yellow[700],
          size: 22,
        ),
        const SizedBox(width: 14),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ],
    );
  }


  Route _createSmoothRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}