import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_shimmer_loader_state_mixin_flutter_getx/app/modules/home/views/empty_failure_no_internet_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TV Shows'),
        centerTitle: true,
      ),
      body: Obx(() => controller.connectionStatus.value == 1
          ? controller.obx(
              (state) => ListView.separated(
                  padding: EdgeInsets.only(top: 8),
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      color: Colors.grey,
                    );
                  },
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Container(
                        width: 100,
                        height: 100,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: state![index].imageThumbnailPath!,
                          placeholder: (context, url) => Center(
                            child: SkeletonAvatar(),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error, color: Colors.red),
                        ),
                      ),
                      title: Text(
                        state[index].name!,
                        style: TextStyle(fontSize: 16),
                      ),
                      subtitle: Text(
                        state[index].country!,
                        style: TextStyle(fontSize: 14),
                      ),
                    );
                  },
                  itemCount: state!.length),
              onLoading: SkeletonListView(),
              onError: (error) => SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: EmptyFailureNoInternetView(
                  image: 'lottie/failure_lottie.json',
                  title: 'Error',
                  description: error.toString(),
                  buttonText: "Retry",
                  onPressed: () {
                    controller.getTvShow();
                  },
                ),
              ),
              onEmpty: EmptyFailureNoInternetView(
                image: 'lottie/empty_lottie.json',
                title: 'Content unavailable',
                description: 'Content not found',
                buttonText: "Retry",
                onPressed: () {
                  controller.getTvShow();
                },
              ),
            )
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: EmptyFailureNoInternetView(
                image: 'lottie/no_internet_lottie.json',
                title: 'Network Error',
                description: 'Internet not found !!',
                buttonText: "Retry",
                onPressed: () {
                  controller.getTvShow();
                },
              ),
            )),
    );
  }
}
