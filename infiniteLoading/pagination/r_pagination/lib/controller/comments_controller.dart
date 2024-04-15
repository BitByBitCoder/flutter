import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:r_pagination/models/comments.dart';
import 'package:r_pagination/repository/comments_repository.dart';

final commentControllerProvider =
    StateNotifierProvider<CommentsController, AsyncValue<List<Comment>>>((ref) {
  final repocomm = ref.watch(commentRepositoryProvider);
  return CommentsController(repocomm, ref);
});

class CommentsController extends StateNotifier<AsyncValue<List<Comment>>> {
  CommentRepository repocomm;
  Ref ref;
  CommentsController(this.repocomm, this.ref) : super(AsyncValue.loading()) {
    fetchCommentController();
  }
  bool _isLoading = false;
  int _page = 1;

  void fetchCommentController() async {
    if (_isLoading) return;
    _isLoading = true;
    try {
      List<Comment> newComments = await repocomm.fetchComments(1);

      // state.whenData((comments) {
      //   state = AsyncValue.data([...comments, ...newComments]);
      // });
      _page++;

      print('${newComments.first.email}');

      state = AsyncValue.data(newComments);
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    } finally {
      _isLoading = false;
    }
  }

  Future<void> loadMore() async {
    if (_isLoading) return;
    _isLoading = true;

    try {
      List<Comment> newComments = await repocomm.fetchComments(_page);
      state = AsyncValue.data([...state.value!, ...newComments]);

      _page++;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    } finally {
      _isLoading = false;
    }
  }
}
