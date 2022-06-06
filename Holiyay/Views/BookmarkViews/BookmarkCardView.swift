//
//  BookmarkCardView.swift
//  Holiyay
//
//  Created by SIFT - Telkom DBT Air 9 on 04/06/22.
//

import SwiftUI

struct BookmarkCardView: View {
    @EnvironmentObject var destinationDataModel: DestinationDataModel
    var destinationModel: DestinationModel
    
    var body: some View {
        VStack() {
            UpIndicatorContentShow_BookmarkCardView(destinationModel: destinationModel)
            
            IndicatorContentShow_BookmarkCardView(destinationModel: destinationModel)
        }
        .background(Color("Component"))
        .cornerRadius(10)
    }
}

struct UpIndicatorContentShow_BookmarkCardView: View{
    var destinationModel: DestinationModel
    
    var body: some View{
        VStack{
            destinationModel.thumbnail
                .resizable()
                .scaledToFill()
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-500)
    }
}

struct IndicatorContentShow_BookmarkCardView: View {
    var destinationModel: DestinationModel
    
    var body: some View{
        VStack (alignment: .leading){
            Text(destinationModel.name)
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.white)
            HStack(spacing: 25) {
                Text(destinationModel.category.rawValue)
                    .padding()
                
                    .background(Capsule().stroke(lineWidth: 3))
                    .font(.system(size: 16, weight: .heavy, design: .rounded))
                Label(destinationModel.city + ", " + destinationModel.country, systemImage: "pin.fill")
                    .font(.system(size: 19, weight: .regular, design: .default))
                    .lineLimit(1)
            }
            .font(.subheadline)
            .foregroundColor(Color("Muted"))
            .padding(.bottom)
            Label("Your Planning: \(destinationModel.plandate)", systemImage: "calendar")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color("Primary"))
                .foregroundColor(.white)
                .font(.body.bold())
                .cornerRadius(13)
                .padding(.bottom, 10.5)
        }
        .padding(.top, 30)
        .padding()
    }
}

struct BookmarkCardView_Previews: PreviewProvider {
    static let destinationDataModel = DestinationDataModel()
    
    static var previews: some View {
        BookmarkCardView(destinationModel: destinationDataModel.destinations[0])
            .environmentObject(destinationDataModel)
    }
}
