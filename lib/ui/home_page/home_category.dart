import 'package:ann_shop_flutter/repository/category_repository.dart';
import 'package:ann_shop_flutter/ui/home_page/category_button.dart';
import 'package:ann_shop_flutter/ui/utility/title_view_more.dart';
import 'package:flutter/material.dart';

class HomeCategory extends StatelessWidget {
  HomeCategory();

  final data = CategoryRepository.instance.categories;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          TitleViewMore(
            title: 'Danh mục sản phẩm',
            onPressed: () {},
          ),
          Container(
            height: 200,
            padding: EdgeInsets.only(left: 0, right: 0),
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (context, index) {
                return CategoryButton(data[index]);
              },
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
