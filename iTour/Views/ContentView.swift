//
//  ContentView.swift
//  iTour
//
//  Created by Fadel Sultan on 16/02/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment (\.modelContext) var modelContext
    @State private var path = [Destination]()
    @State private var sortOrder = SortDescriptor(\Destination.name)
    @State private var searchText = ""
    @State private var showFutureDestination:Bool = false
    
    var body: some View {
        NavigationStack(path:$path) {
            
            DestinationListingView(sort: sortOrder, searchSting: searchText, showFutureDestination: showFutureDestination)
            .navigationTitle("iTour")
            .searchable(text: $searchText)
            .navigationDestination(for: Destination.self, destination: EditDestinationView.init)
            .toolbar {
                Button("Add Destination" , systemImage: "plus" , action: addDestination)
                
                Menu("Sort" , systemImage: "arrow.up.arrow.down"){
                    Picker("Sort", selection: $sortOrder) {
                        Text("Name")
                            .tag(SortDescriptor(\Destination.name))
                        
                        Text("Priority")
                                .tag(SortDescriptor(\Destination.priority , order: .reverse))
                        
                        Text("Date")
                            .tag(SortDescriptor(\Destination.date))
                    }
                    .pickerStyle(.inline)
                }
                
                Menu("Show Future" , systemImage: "eye") {
                    Picker("Show Future", selection: $showFutureDestination) {
                        Text("Yes")
                            .tag(true)
                        Text("No")
                            .tag(false)
                    }.pickerStyle(.inline)
                }

            }
        }
    }
    
    func addDestination() {
        let destination = Destination()
        modelContext.insert(destination)
        path = [destination]
    }
}

#Preview {
    ContentView()
}
