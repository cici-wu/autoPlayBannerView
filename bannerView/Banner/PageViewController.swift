//
//  PageViewController.swift
//  bannerView
//
//  Created by cc on 2020/10/30.
//


import SwiftUI
import UIKit

struct PageViewController: UIViewControllerRepresentable {
    var controllers: [UIViewController]
    var playTime: Int
    @Binding var currentPage: Int
    @Binding var timerActive: Bool

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator

        return pageViewController
    }

    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        pageViewController.setViewControllers(
            [controllers[currentPage]], direction: .forward, animated: true)
        if timerActive {
            context.coordinator.startTimer()
        } else {
            context.coordinator.stopTimer()
        }
    }

    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var parent: PageViewController
        var timer: Timer
        
        init(_ pageViewController: PageViewController) {
            self.parent = pageViewController
            self.timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(pageViewController.playTime), repeats: true) { (timer) in
                pageViewController.currentPage = (pageViewController.currentPage + 1) % pageViewController.controllers.count
            }
        }

        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerBefore viewController: UIViewController) -> UIViewController? {
            
            guard let index = parent.controllers.firstIndex(of: viewController) else {
                return nil
            }
            
            if index == 0 {
                return parent.controllers.last
            }
            return parent.controllers[index - 1]
        }

        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = parent.controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index + 1 == parent.controllers.count {
                return parent.controllers.first
            }
            return parent.controllers[index + 1]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
            self.stopTimer()
        }

        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            if finished {
                self.startTimer()
            }
            if completed,
                let visibleViewController = pageViewController.viewControllers?.first,
                let index = parent.controllers.firstIndex(of: visibleViewController) {
                parent.currentPage = index
            }
        }
        
        func startTimer() {
            if !self.timer.isValid {
                self.timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(parent.playTime), repeats: true) { (timer) in
                    self.parent.currentPage = (self.parent.currentPage + 1) % self.parent.controllers.count
                }
            }
        }
        
        func stopTimer()  {
            self.timer.invalidate()
        }
    }
}
