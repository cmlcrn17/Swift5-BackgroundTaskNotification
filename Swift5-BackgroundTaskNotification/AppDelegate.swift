//
//  AppDelegate.swift
//  Swift5-BackgroundTaskNotification
//
//  Created by Ceren on 20.05.2020.
//  Copyright © 2020 ceren. All rights reserved.
//

import UIKit
import UserNotifications
import BackgroundTasks

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let prefs = UserDefaults.standard
    let center = UNUserNotificationCenter.current()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Uygulama başlatıldıktan sonra özelleştirme için geçersiz kılma noktası.
        
        // Fetch data once an hour.
        UIApplication.shared.setMinimumBackgroundFetchInterval(1)
        
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.example.business", using: nil) { task in
            // Downcast the parameter to a processing task as this identifier is used for a processing request.
            // Bu tanımlayıcı bir işleme isteği için kullanıldığından, parametreyi bir işleme görevine küçümseyin.
            self.business(task: task as! BGProcessingTask)
        }
        
        return true
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
               
        // Create url which from we will get fresh data
       let url = URL(string: "https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=b6907d289e10d714a6e88b30761fae22")
        print("Loading URL")
        
        var result: Bool = false
        let semaphore = DispatchSemaphore(value: 0)
        
        
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            print("done")
            guard let data = data, error == nil else {
                completionHandler(.failed)
                return
            }
            
            do {
                
                DispatchQueue.main.async {
                    
                    var value = self.prefs.integer(forKey: "VALUE")
                    value = value + 1
                    self.prefs.set(value, forKey: "VALUE")
                    print("Değer: \(value)")
                    
                    semaphore.signal()
                    
                    self.createNotfications(newValue: value)
                }
                
                completionHandler(.newData)
                semaphore.signal()
                
            } catch {
                completionHandler(.failed)
                semaphore.signal()
                print("Failed to parse")
            }
            
        }).resume()
        
        semaphore.wait()
    }
    
    
    func business(task: BGProcessingTask) {
        
        task.expirationHandler = {
            // After all operations are cancelled, the completion block below is called to set the task to complete.
            // Tüm işlemler iptal edildikten sonra, görevin tamamlanması için aşağıdaki tamamlama bloğu çağrılır.
          
            var value = self.prefs.integer(forKey: "VALUE")
            value = value + 1
            self.prefs.set(value, forKey: "VALUE")
            self.createNotfications(newValue: value)
            
        }
        
    }
 
    
    ///Notification oluşturur ve gönderim isteği yapar.
    func createNotfications(newValue:Int) {
        
         
        //Bildirim olarak gönderilmemiş istekleri temizler.
        center.removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Artış yapıldı."
        content.body = "Belirtilen değer arttırıldı. Yeni Değer -> \(String(newValue))"
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default
        
        //Takvim Tetikleyicisi
        /*
         var dateComponents = DateComponents()
         dateComponents.hour = 10
         dateComponents.minute = 30
         let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
         */
        
        //Saniye bazında Tetikleyici
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
        
    }
    
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

