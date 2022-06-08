import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'controller.dart';
import '../models/models.dart';

/// Callback method for when the navigation view is ready to be used.
///
/// Pass to [MapBoxNavigationView.onMapCreated] to receive a [MapBoxNavigationViewController] when the
/// map is created.
typedef void OnNavigationViewCreatedCallBack(
    MapBoxNavigationViewController controller);

///Embeddable Navigation View.
class MapBoxNavigationView extends StatelessWidget {
  static const StandardMessageCodec _decoder = StandardMessageCodec();
  final MapBoxOptions? options;
  final OnNavigationViewCreatedCallBack? onCreated;
  final ValueSetter<RouteEvent>? onRouteEvent;

  MapBoxNavigationView(
      {Key? key, this.options, this.onCreated, this.onRouteEvent})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return GestureDetector(

        onTap: (){
          print({
            "code":"poxmox",
            "click event":"on embeded map"
          });
        },
        child:Container(

          child: Center(child: Text("this is a map")),

          color: Colors.red,height: 500,width: MediaQuery.of(context).size.width,)
      );
    } else if (Platform.isIOS) {
      return UiKitView(
          viewType: 'FlutterMapboxNavigationView',
          onPlatformViewCreated: _onPlatformViewCreated,
          creationParams: options!.toMap(),
          creationParamsCodec: _decoder);
    } else
      return Container();
  }

  void _onPlatformViewCreated(int id) {
    if (onCreated == null) {
      return;
    }
    onCreated!(MapBoxNavigationViewController(id, onRouteEvent));
  }
}
