
import 'package:custom_shimmer_loader_state_mixin_flutter_getx/app/data/model/tv_show_model.dart';
import 'package:custom_shimmer_loader_state_mixin_flutter_getx/app/data/providers/api_provider.dart';
import 'package:flutter/material.dart';

class TvShowRepository {
  final ApiProvider apiProvider;
  TvShowRepository(this.apiProvider);

  // get tv show

  Future<TvShowModel> getTvShow(String page) =>
      apiProvider.getTVShow(page);


  
}
