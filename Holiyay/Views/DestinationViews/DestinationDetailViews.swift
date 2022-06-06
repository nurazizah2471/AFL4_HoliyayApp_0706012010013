//
//  DestinationDetail.swift
//  Holiyay
//
//  Created by SIFT - Telkom DBT Air 9 on 04/06/22.
//

import Foundation
import SwiftUI

struct DestinationDetailView: View {
    @EnvironmentObject var destinationDataModel: DestinationDataModel
    var destinationModel: DestinationModel
    
    var body: some View {
        VStack{
            ContentShow_DestinationDetailView(destinationModel: destinationModel, destinationDataModel: destinationDataModel)
        }
    }
}

struct ContentShow_DestinationDetailView: View{
    var destinationModel: DestinationModel
    var destinationDataModel: DestinationDataModel
    
    var body: some View{
        VStack{
            ScrollView {
                MapShow_DestinationDetailView(destinationModel: destinationModel, destinationDataModel: destinationDataModel)
                IndicatorDescriptionShow_DestinationDetailView(destinationModel: destinationModel, destinationDataModel: destinationDataModel)
            }
            .navigationTitle(destinationModel.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MapShow_DestinationDetailView: View{
    
    var destinationModel: DestinationModel
    var destinationDataModel: DestinationDataModel
    
    var destinationModelIndex: Int {
        destinationDataModel.destinations.firstIndex(where: { $0.id == destinationModel.id }) ?? 0
    }
    
    var body: some View{
        VStack{
            MapView(coordinate: destinationModel.locationCoordinate)
                .ignoresSafeArea(edges: .top)
                .frame(height: 256)
            HStack{
                VStack(alignment: .leading){
                    HStack{
                        Text(destinationModel.name)
                            .font(.title)
                            .fontWeight(.heavy)
                    }
                    IndicatorDestinationShow_DestinationDetailView(destinationModel: destinationModel)
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct IndicatorDestinationShow_DestinationDetailView: View{
    var destinationModel: DestinationModel
    
    var body: some View{
        VStack{
            HStack(spacing: 18) {
                Text(destinationModel.category.rawValue)
                    .padding(10)
                    .background(Capsule().stroke(lineWidth: 3))
                    .font(.system(size: 17, weight: .semibold, design: .default))
                Label(destinationModel.city + ", " + destinationModel.country, systemImage: "pin.fill")
                    .font(.system(size: 17, weight: .medium, design: .default))
            }
            .font(.subheadline)
        }
    }
}

struct IndicatorDescriptionShow_DestinationDetailView: View{
    
    @State private var isPresented = false
    var destinationModel: DestinationModel
    var destinationDataModel: DestinationDataModel
    
    func CheckAvailable()->Int{
        var tmp = 0
        
        for val in destinationDataModel.destinations{
            if(!val.isBookmark){
                tmp = tmp + 1
            }
        }
        return tmp
    }
    
    var body: some View{
        VStack(alignment: .leading){
            Text(destinationModel.description)
                .padding(.bottom)
            HStack{
                Text("Will be visited on:")
                
                if(destinationModel.isBookmark){
                    Text("\(destinationModel.plandate)")
                        .fontWeight(.heavy)
                } else {
                    Text("-")
                }
            }
            .padding(.bottom)
            
            if((!destinationModel.isBookmark && CheckAvailable() > 1) || destinationModel.isBookmark){
                Button {
                    isPresented.toggle()
                } label: {
                    if(destinationModel.isBookmark){
                        Label("Edit My Visit Date", systemImage: "calendar")
                            .frame(maxWidth: .infinity)
                    } else {
                        Label("Plan My Visit Date", systemImage: "calendar")
                            .frame(maxWidth: .infinity)
                    }
                }
                .buttonStyle(PrimaryButton())
                .fullScreenCover(isPresented: $isPresented) {
                    FullScreenModalShow_DestinationDetailView(destinationModel: self.destinationModel, destinationDataModel: self.destinationDataModel)
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

struct FullScreenModalShow_DestinationDetailView: View {
    var destinationModel: DestinationModel
    var destinationDataModel: DestinationDataModel
    
    var body: some View {
        VStack{
            BarContentShow_DestinationDetailView()
            ScrollViewContentShow_DestinationDetailView(destinationModel: destinationModel, destinationDataModel: destinationDataModel)
        }
    }
}

struct BarContentShow_DestinationDetailView: View{
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

struct ScrollViewContentShow_DestinationDetailView: View{
    var destinationModel: DestinationModel
    var destinationDataModel: DestinationDataModel
    
    var body: some View{
        VStack {
            ScrollView{
                UpContentShow_FullScreenModalShow_DestinationDetailView()
                MainContentShow_FullScreenModalShow_DestinationDetailView(destinationModel: destinationModel, destinationDataModel: destinationDataModel)
            }
        }
    }
}

struct  UpContentShow_FullScreenModalShow_DestinationDetailView: View{
    
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

struct MainContentShow_FullScreenModalShow_DestinationDetailView: View{
    @Environment(\.presentationMode) var presentationMode
    @State var visitDate = Date()
    var destinationModel: DestinationModel
    var destinationDataModel: DestinationDataModel
    
    var destinationIndex: Int {
        destinationDataModel.destinations.firstIndex(where: { $0.id == destinationModel.id })!
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
                
                MyBookmarkModel.setup()
                MyBookmarkModel.destinations[destinationIndex].isBookmark = true
                MyBookmarkModel.destinations[destinationIndex].plandate = dateFormat()
            } label: {
                if(destinationModel.isBookmark){
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

struct DestinationDetailView_Previews: PreviewProvider {
    static let destinationDataModel = DestinationDataModel()
    
    static var previews: some View {
        DestinationDetailView(destinationModel: destinationDataModel.destinations[0])
            .environmentObject(destinationDataModel)
    }
}
