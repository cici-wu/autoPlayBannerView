//
//  ContentView.swift
//  bannerView
//
//  Created by cc on 2020/10/30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                PageView(features.map { destination in
                    NavigationLink(destination: LandmarkDetail(landmark: destination)) {
                        FeatureCard(landmark: destination)
                    }
                }, autoPlay: 5).aspectRatio(3/2, contentMode: .fit)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
