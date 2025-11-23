import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:service_provider_assessment/screens/providers/booking_screen_provider.dart';

import '../models/provider_model.dart';

class BookingScreen extends ConsumerWidget {
  final ServiceProvider provider;
  final List<String> availableTimes = const [
    '9:00 AM',
    '11:00 AM',
    '2:00 PM',
    '5:00 PM',
  ];
  final List<String> unavailableTimes = const ['1:00 PM', '4:00 PM'];

  const BookingScreen({super.key, required this.provider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingState = ref.watch(bookingProvider(provider.hourlyRate));
    final bookingNotifier = ref.read(
      bookingProvider(provider.hourlyRate).notifier,
    );
    final theme = Theme.of(context);
    final allTimes = [...availableTimes, ...unavailableTimes]..sort();

    return Scaffold(
      appBar: AppBar(title: const Text('Book Appointment')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Provider Summary Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(provider.imageUrl),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            provider.name,
                            style: theme.textTheme.titleLarge,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(provider.rating.toString()),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '\$${provider.hourlyRate.toStringAsFixed(2)}/hr',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Date Selection
            Text(
              'Select a Date',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7, // Show 7 days
                itemBuilder: (context, index) {
                  final date = DateTime.now().add(Duration(days: index));
                  final isSelected =
                      bookingState.selectedDate != null &&
                      bookingState.selectedDate!.day == date.day &&
                      bookingState.selectedDate!.month == date.month &&
                      bookingState.selectedDate!.year == date.year;
                  return GestureDetector(
                    onTap: () => bookingNotifier.selectDate(date),
                    child: Container(
                      width: 60,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? theme.primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('E').format(date),
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? Colors.white : Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            date.day.toString(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Time Selection
            Text(
              'Select a Time',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 2.5,
              ),
              itemCount: allTimes.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final time = allTimes[index];
                final isAvailable = availableTimes.contains(time);
                final isSelected = bookingState.selectedTime == time;

                return ElevatedButton(
                  onPressed: isAvailable
                      ? () => bookingNotifier.selectTime(time)
                      : null,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: isSelected
                        ? Colors.white
                        : (isAvailable ? theme.primaryColor : Colors.grey),
                    backgroundColor: isSelected
                        ? theme.primaryColor
                        : (isAvailable ? Colors.white : Colors.grey.shade200),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: isAvailable
                        ? BorderSide(color: theme.primaryColor)
                        : BorderSide.none,
                    elevation: 0,
                  ),
                  child: Text(time),
                );
              },
            ),
            const SizedBox(height: 24),

            // Duration
            Text(
              'Duration',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildDurationButton(
                  context,
                  theme,
                  bookingNotifier,
                  bookingState,
                  1,
                ),
                _buildDurationButton(
                  context,
                  theme,
                  bookingNotifier,
                  bookingState,
                  2,
                ),
                _buildDurationButton(
                  context,
                  theme,
                  bookingNotifier,
                  bookingState,
                  3,
                ),
              ],
            ),
            const SizedBox(height: 100), // Space for the bottom bar
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Total Price', style: TextStyle(color: Colors.grey)),
                Text(
                  bookingState.totalPrice != null
                      ? '\$${bookingState.totalPrice!.toStringAsFixed(2)}'
                      : '\$0.00',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: bookingState.isConfirmEnabled
                  ? () async {
                      // Simulate loading
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) =>
                            const Center(child: CircularProgressIndicator()),
                      );
                      await Future.delayed(const Duration(milliseconds: 500));
                      Navigator.pop(context); // Close loading dialog

                      // Show success dialog
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          title: const Text('Booking Confirmed!'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your appointment with ${provider.name} has been successfully booked.',
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Date: ${DateFormat.yMMMd().format(bookingState.selectedDate!)}',
                              ),
                              Text('Time: ${bookingState.selectedTime}'),
                              Text(
                                'Duration: ${bookingState.selectedDuration} Hour(s)',
                              ),
                              Text(
                                'Total Price: \$${bookingState.totalPrice!.toStringAsFixed(2)}',
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: const Text('Done'),
                            ),
                          ],
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 16,
                ),
              ),
              child: const Text('Confirm', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDurationButton(
    BuildContext context,
    ThemeData theme,
    BookingScreenNotifier notifier,
    BookingState state,
    int duration,
  ) {
    final isSelected = state.selectedDuration == duration;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ElevatedButton(
          onPressed: () => notifier.selectDuration(duration),
          style: ElevatedButton.styleFrom(
            foregroundColor: isSelected ? Colors.white : theme.primaryColor,
            backgroundColor: isSelected
                ? theme.primaryColor
                : theme.primaryColor.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text('$duration Hour${duration > 1 ? 's' : ''}'),
        ),
      ),
    );
  }
}
