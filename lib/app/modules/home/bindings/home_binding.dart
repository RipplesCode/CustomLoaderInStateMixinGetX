import 'package:custom_shimmer_loader_state_mixin_flutter_getx/app/data/providers/api_provider.dart';
import 'package:custom_shimmer_loader_state_mixin_flutter_getx/app/modules/home/tv_show_repository.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(TvShowRepository(ApiProvider())),
    );
  }
}
