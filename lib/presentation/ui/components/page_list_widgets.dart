import 'package:akropolis/presentation/ui/components/loader.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PageWrapper {
  int page;
  bool initialFetch;

  PageWrapper({this.page = 0, this.initialFetch = true});

  static const pageSize = 10;
}

PagedChildBuilderDelegate<T> pagedChildBuilderDelegate<T>({
  required BuildContext context,
  required Widget Function(BuildContext, dynamic, int) itemBuilder,
  required Future<void> Function() fetchPageItems,
  Widget Function(BuildContext)? firstPageErrorIndicatorBuilder,
  Widget Function(BuildContext)? newPageErrorIndicatorBuilder,
  Widget Function(BuildContext)? firstPageProgressIndicatorBuilder,
  Widget Function(BuildContext)? newPageProgressIndicatorBuilder,
  Widget Function(BuildContext)? noMoreItemsIndicatorBuilder,
  Widget Function(BuildContext)? noItemsFoundIndicatorBuilder,
}) {
  return PagedChildBuilderDelegate(
    itemBuilder: itemBuilder,
    firstPageErrorIndicatorBuilder: (_) => firstPageErrorIndicatorBuilder?.call(context) ?? RetryErrorWidget(onRetry: fetchPageItems),
    newPageErrorIndicatorBuilder: (_) => newPageErrorIndicatorBuilder?.call(context) ?? RetryErrorWidget(onRetry: fetchPageItems),
    firstPageProgressIndicatorBuilder: (_) => firstPageProgressIndicatorBuilder?.call(context) ?? const InfiniteLoader(),
    newPageProgressIndicatorBuilder: (_) => newPageProgressIndicatorBuilder?.call(context) ?? const InfiniteLoader(),
    noMoreItemsIndicatorBuilder: (_) => noMoreItemsIndicatorBuilder?.call(context) ?? const NoMoreItemsWidget(),
    noItemsFoundIndicatorBuilder: (_) => noMoreItemsIndicatorBuilder?.call(context) ?? const NeverBeenItemsWidget(),
  );
}

class RetryErrorWidget extends StatelessWidget {
  const RetryErrorWidget({
    required this.onRetry,
    super.key,
  });

  final Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: IconButton(
        onPressed: onRetry,
        icon: const Icon(
          Icons.refresh,
          size: 40,
        ),
      ),
    );
  }
}

class NoMoreItemsWidget extends StatelessWidget {
  const NoMoreItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.center,
      child: Text("No more items"),
    );
  }
}

class NeverBeenItemsWidget extends StatelessWidget {
  const NeverBeenItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.center,
      child: Text("No items found"),
    );
  }
}
