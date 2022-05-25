//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Garret Poole on 5/23/22.
//

import SwiftUI

extension View {
    @ViewBuilder func phoneOnlyNavigationView() -> some View {
        //check if on a phone to keep layout consistent on 13 Pro Max
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @State private var searchText = ""
    
    @StateObject var favorites = Favorites()
    
    @State private var sorts = ["default", "alphabetical", "country"]
    @State private var sort = "default"
    @State private var showingSort = false
    
    var body: some View {
        NavigationView {
            List(filteredResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    //makes spacing for favorites correct
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search Resort")
            .toolbar {
                Button {
                    showingSort = true
                } label: {
                    Image(systemName: "line.horizontal.3")
                }
            }
            .sheet(isPresented: $showingSort) {
                NavigationView {
                    Form {
                        Picker("Select Sort", selection: $sort) {
                            ForEach(sorts, id: \.self) {
                                Text($0)
                            }
                        }.pickerStyle(.wheel)
                    }
                    .navigationTitle("Sort Resorts")
                    
                }
            }
            
            //for secondary view on larger screens
            WelcomeView()
            
        }
        //created modifier to make pro max layout consistent
        //.phoneOnlyNavigationView()
        .environmentObject(favorites)
        
    }
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            switch sort {
            case "alphabetical":
                return resorts.sorted(by: alphabeticalSort)
            case "country":
                return resorts.sorted(by: countrySort)
            default:
                return resorts
            }
        } else {
            switch sort {
            case "alphabetical":
                return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText)
                }.sorted(by: alphabeticalSort)
            case "country":
                return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText)
                }.sorted(by: countrySort)
            default:
                return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText)
                }
            }
        }
    }
    
    func alphabeticalSort(lhs: Resort, rhs: Resort) -> Bool {
        return lhs.name.lowercased() < rhs.name.lowercased()
    }
    
    func countrySort(lhs: Resort, rhs: Resort) -> Bool {
        return lhs.country.lowercased() < rhs.country.lowercased()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
