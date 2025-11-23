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
    _updateConfirmButtonState();
    _calculateTotal();
  }

  void selectTime(String time) {
    state = state.copyWith(selectedTime: time);
    _updateConfirmButtonState();
  }

  void selectDuration(int duration) {
    state = state.copyWith(selectedDuration: duration);
    _calculateTotal();
    _updateConfirmButtonState();
  }

  void _calculateTotal() {
    if (state.selectedDuration != null) {
      state = state.copyWith(totalPrice: hourlyRate * state.selectedDuration!);
    }
  }

  void _updateConfirmButtonState() {
    state = state.copyWith(
      isConfirmEnabled:
          state.selectedDate != null &&
          state.selectedTime != null &&
          state.selectedDuration != null,
    );
  }
}

final bookingProvider =
    StateNotifierProvider.family<BookingScreenNotifier, BookingState, double>((
      ref,
      hourlyRate,
    ) {
      return BookingScreenNotifier(hourlyRate);
    });
