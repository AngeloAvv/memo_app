import 'package:auto_route/auto_route.dart';

import 'package:memo_app/pages/main/main_page.dart';
import 'package:memo_app/pages/create_memo/create_memo_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter({super.navigatorKey});

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: '/', page: MainRoute.page),
    AutoRoute(page: CreateMemoRoute.page),
  ];
}
