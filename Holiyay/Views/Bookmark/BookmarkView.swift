//
//  BookmarkView.swift
//  Holiyay
//
//  Created by SIFT - Telkom DBT Air 9 on 04/06/22.
//

import SwiftUI

struct BookmarkView: View {
    @EnvironmentObject var destinationData: DestinationData
    @State var filter = FilterCategory.all
    @State var selectedDestination: Destination?
    @State var showingAlert = false
    
    
    enum FilterCategory: String, CaseIterable, Identifiable {
        case all = "All"
        case beaches = "Beaches"
        case desert = "Deserts"
        case forest = "Forests"
        case mountains = "Mountains"
        
        var id: FilterCategory { self }
    }
    
    var filteredDestinations: [Destination] {
        destinationData.destinations.filter { destination in
            (destination.isBookmark)
            && (filter == .all || filter.rawValue == destination.category.rawValue)
        }
    }
    
    func BookmarkCount()->Int{
        var tmp = 0
        
        for val in destinationData.destinations{
            if(val.isBookmark){
                tmp = tmp + 1
            }
        }
        return tmp
    }
    
    var body: some View {
        if(BookmarkCount() > 0){
            NavigationView {
                ScrollView {
                    HeaderContent_BookmarkView()
                    VStack(alignment: .center, spacing: 30) {
                        if(filteredDestinations.count == 0){
                            DescriptionNullData_BookmarkView(description: "You Have Not a Plan in this Category Destination. Create Your Plan Now!")
                        } else{
                            ForEach(filteredDestinations) { destination in
                                NavigationLink {
                                    DestinationDetail(destination: destination)
                                } label: {
                                    BookmarkCardView(destination: destination)
                                }
                                .tag(destination)
                            }
                        }
                    }
                }
                .padding(.bottom)
                .frame(maxHeight: .infinity)
                .onAppear {
                    destinationData.destinations = getDestinations()
                }
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Menu {
                            Picker("Sort by Date", selection: $filter) {
                                ForEach(FilterCategory.allCases) { category in
                                    Text(category.rawValue).tag(category)
                                }
                            }
                            .pickerStyle(.inline)
                        } label: {
                            Label("Sort", systemImage: "arrow.up.arrow.down")
                        }
                        
                        Menu {
                            Picker("Filter by Category", selection: $filter) {
                                ForEach(FilterCategory.allCases) { category in
                                    Text(category.rawValue).tag(category)
                                }
                            }
                            .pickerStyle(.inline)
                        } label: {
                            Label("Filter", systemImage: "slider.horizontal.3")
                        }
                    }
                }
            }
        } else {
            VStack{
                HeaderContent_BookmarkView()
                DescriptionNullData_BookmarkView(description: "You Have Not a Plan. Create Your Plan Now!")
            }
        }
    }
}

struct DescriptionNullData_BookmarkView: View{
    var description: String
    
    var body: some View{
        VStack{
            Button {
            } label: {
                Label(description, systemImage: "")
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
            }
            .padding(.vertical)
            .background(Color(hue: 0.666, saturation: 0.836, brightness: 0.434))
        }
        .frame(width: UIScreen.main.bounds.width*(95/100) )
        .foregroundColor(Color.white)
        .cornerRadius(10)
    }
}

struct HeaderContent_BookmarkView: View{
    
    var body: some View{
        Text("Realize your plan")
            .font(.title)
            .fontWeight(.black)
            .padding()
    }
}

struct BookmarkView_Previews: PreviewProvider {
    
    static var previews: some View {
        BookmarkView().environmentObject(DestinationData())
    }
}
