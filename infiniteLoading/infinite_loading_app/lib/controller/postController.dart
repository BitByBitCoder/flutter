import 'package:infinite_loading_app/models/postModel.dart';
import 'package:infinite_loading_app/repsoitory/postRepository.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter/material.dart';

final postViewControllerProvider = StateNotifierProvider.autoDispose<
    PostViewController, AsyncValue<List<Post>>>((ref) {
  return PostViewController(ref);
});

class PostViewController extends StateNotifier<AsyncValue<List<Post>>> {
  final Ref _read;
  late final PostRepository _postRepository;

  PostViewController(this._read) : super(const AsyncValue.loading()) {
    _postRepository = _read.read(postRepositoryProvider);
    _fetchPosts();
  }

  int _page = 0;
  bool _isLoading = false;
  final int _limit = 20;

  void _fetchPosts() async {
    state = const AsyncValue.loading();
    try {
      final posts = await _postRepository.fetchPosts(_page, _limit);
      state = AsyncValue.data(posts);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  void loadMore() async {
    if (_isLoading) return;
    _isLoading = true;
    _page++;
    try {
      final morePosts = await _postRepository.fetchPosts(_page, _limit);
      state = AsyncValue.data([...state.value!, ...morePosts]);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
    _isLoading = false;
  }
}
