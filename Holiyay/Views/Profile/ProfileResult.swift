//
//  ProfileResult.swift
//  Holiyay
//
//  Created by SIFT - Telkom DBT Air 9 on 04/06/22.
//

import SwiftUI

struct ProfileResult: View {
    @EnvironmentObject var destinationData: DestinationData
    var profile: Profile
    
    var body: some View {
        ScrollView {
            VStack {
                (Text("Hello, ") +
                 Text("\(profile.firstName) \(profile.lastName) \u{1F44B}"))
                    .font(.system(size: 26))
                    .fontWeight(.black)
                DescriptionContent_ProfileResult(profile: profile)
            }
            .frame(maxHeight: .infinity)
        }
    }
}

struct DescriptionContent_ProfileResult: View{
    var profile: Profile
    
    var body: some View{
        VStack{
            Image(systemName: "person.text.rectangle.fill")
                .symbolRenderingMode(.hierarchical)
                .font(.system(size: 96))
                .foregroundColor(Color("Primary"))
                .padding()
            ProfileContent_ProfileResult(profile: profile)
        }
        .frame(width: UIScreen.main.bounds.width - 75)
        .padding()
        .background(Color("Component"))
        .foregroundColor(.white)
        .cornerRadius(16)
    }
}

struct ProfileContent_ProfileResult: View {
    var profile:Profile
    
    var body: some View{
        VStack{
            VStack(spacing: -3){
                HStack{
                    Text("\(Image(systemName: "quote.opening"))")
                    VStack(alignment: .leading, spacing: 10){
                        Text("First Name")
                            .bold()
                        Text(profile.firstName)
                            .foregroundColor(Color("Muted"))
                    }
                    .padding(.top, UIScreen.main.bounds.width-340)
                    Spacer()
                }
                HStack{
                    Text("\(Image(systemName: "quote.closing"))")
                    VStack(alignment: .leading, spacing: 10){
                        Text("Last Name")
                            .bold()
                        Text(profile.lastName)
                            .foregroundColor(Color("Muted"))
                    }
                    .padding(.top, UIScreen.main.bounds.width-340)
                    Spacer()
                }
                HStack{
                    Text("\(Image(systemName: "flag.fill"))")
                    VStack(alignment: .leading, spacing: 10){
                        Text("Country of Domicile")
                            .bold()
                        Text(profile.selectedCountry)
                            .foregroundColor(Color("Muted"))
                    }
                    .padding(.top, UIScreen.main.bounds.width-340)
                    Spacer()
                }
                HStack{
                    Text("\(Image(systemName: "figure.stand"))")
                    VStack(alignment: .leading, spacing: 10){
                        Text("Gender")
                            .bold()
                        Text(profile.gender.rawValue)
                            .foregroundColor(Color("Muted"))
                    }
                    .padding(.top, UIScreen.main.bounds.width-340)
                    Spacer()
                }
                HStack{
                    Text("\(Image(systemName: "number"))")
                    VStack(alignment: .leading, spacing: 10){
                        Text("Age")
                            .bold()
                        Text(profile.age.description)
                            .foregroundColor(Color("Muted"))
                    }
                    .padding(.top, UIScreen.main.bounds.width-340)
                    Spacer()
                }
            }
            .padding(.top, -30)
        }
        .font(.title3)
        .padding(.bottom)
        .padding(.horizontal)
    }
}

struct ProfileResult_Previews: PreviewProvider {
    
    static var previews: some View {
        ProfileResult(profile: Profile.default)
            .environmentObject(DestinationData())
    }
}
