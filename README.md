# Swift5-BackgroundTaskNotification

Teknik Özellikler: SwiftUI, Swift 5, XCode 11.4

## Amaç ##

Swift 5 üzerinde arka planda görev çalıştırmak ve bildirim göndermek.



## Senaryo ##

Uygulama belirtilen parametrelere göre düzenli olarak arka planda (uygulamayı öldürseniz bile) methodu çalıştırır. 

Method hafızaya alınmış olan bir değişken değerini +1 arttırır ve yeni değeri hafızaya set eder.

Bu işlem yapıldıktan sonra kullanıcıya değerin artmış olduğuna dair bir bildirim gönderilir. 



![Uygulama Çıktısı](https://github.com/cmlcrn17/Swift5-BackgroundTaskNotification/blob/master/BackgroundTask1.png =250x250)


**İzinler** 

![Uygulamaya Mod Eklenir](https://github.com/cmlcrn17/Swift5-BackgroundTaskNotification/blob/master/Permission1.png =250x250)





***Saatte 1 kez çalıştırır.***
```

UIApplication.shared.setMinimumBackgroundFetchInterval(3600)

```

