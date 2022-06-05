//
//  ProfileEdit.swift
//  Holiyay
//
//  Created by SIFT - Telkom DBT Air 9 on 04/06/22.
//

import SwiftUI

struct ProfileEdit: View {
    @Binding var profile: Profile
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
                DescriptionContent_ProfileEdit(profile: $profile, selectedCountry: $selectedCountry)
            }
        }
        .listStyle(.sidebar)
        .padding(.top)
    }
}

struct DescriptionContent_ProfileEdit: View{
    @Binding var profile: Profile
    @Binding var selectedCountry: Int
    
    var body: some View{
        VStack(alignment: .leading, spacing:15) {
            VStack(alignment: .leading, spacing: 10){
                Text("First Name").fontWeight(.bold)
                TextField("First Name", text: $profile.firstName)
                    .textFieldStyle(.roundedBorder)
                    .textContentType(.name)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(.white, lineWidth: 2)
                    )
            }
            VStack(alignment: .leading, spacing: 10){
                Text("Last Name").bold()
                TextField("Last Name", text: $profile.lastName)
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
                            0..<profile.countryOfDomicile.count,
                            content: { index in
                                Text(profile.countryOfDomicile[index])
                            }
                        )
                    }
                )
                    .onChange(of: selectedCountry) { _ in
                        profile.selectedCountry = profile.countryOfDomicile[selectedCountry]
                    }
                    .pickerStyle(.menu)
            }
            VStack(alignment: .leading, spacing: 10){
                Text("Gender").bold()
                    .padding(.top, 20)
                Picker("Gender", selection: $profile.gender) {
                    ForEach(Profile.Gender.allCases) { gender in
                        Text(gender.rawValue).tag(gender)
                    }
                }
                .pickerStyle(.segmented)
            }
            VStack(alignment: .leading, spacing: 10){
                Text("Age").bold()
                    .padding(.top, 15)
                Picker("Your age", selection: $profile.age) {
                    ForEach(1...100, id: \.self) { age in
                        Text("\(age)")
                    }
                }
                .pickerStyle(.menu)
            }
        }
    }
}

struct ProfileEdit_Previews: PreviewProvider {
    
    static var previews: some View {
        ProfileEdit(profile: .constant(.default))
    }
}
