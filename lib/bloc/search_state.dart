import 'package:equatable/equatable.dart';

enum MediaType { image, video }

class MediaItem {
  final String path;
  final MediaType type;

  MediaItem({required this.path, required this.type});
}

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchLoadingState extends SearchState {}

class SearchLoadedState extends SearchState {
  final List<MediaItem> items;

  SearchLoadedState({required this.items});

  @override
  List<Object?> get props => [items];
}
