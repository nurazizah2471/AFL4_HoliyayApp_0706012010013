//
//  ExploreView.swift
//  Holiyay
//
//  Created by SIFT - Telkom DBT Air 9 on 04/06/22.
//

import SwiftUI

struct ExploreView: View {
    @EnvironmentObject var destinationData: DestinationData
    @State private var topExpanded: Bool = true
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Carousel()
                    Content_ExploreView(topExpanded: $topExpanded)
                }
                .navigationBarHidden(true)
                .ignoresSafeArea()
                .onAppear {
                    destinationData.destinations = getDestinations()
                }
            }
        }
    }
}

struct Carousel: View {
    
    var body: some View {
        TabView {
            Image("beach_carousel")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width*(30/100), height: UIScreen.main.bounds.height*(40/100))
                .overlay(OverlayHelper(description: "Beach"), alignment: .bottom)
                .padding(.bottom, 20)
                .foregroundColor(.cyan)
            Image("desert_carousel")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width*(30/100), height: UIScreen.main.bounds.height*(40/100))
                .overlay(OverlayHelper(description: "Beach"), alignment: .bottom)
                .padding(.bottom, 20)
                .foregroundColor(.cyan)
            Image("forest_carousel")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width*(30/100), height: UIScreen.main.bounds.height*(40/100))
                .overlay(OverlayHelper(description: "Beach"), alignment: .bottom)
                .padding(.bottom, 20)
                .foregroundColor(.cyan)
            Image("mountain_carousel")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width*(30/100), height: UIScreen.main.bounds.height*(40/100))
                .overlay(OverlayHelper(description: "Beach"), alignment: .bottom)
                .padding(.bottom, 20)
                .foregroundColor(.cyan)
        }
        .background(.black)
        .font(.title2.bold())
        .tabViewStyle(PageTabViewStyle())
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*(50/100))
    }
}

struct Content_ExploreView: View{
    @Binding var topExpanded: Bool
    @EnvironmentObject var destinationData: DestinationData
    
    var body: some View{
        VStack(alignment: .leading) {
            Text("Start your memorable holiday")
                .font(.system(size: 23))
                .fontWeight(.black)
                .padding(.vertical)
            ScrollView {
                DisclosureGroupHelper(topExpanded: $topExpanded, CategoryName: "Beaches",  destinationData: destinationData)
                DisclosureGroupHelper(topExpanded: $topExpanded, CategoryName: "Deserts",  destinationData: destinationData)
                DisclosureGroupHelper(topExpanded: $topExpanded, CategoryName: "Forests",  destinationData: destinationData)
                DisclosureGroupHelper(topExpanded: $topExpanded, CategoryName: "Mountains",  destinationData: destinationData)
            }
        }
        .padding(.horizontal)
        .padding(.bottom)
        .background(Color(hue: 1.0, saturation: 0.027, brightness: 0.113))
    }
}

struct DisclosureGroupHelper: View{
    @Binding var topExpanded:Bool
    var CategoryName: String
    var destinationData: DestinationData
    
    var body: some View{
        DisclosureGroup(CategoryName, isExpanded: $topExpanded) {
            Text("")
                .padding(.top, -5)
            ForEach(destinationData.destinations) { destination in
                if (!destination.isBookmark)
                    && destination.category.rawValue == "Beaches" {
                    NavigationLink {
                        DestinationDetail(destination: destination)
                    } label: {
                        ExploreCardView(destination: destination)
                    }
                    .tag(destination)
                }
            }
        }
    }
}

struct OverlayHelper: View {
    var description: String
    
    var body: some View {
        Text(description)
    }
}


struct ExploreView_Previews: PreviewProvider {
    
    static var previews: some View {
        ExploreView().environmentObject(DestinationData())
    }
}
