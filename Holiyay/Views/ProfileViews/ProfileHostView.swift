//
//  ProfileHost.swift
//  Landmarks
//
//  Created by SIFT - Telkom DBT Air 9 on 05/06/22.
//

import SwiftUI

struct ProfileHostView: View {
    @Environment(\.editMode) var editMode
    @EnvironmentObject var destinationDataModel: DestinationDataModel
    @State var draftProfile = ProfileModel.default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ToolbarShow_ProfileHostView(draftProfile: $draftProfile, destinationDataModel: destinationDataModel)
            if editMode?.wrappedValue == .inactive {
                ProfileResultView(profileModel: destinationDataModel.profile)
            } else {
                ProfileEditView(profileModel: $draftProfile)
                    .onAppear {
                        draftProfile = destinationDataModel.profile
                    }
                    .onDisappear {
                        destinationDataModel.profile = draftProfile
                    }
            }
        }
        .padding()
    }
}

struct ToolbarShow_ProfileHostView: View{
    @Environment(\.editMode) var editMode
    @Binding var draftProfile: ProfileModel
    var destinationDataModel: DestinationDataModel
    
    var body: some View{
        HStack {
            if editMode?.wrappedValue == .active {
                Button("Cancel", role: .cancel) {
                    draftProfile = destinationDataModel.profile
                    editMode?.animation().wrappedValue = .inactive
                }
            }
            Spacer()
            EditButton()
        }
    }
}

struct ProfileHostView_Previews: PreviewProvider {
    
    static var previews: some View {
        ProfileHostView()
            .environmentObject(DestinationDataModel())
    }
}
