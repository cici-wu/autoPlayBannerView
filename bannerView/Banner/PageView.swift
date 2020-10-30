//
//  PageView.swift
//  bannerView
//
//  Created by cc on 2020/10/30.
//

import SwiftUI
import Combine

struct PageView<Page: View>: View {
    
    var viewControllers: [UIHostingController<Page>]
    
    var autoPlay : Int
    @State var currentPage = 0
    @State var timerActive : Bool = false

    init(_ views: [Page], autoPlay: Int = 0) {
        self.viewControllers = views.map{ UIHostingController(rootView: $0) }
        self.autoPlay = autoPlay
        
        let timerActive = (autoPlay > 0)
        
        self.timerActive = timerActive
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            PageViewController(controllers: viewControllers, playTime: autoPlay, currentPage: $currentPage, timerActive: $timerActive)
            PageControl(numberOfPages: viewControllers.count, currentPage: $currentPage)
                .padding(.trailing)
        }.onAppear(perform: {
            if self.autoPlay > 0 {
                self.timerActive = true
            }
        }).onDisappear(perform: {
            if self.autoPlay > 0 {
                self.timerActive = false
            }
        })
    }
}
