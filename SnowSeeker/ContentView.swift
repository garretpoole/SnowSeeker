//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Garret Poole on 5/23/22.
//

import SwiftUI

struct User: Identifiable {
    var id = "g poole"
}

struct ContentView: View {
    @State private var selectedUser: User? = nil
    @State private var isShowingUser = false
    var body: some View {
       Text("Hello")
            .onTapGesture {
                selectedUser = User()
                isShowingUser = true
            }
            //want sheet to be shown when selectedUser changes/has value inside
            //resets user to nil once you dismiss the sheet
//            .sheet(item: $selectedUser) { user in
//                Text(user.id)
//            }
            //alert is prioritized over sheet if both occur at same time
//            .alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser) { user in
//                Button(user.id) {}
//            }
        //passing in nothing to alert creates "OK" button to dimiss by default
            .alert("Welcome", isPresented: $isShowingUser) { }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
