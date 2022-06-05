//
//  SplashScreenView.swift
//  Holiyay
//
//  Created by SIFT - Telkom DBT Air 9 on 04/06/22.
//

import SwiftUI

struct SplashScreenView: View {
    @State var isActive = false
    @State var size = 0.10
    @State var opacity = 0.1
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            SplashScreenShow(size: $size, opacity: $opacity, isActive: $isActive)
        }
    }
}

struct LogoShow: View{
    
    var body: some View{
        Spacer()
        VStack {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 60)
            Text("Holiyay")
                .fontWeight(.black)
                .foregroundColor(Color("Primary"))
                .font(.system(size: 40))
        }
        Spacer()
    }
}

struct SplashScreenShow: View{
    @Binding var size: Double
    @Binding var opacity: Double
    @Binding var isActive:Bool
    
    var body: some View{
        VStack {
            LogoShow()
            VStack {
                Text("&copy; 2022 Archotech")
                    .fontWeight(.bold)
                    .foregroundColor(Color("Muted"))
            }
        }
        .scaleEffect(size)
        .opacity(opacity)
        .onAppear {
            withAnimation(.easeIn(duration:0.8)) {
                self.size = 0.70
                self.opacity = 1.0
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                self.isActive = true
            }
        }
        .statusBar(hidden: true)
        .preferredColorScheme(.dark)
    }
    
}

struct SplashScreenView_Previews: PreviewProvider {
    
    static var previews: some View {
        SplashScreenView()
            .previewInterfaceOrientation(.portrait)
    }
}
