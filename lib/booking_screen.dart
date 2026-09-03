import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
  final int totalSeats = 20;


  late final ValueNotifier<List<int>> seatStatus;

  BookingScreen({super.key}) {

    seatStatus = ValueNotifier<List<int>>(
      List.generate(totalSeats, (index) {
        if (index == 8) return 2; 
        return 0;
      }),
    );
  }


  int get selectedCount =>
      seatStatus.value.where((status) => status == 1).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white38),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Select Your Seats',
          style: TextStyle(
            color: Color(0xFFE53935),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        titleSpacing: 0,
      ),
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
            stops: [0.3, 0.7, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: ValueListenableBuilder<List<int>>(
              valueListenable: seatStatus,
              builder: (context, seats, child) {
                return Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      "Selected Seats: $selectedCount",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 30),
                    
                    Expanded(
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: totalSeats,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.95,
                        ),
                        itemBuilder: (context, index) {
                          Color containerColor;
                          Color iconColor;


                          if (seats[index] == 0) {
                            containerColor = Colors.black; 
                            iconColor = Colors.white;
                          } else if (seats[index] == 1) {
                            containerColor = const Color(0xFFFFCA28); 
                            iconColor = Colors.black;
                          } else {
                            containerColor = const Color(0xFFF44336); 
                            iconColor = Colors.black;
                          }

                          return GestureDetector(
                            onTap: () {

                              if (seats[index] == 2) return;

                              final newSeats = List<int>.from(seats);
                              newSeats[index] = newSeats[index] == 0 ? 1 : 0;
                              seatStatus.value = newSeats;
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                color: containerColor,
                                borderRadius: BorderRadius.circular(10),
                                border: seats[index] == 0 
                                  ? Border.all(color: Colors.white.withOpacity(0.05), width: 1)
                                  : null,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.chair,
                                  color: iconColor,
                                  size: 28,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFCA28),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        onPressed: selectedCount > 0
                            ? () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Tickets Booked Successfully!"),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              }
                            : null,
                        child: const Text(
                          "Book Now",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}