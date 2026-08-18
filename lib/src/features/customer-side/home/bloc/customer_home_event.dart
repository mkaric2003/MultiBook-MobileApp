sealed class CustomerHomeEvent {
  const CustomerHomeEvent();
}

class CustomerTabChanged extends CustomerHomeEvent {
  const CustomerTabChanged(this.index);

  final int index;
}
