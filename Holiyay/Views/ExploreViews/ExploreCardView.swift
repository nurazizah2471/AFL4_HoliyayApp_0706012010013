//
//  ExploreCardView.swift
//  Holiyay
//
//  Created by SIFT - Telkom DBT Air 9 on 04/06/22.
//

import SwiftUI

struct ExploreCardView: View {
    @EnvironmentObject var destinationDataMpdel: DestinationDataModel
    var destinationModel: DestinationModel
    
    var body: some View {
        ZStack {
            destinationModel.thumbnail
                .resizable()
            
            DescriptionContentShow_ExploreCardView(destinationModel: destinationModel)
        }
        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.width*(36/100))
        .cornerRadius(10)
        .padding(.bottom, 15)
    }
}

struct DescriptionContentShow_ExploreCardView: View{
    var destinationModel: DestinationModel
    
    var body: some View{
        VStack {
            HStack{
                VStack(alignment: .leading, spacing: 13.0){
                    Spacer()
                    Text(destinationModel.name)
                        .font(.system(size: 18, weight: .heavy, design: .default))
                        .foregroundColor(.white)
                    Label(destinationModel.city + ", " + destinationModel.country, systemImage: "pin.fill")
                        .font(.system(size: 12, weight: .semibold, design: .default))
                        .lineLimit(1)
                    Label("Create a Plan", systemImage: "calendar")
                        .padding(8)
                        .background(Color("Primary"))
                        .foregroundColor(.white)
                        .font(.system(size: 12, weight: .semibold, design: .default))
                        .cornerRadius(8)
                    Spacer()
                }
                .padding(.horizontal, UIScreen.main.bounds.width*(10/100))
                .foregroundColor(Color("Muted"))
                .frame(maxWidth: .infinity)
            }
        }
        .background(Color("Component"))
        .foregroundColor(.white)
        .padding(.leading, UIScreen.main.bounds.width*(35/100))
        .overlay(Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color("Primary"), Color("Accent")]), startPoint: .top, endPoint: .bottom))
                    .frame(width: UIScreen.main.bounds.width*(5/100), height: UIScreen.main.bounds.height, alignment: .top), alignment: .trailing)
    }
}

struct ExploreCardView_Previews: PreviewProvider {
    static let destinationDataModel = DestinationDataModel()
    
    static var previews: some View {
        ExploreCardView(destinationModel: destinationDataModel.destinations[0])
            .environmentObject(destinationDataModel)
    }
}
