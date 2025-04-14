import 'package:flutter_bloc/flutter_bloc.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchLoadingState()) {
    on<LoadItemsEvent>((event, emit) async {
      emit(SearchLoadingState());

      await Future.delayed(Duration(seconds: 1)); // شبیه‌سازی لود

      final items = List.generate(10, (index) {
        if (index == 0) {
          return MediaItem(path: 'assets/videos/doc_2025-04-08_04-41-04.mp4', type: MediaType.video);
        } else if (index == 1) {
          return MediaItem(path: 'assets/videos/doc_2025-04-08_02-24-27.mp4', type: MediaType.video);
        } else {
          return MediaItem(path: 'images/item$index.png', type: MediaType.image);
        }
      });

      emit(SearchLoadedState(items: items));
    });
  }
}
