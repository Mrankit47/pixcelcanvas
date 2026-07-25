import 'package:equatable/equatable.dart';

/// Paginated dataset wrapper per Blueprint §6.1.
///
/// **Purpose**: Encapsulates paged list query results with metadata.
class PaginatedResult<T> extends Equatable {
  /// Creates a [PaginatedResult].
  const PaginatedResult({
    required this.items,
    required this.totalCount,
    required this.page,
    required this.pageSize,
    required this.hasMore,
  });

  /// Page items list.
  final List<T> items;

  /// Total count available across all pages.
  final int totalCount;

  /// Current page index (1-based).
  final int page;

  /// Items count per page.
  final int pageSize;

  /// True if additional pages exist.
  final bool hasMore;

  @override
  List<Object?> get props => [items, totalCount, page, pageSize, hasMore];
}
