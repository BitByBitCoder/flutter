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




// The NotificationListener is a widget provided by the Flutter framework that allows you to listen to notifications that are dispatched during the layout phase of the rendering pipeline. It is particularly useful for implementing scroll-related behaviors, such as infinite scrolling, in your UI.

// When a scrollable widget, like a ListView or GridView, is scrolled, it dispatches ScrollNotification events. These notifications provide information about the current scroll state, including metrics like the remaining scroll extent and the scroll position.

// By wrapping your scrollable widget with a NotificationListener<ScrollNotification>, you can listen for these scroll notifications and perform actions based on specific conditions.



// NotificationListener<ScrollNotification>(
//   onNotification: (ScrollNotification notification) {
//     if (notification is ScrollEndNotification &&
//         notification.metrics.extentAfter == 0) {
//       ref.read(postViewControllerProvider.notifier).loadMore();
//     }
//     return false;
//   },
//   child: ListView.builder(
//     // ...
//   ),
// )
// The onNotification callback is called whenever a ScrollNotification is dispatched by the ListView.builder. Inside the callback, the code checks if the notification is a ScrollEndNotification (which is dispatched when the user scrolls to the end of the scrollable area) and if the extentAfter metric is zero (which means there is no more content to scroll after the current position).

// If both conditions are met, it means the user has scrolled to the bottom of the list, and the loadMore method is called on the PostViewController to fetch the next batch of posts.

// The return false; at the end of the onNotification callback tells the notification system that the notification has not been consumed and should continue propagating to other listeners if there are any.

// The NotificationListener is a powerful tool for implementing scroll-related behaviors, such as infinite scrolling, pull-to-refresh, and scroll-based animations or transitions. It allows you to react to scroll events and perform custom actions based on the scroll state.