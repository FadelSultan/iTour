//
//  DestinationListingView.swift
//  iTour
//
//  Created by Fadel Sultan on 16/02/2024.
//

import SwiftUI
import SwiftData

struct DestinationListingView: View {
    
    @Query var destinations:[Destination]
    @Environment (\.modelContext) var modelContext

    
    init(sort: SortDescriptor<Destination> , searchSting:String) {
        
        _destinations = Query(filter: #Predicate {
            searchSting.isEmpty ? true : $0.name.localizedStandardContains(searchSting)
        },sort: [sort])
    }
    
    var body: some View {
        List {
            ForEach(destinations) { destination in
                NavigationLink(value: destination) {
                    VStack(alignment: .leading) {
                        Text(destination.name)
                            .font(.headline)
                        
                        Text(destination.date.formatted(date: .long, time: .shortened))
                    }
                }
            }.onDelete(perform:deleteDestinations)
        }
    }
    
    func deleteDestinations(_ indexSet: IndexSet) {
        for index in indexSet {
            let destination = destinations[index]
            modelContext.delete(destination)
        }
    }

}

#Preview {
    DestinationListingView(sort: SortDescriptor(\Destination.name), searchSting: "")
}
