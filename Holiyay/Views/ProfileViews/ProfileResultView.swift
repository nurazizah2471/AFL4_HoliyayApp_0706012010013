//
//  ProfileResult.swift
//  Holiyay
//
//  Created by SIFT - Telkom DBT Air 9 on 04/06/22.
//

import SwiftUI

struct ProfileResultView: View {
    @EnvironmentObject var destinationDataModel: DestinationDataModel
    var profileModel: ProfileModel
    
    var body: some View {
        ScrollView {
            VStack {
                (Text("Hello, ") +
                 Text("\(profileModel.firstName) \(profileModel.lastName) \u{1F44B}"))
                    .font(.system(size: 26))
                    .fontWeight(.black)
                DescriptionContentShow_ProfileResultView(profileModel: profileModel)
            }
            .frame(maxHeight: .infinity)
        }
    }
}

struct DescriptionContentShow_ProfileResultView: View{
    var profileModel: ProfileModel
    
    var body: some View{
        VStack{
            Image(systemName: "person.text.rectangle.fill")
                .symbolRenderingMode(.hierarchical)
                .font(.system(size: 96))
                .foregroundColor(Color("Primary"))
                .padding()
            ProfileContentShow_ProfileResultView(profileModel: profileModel)
        }
        .frame(width: UIScreen.main.bounds.width - 75)
        .padding()
        .background(Color("Component"))
        .foregroundColor(.white)
        .cornerRadius(16)
    }
}

struct ProfileContentShow_ProfileResultView: View {
    var profileModel:ProfileModel
    
    var body: some View{
        VStack{
            VStack(spacing: -3){
                HStack{
                    Text("\(Image(systemName: "quote.opening"))")
                    VStack(alignment: .leading, spacing: 10){
                        Text("First Name")
                            .bold()
                        Text(profileModel.firstName)
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
                        Text(profileModel.lastName)
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
                        Text(profileModel.selectedCountry)
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
                        Text(profileModel.gender.rawValue)
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
                        Text(profileModel.age.description)
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

struct ProfileResultView_Previews: PreviewProvider {
    
    static var previews: some View {
        ProfileResultView(profileModel: ProfileModel.default)
            .environmentObject(DestinationDataModel())
    }
}
