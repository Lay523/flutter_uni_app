# flutter_uni_app


## [版本说明](https://nativesupport.dcloud.net.cn/README)
```bash
IOS: 3.4.18
Android: 3.4.18
```

## Android build.gradle 配置
```gradle
android {
    ...

    defaultConfig {
        ...
        manifestPlaceholders = [
            "apk.applicationId" : applicationId,
        ]
    
    }
    
   aaptOptions {
        additionalParameters '--auto-add-overlay'
        ignoreAssetsPattern "!.svn:!.git:.*:!CVS:!thumbs.db:!picasa.ini:!*.scc:*~"
    }
}
```


