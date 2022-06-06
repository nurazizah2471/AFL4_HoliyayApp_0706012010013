//
//  BookmarkCardView.swift
//  Holiyay
//
//  Created by SIFT - Telkom DBT Air 9 on 04/06/22.
//

import SwiftUI

struct BookmarkCardView: View {
    @EnvironmentObject var destinationData: DestinationData
    var destination: Destination
    
    var body: some View {
        VStack() {
            UpIndicatorContent_BookmarkCardView(destination: destination)
            
            IndicatorContent_BookmarkCardView(destination: destination)
        }
        .background(Color("Component"))
        .cornerRadius(10)
    }
}

struct UpIndicatorContent_BookmarkCardView: View{
    var destination: Destination
    
    var body: some View{
        VStack{
            destination.thumbnail
                .resizable()
                .scaledToFill()
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*(25/100))
    }
}

struct IndicatorContent_BookmarkCardView: View {
    var destination: Destination
    
    var body: some View{
        VStack (alignment: .leading){
            Text(destination.name)
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.white)
            HStack(spacing: 25) {
                Text(destination.category.rawValue)
                    .padding()
                
                    .background(Capsule().stroke(lineWidth: 3))
                    .font(.system(size: 16, weight: .heavy, design: .rounded))
                    .foregroundColor(.white)
                Label(destination.city + ", " + destination.country, systemImage: "pin.fill")
                    .font(.system(size: 19, weight: .regular, design: .default))
                    .lineLimit(1)
                    .foregroundColor(Color("Muted"))
            }
            .font(.subheadline)
            .padding(.bottom)
            Label("Your Planning: \(destination.plandate)", systemImage: "calendar")
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
    static let destinationData = DestinationData()
    
    static var previews: some View {
        BookmarkCardView(destination: DestinationData().destinations[0])
            .environmentObject(destinationData)
    }
}
