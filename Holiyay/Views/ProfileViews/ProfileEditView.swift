//
//  ProfileEdit.swift
//  Holiyay
//
//  Created by SIFT - Telkom DBT Air 9 on 04/06/22.
//

import SwiftUI

struct ProfileEditView: View {
    @Binding var profileModel: ProfileModel
    @State var selectedCountry = 0
    
    var body: some View {
        List {
            VStack{
                HStack() {
                    Spacer()
                    Text("Keep your identity updated")
                        .font(.title2)
                        .fontWeight(.black)
                    Spacer()
                }
                .padding(.bottom)
                DescriptionContentShow_ProfileEditView(profileModel: $profileModel, selectedCountry: $selectedCountry)
            }
        }
        .listStyle(.sidebar)
        .padding(.top)
    }
}

struct DescriptionContentShow_ProfileEditView: View{
    @Binding var profileModel: ProfileModel
    @Binding var selectedCountry: Int
    
    var body: some View{
        VStack(alignment: .leading, spacing:15) {
            VStack(alignment: .leading, spacing: 10){
                Text("First Name").fontWeight(.bold)
                TextField("First Name", text: $profileModel.firstName)
                    .textFieldStyle(.roundedBorder)
                    .textContentType(.name)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.white, lineWidth: 2)
                    )
            }
            VStack(alignment: .leading, spacing: 10){
                Text("Last Name").bold()
                TextField("Last Name", text: $profileModel.lastName)
                    .textFieldStyle(.roundedBorder)
                    .textContentType(.name)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.white, lineWidth: 2)
                    )
            }
            VStack(alignment: .leading, spacing: 10){
                Text("Country of Domicile").bold()
                Picker(
                    "Country of Domicile",
                    selection: $selectedCountry,
                    content: {
                        ForEach(
                            0..<profileModel.countryOfDomicile.count,
                            content: { index in
                                Text(profileModel.countryOfDomicile[index])
                            }
                        )
                    }
                )
                    .onChange(of: selectedCountry) { _ in
                        profileModel.selectedCountry = profileModel.countryOfDomicile[selectedCountry]
                    }
                    .pickerStyle(.menu)
            }
            VStack(alignment: .leading, spacing: 10){
                Text("Gender").bold()
                    .padding(.top, 20)
                Picker("Gender", selection: $profileModel.gender) {
                    ForEach(ProfileModel.Gender.allCases) { gender in
                        Text(gender.rawValue).tag(gender)
                    }
                }
                .pickerStyle(.segmented)
            }
            VStack(alignment: .leading, spacing: 10){
                Text("Age").bold()
                    .padding(.top, 15)
                Picker("Your age", selection: $profileModel.age) {
                    ForEach(1...100, id: \.self) { age in
                        Text("\(age)")
                    }
                }
                .pickerStyle(.menu)
            }
        }
    }
}

struct ProfileEditView_Previews: PreviewProvider {
    
    static var previews: some View {
        ProfileEditView(profileModel: .constant(.default))
    }
}
