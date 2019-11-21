# flutter_bugly_plugin

Bugly Flutter plugin.

## Getting Started

```dart
dependencies:
  flutter:
    sdk: flutter
  /// swift版本
  flutter_bugly_plugin:
    git:
      url: https://github.com/fujianlian/flutter_bugly_plugin.git
      ref: master
  /// oc版本
  flutter_bugly_plugin:
      git:
        url: https://github.com/fujianlian/flutter_bugly_plugin.git
        ref: dev
```

## Android 

由于 Android P 默认限制 http 明文传输数据，因此我们需要为 Bugly 声明一项网络安全配置 network_security_config.xml，允许其使用 http 传输数据，并在 AndroidManifest.xml 中新增同名网络安全配置

```xml
//res/xml/network_security_config.xml
<?xml version="1.0" encoding="utf-8"?>
<!-- 网络安全配置 --> 
<network-security-config>
    <!-- 允许明文传输数据 -->  
    <domain-config cleartextTrafficPermitted="true">
        <!-- 将Bugly的域名加入白名单 --> 
        <domain includeSubdomains="true">android.bugly.qq.com</domain>
    </domain-config>
</network-security-config>

//AndroidManifest/xml
<application
  ...
  android:networkSecurityConfig="@xml/network_security_config"
  ...>
</application>
```

Bugly SDK 需要支持 NDK，因此我们需要在 App 的 build.gradle 文件中为其增加 NDK 的架构支持


```groovy
defaultConfig {
    ndk {
        // 设置支持的SO库架构
        abiFilters 'armeabi-v7a', 'arm64-v8a'
    }
}
```

## USE


```groovy
/// 替换成自己申请的Bugly ID
if(Platform.isAndroid){
    FlutterBuglyPlugin.setUp('a4ef71648a');
} else if(Platform.isIOS){
    FlutterBuglyPlugin.setUp('57b8f45872');
}
```
