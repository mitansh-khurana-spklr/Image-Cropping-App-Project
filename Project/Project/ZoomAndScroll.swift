//
//  ZoomAndScroll.swift
//  Project
//
//  Created by Mitansh Khurana on 14/06/22.
//

import Foundation
import SwiftUI
import UIKit


//var imageView = UIImageView()

var scroll = UIScrollView()
var horizontalOffset = CGFloat(0)
var verticalOffset = CGFloat(0)


struct ZoomableView: UIViewRepresentable {
    @Binding var uiImage: UIImage
//    @Binding var frameWidth: CGFloat
//    @Binding var frameHeight: CGFloat
    let viewSize: CGSize
//    @Binding var horizontalOffset: CGFloat
//    @Binding var verticalOffset: CGFloat
    @Binding var frameWidth: CGFloat
    @Binding var frameHeight: CGFloat
//    var croppedImage: UIImage
    
//    var imageView : UIImageView


    private enum Constraint: String {
        case top
        case leading
        case bottom
        case trailing
    }
    
    private var minimumZoomScale: CGFloat {
//        let widthScale = viewSize.width / uiImage.size.width
//        let heightScale = viewSize.height / uiImage.size.height
        
        
        let widthScale = frameWidth / uiImage.size.width
        let heightScale = frameHeight / uiImage.size.height
        return max(widthScale, heightScale)
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        
        scrollView.delegate = context.coordinator
        scrollView.maximumZoomScale = minimumZoomScale * 10
        scrollView.minimumZoomScale = minimumZoomScale
        scrollView.bouncesZoom = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        
        let imageView = UIImageView(image: uiImage)
        scrollView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        verticalOffset = (viewSize.height - frameHeight)/2
        horizontalOffset = (viewSize.width - frameWidth)/2
        
//        let topConstraint = imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: verticalOffset)
//        topConstraint.identifier = Constraint.top.rawValue
//        topConstraint.isActive = true
//
//        let leadingConstraint = imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: horizontalOffset)
//        leadingConstraint.identifier = Constraint.leading.rawValue
//        leadingConstraint.isActive = true
        
        
        let topConstraint = imageView.topAnchor.constraint(equalTo: scrollView.topAnchor)
        topConstraint.identifier = Constraint.top.rawValue
        topConstraint.isActive = true
        
        let leadingConstraint = imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor)
        leadingConstraint.identifier = Constraint.leading.rawValue
        leadingConstraint.isActive = true
        
        let bottomConstraint = imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        bottomConstraint.identifier = Constraint.bottom.rawValue
        bottomConstraint.isActive = true


        let trailingConstraint = imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        trailingConstraint.identifier = Constraint.trailing.rawValue
        trailingConstraint.isActive = true
        
    

//        imageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: horizontalOffset).isActive = true
//        imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: verticalOffset).isActive = true


        
        scroll = scrollView
        
        return scrollView
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    func updateUIView(_ scrollView: UIScrollView, context: Context) {
        // reintializing imageview to take into consideration new image
        let subviews = scrollView.subviews
        for subview in subviews{
            subview.removeFromSuperview()
        }
        
        let imageView1 = UIImageView(image: uiImage)
        scrollView.addSubview(imageView1)
        imageView1.translatesAutoresizingMaskIntoConstraints = false
        
        
        verticalOffset = (viewSize.height - frameHeight)/2
        horizontalOffset = (viewSize.width - frameWidth)/2
        
    
//        let topConstraint1 = imageView1.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: verticalOffset)
//        topConstraint1.identifier = Constraint.top.rawValue
//        topConstraint1.isActive = true
//
//        let leadingConstraint1 = imageView1.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: horizontalOffset)
//        leadingConstraint1.identifier = Constraint.leading.rawValue
//        leadingConstraint1.isActive = true
        
        let topConstraint1 = imageView1.topAnchor.constraint(equalTo: scrollView.topAnchor)
        topConstraint1.identifier = Constraint.top.rawValue
        topConstraint1.isActive = true
        
        let leadingConstraint1 = imageView1.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor)
        leadingConstraint1.identifier = Constraint.leading.rawValue
        leadingConstraint1.isActive = true
                
        
        let bottomConstraint = imageView1.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        bottomConstraint.identifier = Constraint.bottom.rawValue
        bottomConstraint.isActive = true

        let trailingConstraint = imageView1.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        trailingConstraint.identifier = Constraint.trailing.rawValue
        trailingConstraint.isActive = true
        
        
    

//        imageView1.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: horizontalOffset).isActive = true
//        imageView1.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: verticalOffset).isActive = true
        
        scrollView.minimumZoomScale = minimumZoomScale
        scrollView.maximumZoomScale = minimumZoomScale * 10
    
        
        
        guard let imageView = scrollView.subviews.first as? UIImageView else {
            return
        }
        
        // Inject dependencies into coordinator
        context.coordinator.zoomableView = imageView
        context.coordinator.imageSize = uiImage.size
        context.coordinator.viewSize = viewSize
//        let topConstraint = scrollView.constraints.first { $0.identifier == Constraint.top.rawValue }
//        let leadingConstraint = scrollView.constraints.first { $0.identifier == Constraint.leading.rawValue }
//        context.coordinator.topConstraint = topConstraint1
//        context.coordinator.leadingConstraint = leadingConstraint1
//        context.coordinator.trailingConstraint = trailingConstraint
////        context.coordinator.bottomConstraint = bottomConstraint
//        context.coordinator.verticalOffset = verticalOffset
//        context.coordinator.horizontalOffset = horizontalOffset
        
//        context.coordinator.croppedImage = croppedImage

        // Set initial zoom scale
        scrollView.zoomScale = minimumZoomScale
        
        scroll = scrollView
    }
    
    
    static func crop(uiImage: UIImage, width: CGFloat, height: CGFloat) -> UIImage{
        let zoomScale = scroll.zoomScale
        let xOffset = scroll.contentOffset.x / zoomScale
        let yoffset = scroll.contentOffset.y / zoomScale
        let cropWidth : CGFloat = width / zoomScale
        let cropHeight : CGFloat = height / zoomScale
        
        let rect = CGRect(x: xOffset, y: yoffset, width: cropWidth, height: cropHeight)
        let cgImage = uiImage.cgImage!
        let croppedCGImage = cgImage.cropping(to: rect)
        let croppedImage = UIImage(cgImage: croppedCGImage!)
        return croppedImage
    }
}

// MARK: - Coordinator

extension ZoomableView {
    class Coordinator: NSObject, UIScrollViewDelegate {
        var zoomableView: UIView?
        var imageSize: CGSize?
        var viewSize: CGSize?
        var topConstraint: NSLayoutConstraint?
        var leadingConstraint: NSLayoutConstraint?
        var trailingConstraint: NSLayoutConstraint?
        var bottomConstraint: NSLayoutConstraint?
        var verticalOffset: CGFloat?
        var horizontalOffset: CGFloat?
//        var croppedImage: UIImage?

        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            zoomableView
        }
        
        func scrollViewDidZoom(_ scrollView: UIScrollView) {
//            let zoomScale = scrollView.zoomScale
//            print("zoomScale = \(zoomScale)")
//            print("xoffset = \(scrollView.contentOffset.x)")
//            print("yoffset = \(scrollView.contentOffset.y)")
//
//            guard
//                let topConstraint = topConstraint,
//                let leadingConstraint = leadingConstraint,
//                let trailingConstraint = trailingConstraint,
//                let bottomConstraint = bottomConstraint,
//                let imageSize = imageSize,
//                let viewSize = viewSize
//            else {
//                return
//            }
//            topConstraint.constant = max((viewSize.height - (imageSize.height * zoomScale)) / 2.0, 0.0)
//            leadingConstraint.constant = max((viewSize.width - (imageSize.width * zoomScale)) / 2.0, 0.0)
//            bottomConstraint.constant = verticalOffset!
//            trailingConstraint.constant = horizontalOffset!
        }
        
        
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            print("zoomScale = \(scrollView.zoomScale)")
            print("xoffset = \(scrollView.contentOffset.x)")
            print("yoffset = \(scrollView.contentOffset.y)")
        }
    }
}
