import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:testapp/model.dart/comment_model.dart';
import 'package:testapp/repository/comment_repository.dart';

final controllerCommentProvider =
    StateNotifierProvider<CommentController, AsyncValue<List<Comment>>>((ref) {
  final repo = ref.read(repositoryCommentProvider);
  return CommentController(repo: repo, ref: ref);
});

class CommentController extends StateNotifier<AsyncValue<List<Comment>>> {
  Ref ref;
  CommentRepository repo;
  CommentController({required this.repo, required this.ref})
      : super(AsyncValue.loading()) {
    fetchcontrollcomment();
  }
  int _page = 1;
  bool _loading = false;

  Future<void> fetchcontrollcomment() async {
    try {
      List<Comment> result = await repo.fetchRepositoryComments(1);

      state = AsyncValue.data(result);
    } catch (e) {
      print(e);
    }
  }

  Future update() async {
    if (_loading) return;
    _loading = true;
    try {
      List<Comment> result = await repo.fetchRepositoryComments(_page);

      state = AsyncValue.data([...state.value!, ...result]);
      _page++;
    } catch (e) {
      print(e);
    } finally {
      _loading = false;
    }
  }
}
