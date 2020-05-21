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
    
    func getValue()-> Void{
        DispatchQueue.global(qos: .background).async {
                 self.exampleValue = self.prefs.integer(forKey: "VALUE")
        }
    }
    
    var body: some View {
        VStack{
            Text("Değer: \(String(self.exampleValue))")
        }.onAppear(perform: getValue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
