import 'package:multibook/src/data/models/support_ticket_model.dart';

class SupportTicketsState {
  const SupportTicketsState({
    this.isLoading = true,
    this.tickets = const [],
    this.hasError = false,
  });

  final bool isLoading;
  final List<SupportTicketModel> tickets;
  final bool hasError;

  SupportTicketsState copyWith({
    bool? isLoading,
    List<SupportTicketModel>? tickets,
    bool? hasError,
  }) => SupportTicketsState(
    isLoading: isLoading ?? this.isLoading,
    tickets: tickets ?? this.tickets,
    hasError: hasError ?? this.hasError,
  );
}
