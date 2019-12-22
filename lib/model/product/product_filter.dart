class ProductFilter {
  String categorySlug;
  List<String> categorySlugList;
  List<int> productBadge;
  String productSearch;
  int productSort;
  String tagSlug;
  int priceMin;
  int priceMax;

  ProductFilter(
      {this.categorySlug,
      this.categorySlugList,
      this.productBadge,
      this.productSearch,
      this.productSort,
      this.tagSlug,
      this.priceMin,
      this.priceMax});

  ProductFilter.fromJson(Map<String, dynamic> json) {
    categorySlug = json['categorySlug'];
    categorySlugList = json['categorySlugList'] != null
        ? json['categorySlugList'].cast<String>()
        : null;
    productBadge =
        json['productBadge'] != null ? json['productBadge'].cast<int>() : null;
    productSearch = json['productSearch'];
    productSort = json['productSort'];
    tagSlug = json['tagSlug'];
    priceMin = json['priceMin'];
    priceMax = json['priceMax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categorySlug'] = this.categorySlug;
    data['categorySlugList'] = this.categorySlugList;
    data['productBadge'] = this.productBadge;
    data['productSearch'] = this.productSearch;
    data['productSort'] = this.productSort;
    data['tagSlug'] = this.tagSlug;
    data['priceMin'] = this.priceMin;
    data['priceMax'] = this.priceMax;
    return data;
  }
}