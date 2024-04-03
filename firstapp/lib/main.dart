import 'package:firstapp/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'shopProvider.dart';
// import 'dart:convert' as convert;

// import 'package:http/http.dart' as http;

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

// class MyApp extends ConsumerWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // final helloWorld = ref.watch(nameProvider);
//     // final idofp = ref.watch(listProvider);
//     // final counter = ref.watch(counterStateProvider);

//     final worldTime = ref.watch(worldTimeProvider);

//     return MaterialApp(
//         home: Scaffold(
//             body: Center(
//       child: worldTime.when(
//           data: (data) {
//             return Text('${data.datetime}');
//           },
//           error: (err, stackTrace) {
//             print('Error: $err');
//             print('Stacktrace: $stackTrace');
//             return Text('Error!');
//           },
//           loading: () => Text('loading')),
//     )));
//   }
// }

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final helloWorld = ref.watch(nameProvider);
    // final idofp = ref.watch(listProvider);
    // final counter = ref.watch(counterStateProvider);

    final worldTime = ref.watch(shopsProvider);

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text('reverpod'),
              backgroundColor: Colors.amber,
            ),
            body: Column(
              children: [
                Center(
                  child: worldTime.when(
                      data: (data) {
                        return Column(
                          children: [
                            Image.network(
                              '${data.first.image}',
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return Center(
                                  child: Text('Error loading image'),
                                );
                              },
                            ),
                            Text('title:')
                          ],
                        );
                      },
                      error: (err, stackTrace) {
                        print('Error: $err');
                        print('Stacktrace: $stackTrace');
                        return Text('Error!');
                      },
                      loading: () => Text('loading')),
                ),
                ElevatedButton(
                    onPressed: () {
                      ref.refresh(shopsProvider);
                    },
                    child: Text('refresh'))
              ],
            )));
  }
}
