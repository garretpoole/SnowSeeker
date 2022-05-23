//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Garret Poole on 5/23/22.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        //layout is decided on how its used; just groups the Text together but how its called decides layout
        Group {
            Text("Name: Garret")
            Text("Country: US")
            Text("Pets: Java")
        }
        .font(.title)
    }
}

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    //@State private var layoutVertically = false
    
    var body: some View {
        Group {
            //if limited in horizontal space
            //does layout for us by device, by orientation
            if sizeClass == .compact {
                VStack(content: UserView.init)
            } else {
                HStack(content: UserView.init)
            }
        }
        //group lets us attatch the modifiers
//        .onTapGesture {
//            layoutVertically.toggle()
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
