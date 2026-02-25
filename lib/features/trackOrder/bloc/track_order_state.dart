part of 'track_order_bloc.dart';

@immutable
//sealed class TrackOrderState {}
//final class TrackOrderInitial extends TrackOrderState {}
final class TrackOrderState {
  final OrderStatus status;

  const TrackOrderState(this.status);

  int get stepIndex => 2; //OrderStatus.values.indexOf(status);
}
