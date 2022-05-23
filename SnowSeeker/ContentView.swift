//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Garret Poole on 5/23/22.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    let allNames = ["Scoob", "Shaggy", "Fred", "Velma"]
    
    var body: some View {
        NavigationView {
            List(filteredNames, id: \.self) { name in
                Text(name)
            }
            //must use with Nav View so knows where to put search bar
            //whenever searchbox changes, view refreshes
            .searchable(text: $searchText, prompt: "Look for something")
            .navigationTitle("Searching")
        }
    }
    
    var filteredNames: [String] {
        if searchText.isEmpty {
            return allNames
        } else {
            return allNames.filter {
                //search disregards capitalization
                $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
