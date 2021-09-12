import 'dart:async';

import 'package:custom_shimmer_loader_state_mixin_flutter_getx/app/data/model/tv_show_model.dart';
import 'package:custom_shimmer_loader_state_mixin_flutter_getx/app/modules/home/tv_show_repository.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class HomeController extends GetxController with StateMixin<List<TvShow>> {
  TvShowRepository tvShowRepository;
  HomeController(this.tvShowRepository);
  List<TvShow> lstTvShows = [];

  var connectionStatus = 0.obs;

  //bool isConnected=await InternetConnectionChecker().hasConnection;
  late StreamSubscription<InternetConnectionStatus> _listener;

  @override
  void onInit() {
    super.onInit();
    _listener = InternetConnectionChecker()
        .onStatusChange
        .listen((InternetConnectionStatus status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          connectionStatus.value = 1;
          break;
        case InternetConnectionStatus.disconnected:
          connectionStatus.value = 0;
          break;
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    getTvShow();
  }

  @override
  void onClose() {
    _listener.cancel();
  }

  getTvShow() async {
    print("called");
    try {
      change(null, status: RxStatus.loading());
      tvShowRepository.getTvShow("1").then((value) {
        lstTvShows.clear();
        lstTvShows.addAll(value.tvShows!);
        change(lstTvShows, status: RxStatus.success());
      }, onError: (err) {
        change(null, status: RxStatus.error(err.toString()));
      });
    } catch (exception) {
      change(null, status: RxStatus.error(exception.toString()));
    }
  }
}
