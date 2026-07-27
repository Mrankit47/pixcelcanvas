import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/project_dashboard/models/project_metadata.dart';
import 'package:pixelcanvas/features/project_dashboard/presentation/widgets/project_thumbnail.dart';

/// Card widget rendering project item entry on dashboard grid.
class ProjectCard extends StatelessWidget {
  /// Creates a [ProjectCard].
  const ProjectCard({
    super.key,
    required this.metadata,
    required this.onOpen,
    required this.onRename,
    required this.onDuplicate,
    required this.onToggleFavorite,
    required this.onTogglePin,
    required this.onArchive,
  });

  final ProjectMetadata metadata;
  final VoidCallback onOpen;
  final VoidCallback onRename;
  final VoidCallback onDuplicate;
  final VoidCallback onToggleFavorite;
  final VoidCallback onTogglePin;
  final VoidCallback onArchive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onOpen,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E2E),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: metadata.isPinned ? const Color(0xFF6C5CE7) : const Color(0xFF313244),
            width: metadata.isPinned ? 1.5 : 1.0,
          ),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail Header
            Stack(
              children: [
                ProjectThumbnail(metadata: metadata),
                if (metadata.isFavorite)
                  const Positioned(
                    top: 6,
                    right: 6,
                    child: Icon(Icons.star_rounded, size: 20, color: Color(0xFFF1C40F)),
                  ),
                if (metadata.isPinned)
                  const Positioned(
                    top: 6,
                    left: 6,
                    child: Icon(Icons.push_pin_rounded, size: 16, color: Color(0xFF6C5CE7)),
                  ),
              ],
            ),

            // Details Footer
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          metadata.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert_rounded, size: 16, color: Colors.white60),
                        color: const Color(0xFF313244),
                        onSelected: (val) {
                          switch (val) {
                            case 'open':
                              onOpen();
                              break;
                            case 'rename':
                              onRename();
                              break;
                            case 'duplicate':
                              onDuplicate();
                              break;
                            case 'favorite':
                              onToggleFavorite();
                              break;
                            case 'pin':
                              onTogglePin();
                              break;
                            case 'archive':
                              onArchive();
                              break;
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(value: 'open', child: Text('Open', style: TextStyle(color: Colors.white, fontSize: 12))),
                          const PopupMenuItem(value: 'rename', child: Text('Rename', style: TextStyle(color: Colors.white, fontSize: 12))),
                          const PopupMenuItem(value: 'duplicate', child: Text('Duplicate', style: TextStyle(color: Colors.white, fontSize: 12))),
                          PopupMenuItem(
                            value: 'favorite',
                            child: Text(metadata.isFavorite ? 'Unfavorite' : 'Favorite', style: const TextStyle(color: Colors.white, fontSize: 12)),
                          ),
                          PopupMenuItem(
                            value: 'pin',
                            child: Text(metadata.isPinned ? 'Unpin' : 'Pin to Top', style: const TextStyle(color: Colors.white, fontSize: 12)),
                          ),
                          const PopupMenuItem(value: 'archive', child: Text('Move to Trash', style: TextStyle(color: Color(0xFFFF6B6B), fontSize: 12))),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        metadata.resolutionString,
                        style: const TextStyle(color: Color(0xFF89B4FA), fontSize: 11, fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      Text(
                        _formatDate(metadata.modifiedDate),
                        style: const TextStyle(color: Colors.white38, fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year}';
  }
}
