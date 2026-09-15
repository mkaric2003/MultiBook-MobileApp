class CreateSupportTicketState {
  const CreateSupportTicketState({
    this.isSubmitting = false,
    this.isSuccess = false,
    this.hasError = false,
  });

  final bool isSubmitting;
  final bool isSuccess;
  final bool hasError;
}
