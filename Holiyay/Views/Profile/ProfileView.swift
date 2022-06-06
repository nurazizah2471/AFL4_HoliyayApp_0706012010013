//
//  ProfileView.swift
//  Holiyay
//
//  Created by SIFT - Telkom DBT Air 9 on 04/06/22.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var destinationData: DestinationData
    @State private var showingProfile = false
    
    var body: some View {
        NavigationView {
            VStack {
                ProfileResult(profile: destinationData.profile)
            }
            .padding(.top, -40)
            .toolbar {
                Button {
                    showingProfile.toggle()
                } label: {
                    Label("Edit Profile", systemImage: "pencil")
                }
            }
            .sheet(isPresented: $showingProfile) {
                ProfileHost()
                    .environmentObject(destinationData)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    
    static var previews: some View {
        ProfileView()
            .environmentObject(DestinationData())
    }
}
