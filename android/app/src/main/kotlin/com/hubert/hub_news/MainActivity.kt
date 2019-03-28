package com.hubert.hub_news

import android.os.Bundle
import android.widget.Toast

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {

  companion object {
      val CHANNEL = "com.hubert.hub_news/flutterToast"
  }

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    GeneratedPluginRegistrant.registerWith(this)

    setMethodChannelCallback()
  }

  private fun setMethodChannelCallback() {
    MethodChannel(flutterView, CHANNEL).setMethodCallHandler { methodCall, result ->
      when (methodCall.method) {
        "showToast" -> {
          Toast.makeText(baseContext, "callback: ${methodCall.arguments}",
                  Toast.LENGTH_SHORT).show()
          result.success("callback from android: ${methodCall.arguments}")
        }
      }
    }
  }
}
