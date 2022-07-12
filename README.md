# flutter_uni_app


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


