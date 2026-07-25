import 'package:equatable/equatable.dart';

/// Base abstract class for all domain events per Blueprint §6.1.
///
/// **Purpose**: Represents significant domain state mutations dispatched across modules.
abstract class DomainEvent extends Equatable {
  /// Creates a [DomainEvent].
  DomainEvent() : occurredOn = DateTime.now();

  /// Event occurrence timestamp.
  final DateTime occurredOn;

  @override
  List<Object?> get props => [occurredOn];
}
