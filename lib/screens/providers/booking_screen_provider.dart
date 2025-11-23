import 'package:hooks_riverpod/legacy.dart';

class BookingState {
  final DateTime? selectedDate;
  final String? selectedTime;
  final int? selectedDuration;
  final double? totalPrice;
  final bool isConfirmEnabled;

  BookingState({
    this.selectedDate,
    this.selectedTime,
    this.selectedDuration,
    this.totalPrice,
    this.isConfirmEnabled = false,
  });

  BookingState copyWith({
    DateTime? selectedDate,
    String? selectedTime,
    int? selectedDuration,
    double? totalPrice,
    bool? isConfirmEnabled,
  }) {
    return BookingState(
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
      selectedDuration: selectedDuration ?? this.selectedDuration,
      totalPrice: totalPrice ?? this.totalPrice,
      isConfirmEnabled: isConfirmEnabled ?? this.isConfirmEnabled,
    );
  }
}

class BookingScreenNotifier extends StateNotifier<BookingState> {
  final double hourlyRate;

  BookingScreenNotifier(this.hourlyRate) : super(BookingState());

  void selectDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }

  void selectTime(String time) {
    state = state.copyWith(selectedTime: time);
  }

  void selectDuration(int duration) {
    state = state.copyWith(selectedDuration: duration);
  }
}

final bookingProvider =
    StateNotifierProvider.family<BookingScreenNotifier, BookingState, double>((
      ref,
      hourlyRate,
    ) {
      return BookingScreenNotifier(hourlyRate);
    });
