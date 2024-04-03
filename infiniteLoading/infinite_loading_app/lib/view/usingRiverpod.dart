import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_loading_app/controller/postController.dart';
import 'package:infinite_loading_app/models/postModel.dart';

class PostsView extends ConsumerWidget {
  const PostsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsState = ref.watch(postViewControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: postsState.when(
        data: (posts) => _buildPostList(context, ref, posts),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildPostList(BuildContext context, WidgetRef ref, List<Post> posts) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollEndNotification &&
            notification.metrics.extentAfter == 0) {
          ref.read(postViewControllerProvider.notifier).loadMore();
        }
        return false;
      },
      child: ListView.builder(
        itemCount: posts.length + 1,
        itemBuilder: (context, index) {
          if (index == posts.length) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListTile(
            title: Text(posts[index].title),
            subtitle: Text(posts[index].body),
          );
        },
      ),
    );
  }
}
