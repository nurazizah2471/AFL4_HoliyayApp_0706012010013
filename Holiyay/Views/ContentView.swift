//
//  ContentView.swift
//  Holiyay
//
//  Created by SIFT - Telkom DBT Air 9 on 04/06/22.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            ExploreView()
                .tabItem {
                    Image(systemName: "globe")
                    Text("Explore")
                }
            BookmarkView()
                .tabItem {
                    Image(systemName: "bookmark")
                    Text("Bookmark")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
        .accentColor(Color("Accent"))
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            .environmentObject(DestinationDataModel())
        ContentView()
            .preferredColorScheme(.light)
            .environmentObject(DestinationDataModel())
    }
}

struct PrimaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding()
            .background(Color("Primary"))
            .foregroundColor(.white)
            .font(.body.bold())
            .cornerRadius(8)
    }
}

struct SecondaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .padding()
            .background(Color("Secondary"))
            .foregroundColor(Color("Primary"))
            .font(.body.bold())
            .cornerRadius(8)
    }
}
