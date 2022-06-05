//
//  DestinationDetail.swift
//  Holiyay
//
//  Created by SIFT - Telkom DBT Air 9 on 04/06/22.
//

import Foundation
import SwiftUI

struct DestinationDetail: View {
    var destination: Destination
    
    var body: some View {
        VStack{
            contentShow(destination: destination)
        }
    }
}

struct contentShow: View{
    var destination: Destination
    
    var body: some View{
        VStack{
            ScrollView {
                MapShow(destination: destination)
                IndicatorDescriptionShow(destination: destination)
            }
            .navigationTitle(destination.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MapShow: View{
    @EnvironmentObject var destinationData: DestinationData
    var destination: Destination
    
    var destinationIndex: Int {
        destinationData.destinations.firstIndex(where: { $0.id == destination.id }) ?? 0
    }
    
    var body: some View{
        VStack{
            MapView(coordinate: destination.locationCoordinate)
                .ignoresSafeArea(edges: .top)
                .frame(height: 256)
            HStack{
                VStack(alignment: .leading){
                    HStack{
                        Text(destination.name)
                            .font(.title)
                            .fontWeight(.heavy)
                    }
                    IndicatorDestinationShow(destination: destination)
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct IndicatorDestinationShow: View{
    var destination: Destination
    
    var body: some View{
        VStack{
            HStack(spacing: 18) {
                Text(destination.category.rawValue)
                    .padding(10)
                    .background(Capsule().stroke(lineWidth: 3))
                    .font(.system(size: 17, weight: .semibold, design: .default))
                Label(destination.city + ", " + destination.country, systemImage: "pin.fill")
                    .font(.system(size: 17, weight: .medium, design: .default))
                
            }
            .font(.subheadline)
        }
    }
}

struct IndicatorDescriptionShow: View{
    @EnvironmentObject var destinationData: DestinationData
    @State private var isPresented = false
    var destination: Destination
    
    func CheckAvailable()->Int{
        var tmp = 0
        
        for val in destinationData.destinations{
            if(!val.isBookmark){
                tmp = tmp + 1
            }
        }
        return tmp
    }
    
    var body: some View{
        VStack(alignment: .leading){
            Text(destination.description)
                .padding(.bottom)
            HStack{
                Text("Will be visited on:")
                
                if(destination.plandate != "0"){
                    Text("\(destination.plandate)")
                        .fontWeight(.heavy)
                } else {
                    Text("-")
                }
            }
            .padding(.bottom)
            
            if((!destination.isBookmark && CheckAvailable() > 1) || destination.isBookmark){
                Button {
                    isPresented.toggle()
                } label: {
                    if(destination.isBookmark){
                        Label("Edit My Visit Date", systemImage: "calendar")
                            .frame(maxWidth: .infinity)
                    } else {
                        Label("Plan My Visit Date", systemImage: "calendar")
                            .frame(maxWidth: .infinity)
                    }
                }
                .buttonStyle(PrimaryButton())
                .fullScreenCover(isPresented: $isPresented) {
                    FullScreenModalView(destination: self.destination)
                }
            } else{
                VStack{
                    Button {
                    } label: {
                        Label("There's 1 Left Destination Available in Your Explore Now. You Can't Make a Plan for this Destination!", systemImage: "")
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                    }
                    .padding()
                    .background(Color(hue: 0.666, saturation: 0.836, brightness: 0.434))
                }
                .frame(width: UIScreen.main.bounds.width*(95/100) )
                .foregroundColor(Color.white)
                .cornerRadius(10)
            }
        }
        .padding()
    }
}

struct FullScreenModalView: View {
    var destination: Destination
    
    var body: some View {
        VStack{
            BarContent_DestinationDetail()
            ScrollViewContent_DestinationDetail(destination: destination)
        }
    }
}

struct BarContent_DestinationDetail: View{
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View{
        VStack{
            HStack {
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct ScrollViewContent_DestinationDetail: View{
    var destination: Destination
    
    var body: some View{
        VStack {
            ScrollView{
                UpContent_FullScreenModalView()
                MainContent_FullScreenModalView(destination: destination)
            }
        }
    }
}

struct UpContent_FullScreenModalView: View{
    
    var body: some View{
        VStack{
            Text("Set Plan")
                .font(.title2)
                .fontWeight(.heavy)
                .padding()
            Image("visit_date")
                .resizable()
                .scaledToFill()
                .padding(.bottom)
                .frame(width: UIScreen.main.bounds.width*(25/100), height: UIScreen.main.bounds.height*(25/100))
        }
    }
}

struct MainContent_FullScreenModalView: View{
    @EnvironmentObject var destinationData: DestinationData
    @Environment(\.presentationMode) var presentationMode
    var destination: Destination
    @State var visitDate = Date()
    
    var destinationIndex: Int {
        destinationData.destinations.firstIndex(where: { $0.id == destination.id })!
    }
    
    func dateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY/MM/dd"
        return dateFormatter.string(from: visitDate)
    }
    
    var body: some View{
        VStack{
            CalendarView(visitDate: $visitDate)
            Text("Set Visit Date on: \(visitDate.formatted(date: .long, time: .omitted))")
                .foregroundColor(Color("Muted"))
                .padding()
            Button {
                presentationMode.wrappedValue.dismiss()
                
                MyBookmark.setup()
                MyBookmark.destinations[destinationIndex].isBookmark = true
                MyBookmark.destinations[destinationIndex].plandate = dateFormat()
            } label: {
                if(destination.plandate != "0"){
                    Label("Edit My Plan", systemImage: "pencil")
                        .frame(maxWidth: .infinity)
                } else {
                    Label("Save to Bookmark", systemImage: "bookmark.fill")
                        .frame(maxWidth: .infinity)
                }
            }
            .buttonStyle(PrimaryButton())
            .padding(.horizontal)
            .padding(.bottom)
        }
    }
}

struct DestinationDetail_Previews: PreviewProvider {
    static let destinationData = DestinationData()
    
    static var previews: some View {
        DestinationDetail(destination: DestinationData().destinations[0])
            .environmentObject(destinationData)
    }
}
