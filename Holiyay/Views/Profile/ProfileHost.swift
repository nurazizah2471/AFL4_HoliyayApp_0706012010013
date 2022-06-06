//
//  ProfileHost.swift
//  Landmarks
//
//  Created by SIFT - Telkom DBT Air 9 on 05/06/22.
//

import SwiftUI

struct ProfileHost: View {
    @Environment(\.editMode) var editMode
    @EnvironmentObject var destinationData: DestinationData
    @State var draftProfile = Profile.default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Toolbar_ProfileHost(draftProfile: $draftProfile, destinationData: destinationData)
            if editMode?.wrappedValue == .inactive {
                ProfileResult(profile: destinationData.profile)
            } else {
                ProfileEdit(profile: $draftProfile)
                    .onAppear {
                        draftProfile = destinationData.profile
                    }
                    .onDisappear {
                        destinationData.profile = draftProfile
                    }
            }
        }
        .padding()
    }
}

struct Toolbar_ProfileHost: View{
    @Environment(\.editMode) var editMode
    @Binding var draftProfile: Profile
    var destinationData: DestinationData
    
    var body: some View{
        HStack {
            if editMode?.wrappedValue == .active {
                Button("Cancel", role: .cancel) {
                    draftProfile = destinationData.profile
                    editMode?.animation().wrappedValue = .inactive
                }
            }
            Spacer()
            EditButton()
        }
    }
}

struct ProfileHost_Previews: PreviewProvider {
    
    static var previews: some View {
        ProfileHost()
            .environmentObject(DestinationData())
    }
}
