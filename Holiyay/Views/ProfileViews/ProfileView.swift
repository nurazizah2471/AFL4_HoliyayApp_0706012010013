//
//  ProfileView.swift
//  Holiyay
//
//  Created by SIFT - Telkom DBT Air 9 on 04/06/22.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var destinationDataModel: DestinationDataModel
    @State private var showingProfile = false
    
    var body: some View {
        NavigationView {
            VStack {
                ProfileResultView(profileModel: destinationDataModel.profile)
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
                ProfileHostView()
                    .environmentObject(destinationDataModel)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    
    static var previews: some View {
        ProfileView()
            .environmentObject(DestinationDataModel())
    }
}
