//
//  ContentView.swift
//  Swift5-BackgroundTaskNotification
//
//  Created by Ceren on 20.05.2020.
//  Copyright © 2020 ceren. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var exampleValue : Int = 0
    let prefs = UserDefaults.standard
    
    ///Bildirim Göndermek için izin alır.
    func permissionNotification(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func getValue()-> Void{
        DispatchQueue.global(qos: .background).async {
            self.exampleValue = self.prefs.integer(forKey: "VALUE")
        }
    }
    
    var body: some View {
        VStack{
            Text("Değer: \(String(self.exampleValue))")
        }.onAppear(perform: getValue)
            .onAppear(perform: permissionNotification)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
