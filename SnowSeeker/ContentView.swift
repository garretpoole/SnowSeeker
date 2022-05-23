//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Garret Poole on 5/23/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        //iPad and larger iPhones simulator has primary view on left from back arrow with menu to show
        NavigationView {
            NavigationLink {
                //changes the secondary view
                Text("New Secondary")
            } label: {
                //remains the primary view
                //no current way to always keep this visible
                Text("Hello World")
            }
            //Secondary view is first thing you see on larger screens and rpimary will slide in
            Text("Secondary")
            //makes the secondary slide in like the primary
            Text("Tertiary")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
