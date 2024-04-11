import 'package:auto_route/annotations.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_crud_app/features/home/view/widgets/custom_card.dart';
import 'package:riverpod_crud_app/features/search/controller/notifier/search_notifier.dart';
import 'package:riverpod_crud_app/features/search/view/widgets/search_result_card.dart';
import 'package:riverpod_crud_app/router/auto_router_provider.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage()
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        title: Row(
          children: [
            Consumer(
              builder: (context, ref, child) {
                return IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () {
                    ref.read(autorouterprovider).pop();
                  },
                );
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Consumer(
                  builder: (context, ref, child) {
                    return TextField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(18),
                        suffixIcon: Icon(Icons.mic),
                        hintText: 'Search for student',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                      ),
                      onChanged: (value) {
                        EasyDebounce.debounce(
                            'my-debouncer',
                            const Duration(milliseconds: 500),
                            () => ref
                                .read(searchNotifierPod.notifier)
                                .search(searchQuery: value));
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final searchAsyncData = ref.watch(searchNotifierPod);
          return searchAsyncData.when(
            data: (data) => data.isNotEmpty
                ? ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      var data2 = data[index];
                      return SearchResultCard(student: data2);
                    },
                  )
                : "No students found".text.make().objectCenter(),
            error: (error, stackTrace) => error.toString().text.make(),
            loading: () => const CircularProgressIndicator().objectCenter(),
          );
        },
      ),
    );
  }
}
