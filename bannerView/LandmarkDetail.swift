//
//  LandmarkDetail.swift
//  bannerView
//
//  Created by cc on 2020/10/30.
//

import SwiftUI

struct LandmarkDetail: View {
    
    var landmark: Landmark
    
    var body: some View {
        Text(landmark.name)
    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkDetail(landmark: features[0])
    }
}
