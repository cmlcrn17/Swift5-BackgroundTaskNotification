# Swift5-BackgroundTaskNotification

Teknik Özellikler: SwiftUI, Swift 5, XCode 11.4

## Amaç ##

Swift 5 üzerinde arka planda görev çalıştırmak ve bildirim göndermek.



## Senaryo ##

1. Uygulama belirtilen parametrelere göre düzenli olarak arka planda (uygulamayı öldürseniz bile) methodu çalıştırır. 

2. Method hafızaya alınmış olan bir değişken değerini +1 arttırır ve yeni değeri hafızaya set eder.

3. Bu işlem yapıldıktan sonra kullanıcıya değerin artmış olduğuna dair bir bildirim gönderilir. 

<img src="https://github.com/cmlcrn17/Swift5-BackgroundTaskNotification/blob/master/BackgroundTask1.png" width="200">



## İzinler ##

<center><img src="https://github.com/cmlcrn17/Swift5-BackgroundTaskNotification/blob/master/Permission1.png"><center>






***Saatte 1 kez çalıştırır.***
```

UIApplication.shared.setMinimumBackgroundFetchInterval(3600)

```

