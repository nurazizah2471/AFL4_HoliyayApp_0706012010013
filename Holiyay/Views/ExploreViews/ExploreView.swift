//
//  ExploreView.swift
//  Holiyay
//
//  Created by SIFT - Telkom DBT Air 9 on 04/06/22.
//

import SwiftUI

struct ExploreView: View {
    @EnvironmentObject var destinationDataModel: DestinationDataModel
    @State private var topExpanded: Bool = true
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    CarouselShow_ExploreView()
                    ContentShow_ExploreView(topExpanded: $topExpanded)
                }
                .navigationBarHidden(true)
                .ignoresSafeArea()
                .onAppear {
                    destinationDataModel.destinations = getDestinations()
                }
            }
        }
    }
}

struct CarouselShow_ExploreView: View {
    
    var body: some View {
        TabView {
            Image("beach_carousel")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width*(30/100), height: UIScreen.main.bounds.height*(40/100))
                .overlay(OverlayHelper_ExploreView(description: "Beach"), alignment: .bottom)
                .padding(.bottom, 20)
                .foregroundColor(.cyan)
            Image("desert_carousel")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width*(30/100), height: UIScreen.main.bounds.height*(40/100))
                .overlay(OverlayHelper_ExploreView(description: "Beach"), alignment: .bottom)
                .padding(.bottom, 20)
                .foregroundColor(.cyan)
            Image("forest_carousel")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width*(30/100), height: UIScreen.main.bounds.height*(40/100))
                .overlay(OverlayHelper_ExploreView(description: "Beach"), alignment: .bottom)
                .padding(.bottom, 20)
                .foregroundColor(.cyan)
            Image("mountain_carousel")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width*(30/100), height: UIScreen.main.bounds.height*(40/100))
                .overlay(OverlayHelper_ExploreView(description: "Beach"), alignment: .bottom)
                .padding(.bottom, 20)
                .foregroundColor(.cyan)
        }
        .background(.black)
        .font(.title2.bold())
        .tabViewStyle(PageTabViewStyle())
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*(50/100))
    }
}

struct ContentShow_ExploreView: View{
    @Binding var topExpanded: Bool
    @EnvironmentObject var destinationDataModel: DestinationDataModel
    
    var body: some View{
        VStack(alignment: .leading) {
            Text("Start your memorable holiday")
                .font(.system(size: 23))
                .fontWeight(.black)
                .padding(.vertical)
            ScrollView {
                DisclosureGroupHelper_ExploreView(topExpanded: $topExpanded, categoryName: "Beaches",  destinationDataModel: destinationDataModel)
                DisclosureGroupHelper_ExploreView(topExpanded: $topExpanded, categoryName: "Deserts",  destinationDataModel: destinationDataModel)
                DisclosureGroupHelper_ExploreView(topExpanded: $topExpanded, categoryName: "Forests",  destinationDataModel: destinationDataModel)
                DisclosureGroupHelper_ExploreView(topExpanded: $topExpanded, categoryName: "Mountains",  destinationDataModel: destinationDataModel)
            }
        }
        .padding(.horizontal)
        .padding(.bottom)
        .background(Color(hue: 1.0, saturation: 0.027, brightness: 0.113))
    }
}

struct DisclosureGroupHelper_ExploreView: View{
    @Binding var topExpanded:Bool
    var categoryName: String
    var destinationDataModel: DestinationDataModel
    
    var body: some View{
        DisclosureGroup(categoryName, isExpanded: $topExpanded) {
            Text("")
                .padding(.top, -5)
            ForEach(destinationDataModel.destinations) { destination in
                if !destination.isBookmark
                    && destination.category.rawValue == categoryName {
                    NavigationLink {
                        DestinationDetailView(destinationModel: destination)
                    } label: {
                        
                    }
                    .tag(destination)
                }
            }
        }
    }
}

struct OverlayHelper_ExploreView: View {
    var description: String
    
    var body: some View {
        Text(description)
    }
}


struct ExploreView_Previews: PreviewProvider {
    
    static var previews: some View {
        ExploreView().environmentObject(DestinationDataModel())
    }
}
