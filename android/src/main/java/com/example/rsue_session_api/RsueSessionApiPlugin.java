package com.example.rsue_session_api;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** RsueSessionApiPlugin */
public class RsueSessionApiPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  @Override
  public void onAttachedToEngine(  FlutterPluginBinding flutterPluginBinding) {
    api.ScheduleAPI.setup(flutterPluginBinding.getBinaryMessenger(), new ScheduleApi());
//    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "rsue_session_api");
//    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(  MethodCall call,   Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(  FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
