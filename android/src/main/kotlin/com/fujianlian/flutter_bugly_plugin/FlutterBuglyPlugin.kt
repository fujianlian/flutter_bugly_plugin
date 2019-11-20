package com.fujianlian.flutter_bugly_plugin

import com.tencent.bugly.crashreport.CrashReport
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

class FlutterBuglyPlugin : MethodCallHandler {

    companion object {
        lateinit var registrars: Registrar

        @JvmStatic
        fun registerWith(registrar: Registrar) {
            registrars = registrar
            val channel = MethodChannel(registrar.messenger(), "flutter_bugly_plugin")
            channel.setMethodCallHandler(FlutterBuglyPlugin())
        }
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "setUp" -> {
                //Bugly SDK初始化方法
                val appID = call.argument<String>("app_id")
                CrashReport.initCrashReport(registrars.activity().applicationContext, appID, true)
                result.success(0)
            }
            "postException" -> {
                //获取Bugly数据上报所需要的各个参数信息
                val message = call.argument<String>("crash_message")
                val detail = call.argument<String>("crash_detail")
                //调用Bugly数据上报接口
                CrashReport.postException(4, "Flutter Exception", message, detail, null)
                result.success(0)
            }
            else -> result.notImplemented()
        }
    }
}
