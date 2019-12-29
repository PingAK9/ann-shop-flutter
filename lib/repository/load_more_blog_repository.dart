import 'dart:async';
import 'package:ann_shop_flutter/core/core.dart';
import 'package:ann_shop_flutter/model/utility/cover.dart';
import 'package:ann_shop_flutter/repository/cover_repository.dart';
import 'package:loading_more_list/loading_more_list.dart';

class LoadMoreBlogRepository extends LoadingMoreBase<Cover> {
  LoadMoreBlogRepository({this.initData}) {
    // TODO:
    if (this.initData == null) {
      pageIndex = 1;
    } else {
      pageIndex = 2;
      initData.forEach((item) {
        this.add(item);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  final List<Cover> initData;
  int pageIndex;

  // TODO: implement hasMore
  bool _hasMore = true;
  bool forceRefresh = false;

  bool get hasMore => _hasMore;

  @override
  Future<bool> refresh([bool notifyStateChanged = false]) async {
    // TODO: implement refresh
    print('refresh Loadmore');
    _hasMore = true;
    pageIndex = 1;
    var result = await super.refresh(true);
    forceRefresh = true;
    return result;
  }

  @override
  Future<bool> loadData([bool isLoadMoreAction = false]) async {
    bool isSuccess = false;
    try {
      if (pageIndex == 1) {
        this.clear();
      }

      List<Cover> list = await _loadData();

      list.forEach((item) {
        this.add(item);
      });

      _hasMore = list.length >= itemPerPage;
      pageIndex++;
      isSuccess = true;
    } catch (exception) {
      isSuccess = false;
      _hasMore = false;
      print('load more exception: ' + exception.toString());
    }
    return isSuccess;
  }

  Future<List<Cover>> _loadData() async {
    var list = await CoverRepository.instance
        .loadBlog(page: pageIndex, pageSize: itemPerPage);
    return list;
  }
}