import 'package:provider/provider.dart';
import 'package:nested/nested.dart';

// providers
import './carousel_provider.dart';
import './dtk_index_goods_provider.dart';
import './goods_detail_provider.dart';
import './nine_goods_provider.dart';
import './category_provider.dart';
import './goods_list_provider.dart';
import './ddq_provider.dart';
import 'user_provider.dart';
// Providers---end

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<CarouselProviderModal>(
      create: (_) => CarouselProviderModal()),
  ChangeNotifierProvider<DtkIndexGoodsModal>(
      create: (_) => DtkIndexGoodsModal()),
  ChangeNotifierProvider<GoodsDetailProvider>(
      create: (_) => GoodsDetailProvider()),
  ChangeNotifierProvider<NineGoodsProvider>(create: (_) => NineGoodsProvider()),
  ChangeNotifierProvider<CategoryProvider>(create: (_) => CategoryProvider()),
  ChangeNotifierProvider<GoodsListProvider>(create: (_) => GoodsListProvider()),
  ChangeNotifierProvider<DdqProvider>(create: (_)=>DdqProvider()),
  ChangeNotifierProvider<UserProvider>(create: (_)=>UserProvider()),
];
