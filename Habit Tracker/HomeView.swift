//
//  HomeView.swift
//  Habit Tracker
//
//  Created by Ichsan Firdaus on 10/03/26.
//

import SwiftUI
import SwiftData

struct HomeView : View {
    var body: some View {
        VStack(alignment: .center){
            Text("Habit Tracker")
                .font(Font.largeTitle)
                .bold()
                .padding(60)
//            Spacer()
            HStack(spacing: 40){
                VStack(){
                    Ellipse()
                        .fill(Color.white)
                        .frame(width: 160, height: 160)
                        .shadow(radius: 15)
                    Text("Old Habit")
                }
                VStack(){
                    Ellipse()
                        .fill(Color.white)
                        .frame(width: 160, height: 160)
                        .shadow(radius: 15)
                    Text("New Habit")
                }
            }
            VStack(){
                Ellipse()
                    .fill(Color.white)
                    .frame(width: 160, height: 160)
                    .shadow(radius: 15)
                Text("Final Mix \n Habit")
                    .multilineTextAlignment(.center)
            }
//            Spacer()
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    HomeView()
        .modelContainer(for: Item.self, inMemory: true)
}
