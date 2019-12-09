import 'package:ann_shop_flutter/core/config.dart';
import 'package:ann_shop_flutter/core/utility.dart';
import 'package:ann_shop_flutter/model/product/product.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductTitle extends StatelessWidget {
  ProductTitle(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: product,
      child: Container(
        height: 150,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/product-detail', arguments: product);
          },
          child: Row(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: ExtendedImage.network(
                      domain + product.getCover,
                      fit: BoxFit.cover,
                      cache: true,
                    ),
                  ),
                  //Provider.value(value: product, child: AddFavoriteButton(),)
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Text(
                      product.name,
                      style: Theme.of(context).textTheme.body1,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 8, left: defaultPadding, right: defaultPadding),
                    child: Text(
                      'Mã: ' + product.sku,
                      style: Theme.of(context)
                          .textTheme
                          .subhead
                          .merge(TextStyle(color: Colors.grey)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 8, left: defaultPadding, right: defaultPadding),
                    child: Text(
                      'Giá sỉ: ' + Utility.formatPrice(product.regularPrice),
                      style: Theme.of(context)
                          .textTheme
                          .body2
                          .merge(TextStyle(color: Colors.red)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 8, left: defaultPadding, right: defaultPadding),
                    child: Text(
                      'Giá lẻ: ' + Utility.formatPrice(product.retailPrice),
                      style: Theme.of(context).textTheme.body2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
