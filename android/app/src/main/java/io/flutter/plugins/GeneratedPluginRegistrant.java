package io.flutter.plugins;

import androidx.annotation.Keep;
import androidx.annotation.NonNull;
import io.flutter.Log;

import io.flutter.embedding.engine.FlutterEngine;

/**
 * Generated file. Do not edit.
 * This file is generated by the Flutter tool based on the
 * plugins that support the Android platform.
 */
@Keep
public final class GeneratedPluginRegistrant {
  private static final String TAG = "GeneratedPluginRegistrant";
  public static void registerWith(@NonNull FlutterEngine flutterEngine) {
    try {
      flutterEngine.getPlugins().add(new com.amplitude.amplitude_flutter.AmplitudeFlutterPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin amplitude_flutter, com.amplitude.amplitude_flutter.AmplitudeFlutterPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.apphud.fluttersdk.ApphudPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin apphud, com.apphud.fluttersdk.ApphudPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new dev.fluttercommunity.plus.battery.BatteryPlusPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin battery_plus, dev.fluttercommunity.plus.battery.BatteryPlusPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new dev.fluttercommunity.plus.device_info.DeviceInfoPlusPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin device_info_plus, dev.fluttercommunity.plus.device_info.DeviceInfoPlusPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.analytics.FlutterFirebaseAnalyticsPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin firebase_analytics, io.flutter.plugins.firebase.analytics.FlutterFirebaseAnalyticsPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.auth.FlutterFirebaseAuthPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin firebase_auth, io.flutter.plugins.firebase.auth.FlutterFirebaseAuthPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.core.FlutterFirebaseCorePlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin firebase_core, io.flutter.plugins.firebase.core.FlutterFirebaseCorePlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.firebaseremoteconfig.FirebaseRemoteConfigPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin firebase_remote_config, io.flutter.plugins.firebase.firebaseremoteconfig.FirebaseRemoteConfigPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.flutter_plugin_android_lifecycle.FlutterAndroidLifecyclePlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin flutter_plugin_android_lifecycle, io.flutter.plugins.flutter_plugin_android_lifecycle.FlutterAndroidLifecyclePlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.imagepicker.ImagePickerPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin image_picker_android, io.flutter.plugins.imagepicker.ImagePickerPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new dev.britannio.in_app_review.InAppReviewPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin in_app_review, dev.britannio.in_app_review.InAppReviewPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new dev.isar.isar_flutter_libs.IsarFlutterLibsPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin isar_flutter_libs, dev.isar.isar_flutter_libs.IsarFlutterLibsPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.onesignal.flutter.OneSignalPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin onesignal_flutter, com.onesignal.flutter.OneSignalPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.pathprovider.PathProviderPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin path_provider_android, io.flutter.plugins.pathprovider.PathProviderPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.baseflow.permissionhandler.PermissionHandlerPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin permission_handler_android, com.baseflow.permissionhandler.PermissionHandlerPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new dev.fluttercommunity.plus.share.SharePlusPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin share_plus, dev.fluttercommunity.plus.share.SharePlusPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin shared_preferences_android, io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.urllauncher.UrlLauncherPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin url_launcher_android, io.flutter.plugins.urllauncher.UrlLauncherPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.webviewflutter.WebViewFlutterPlugin());
    } catch (Exception e) {
      Log.e(TAG, "Error registering plugin webview_flutter_android, io.flutter.plugins.webviewflutter.WebViewFlutterPlugin", e);
    }
  }
}