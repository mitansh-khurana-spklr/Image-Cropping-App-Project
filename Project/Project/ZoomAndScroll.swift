//
//  ZoomAndScroll.swift
//  Project
//
//  Created by Mitansh Khurana on 14/06/22.
//

import Foundation
import SwiftUI
import UIKit
import AVFoundation


//var imageView = UIImageView()

var scroll = UIScrollView()
var horizontalOffsetNew = CGFloat(0)
var verticalOffsetNew = CGFloat(0)
var rotateAngle : Float = 0
var newImage = UIImage()

struct ZoomableView: UIViewRepresentable {
    @Binding var uiImage: UIImage
    let viewSize: CGSize
//    @Binding var horizontalOffset: CGFloat
//    @Binding var verticalOffset: CGFloat
    @Binding var frameWidth: CGFloat
    @Binding var frameHeight: CGFloat
    
    @Binding var rotation: Float
    @Binding var aspectRatioSize: CGSize
    @EnvironmentObject var rotateHelper: RotateHelper


    private enum Constraint: String {
        case top
        case leading
        case bottom
        case trailing
    }
    
    private var minimumZoomScale: CGFloat {
//        let widthScale = viewSize.width / uiImage.size.width
//        let heightScale = viewSize.height / uiImage.size.height
        
//        let tempRect = CGRect(x: 0, y: 0, width: uiImage.size.width, height: uiImage.size.height)
//        let tempTransform = CGAffineTransform(rotationAngle: CGFloat(rotateHelper.rotateByAngle))
//        let newRect = tempRect.applying(tempTransform)
//
//        let fittingRect = AVMakeRect(aspectRatio: aspectRatioSize, insideRect: newRect)
        
        
        
        
        let dx1 = frameWidth * cos(CGFloat(rotateHelper.rotateByAngle) * .pi/180) + frameHeight * sin(CGFloat(rotateHelper.rotateByAngle) * .pi/180)
        
        let dy1 = frameHeight * cos(CGFloat(rotateHelper.rotateByAngle) * .pi/180) + frameWidth * sin(CGFloat(rotateHelper.rotateByAngle) * .pi/180)
        
        var dx = dx1
        var dy = dy1
        
        
        if rotateHelper.rotateByAngle <= 90 {
            dx = frameWidth * cos(CGFloat(rotateHelper.rotateByAngle) * .pi/180) + frameHeight * sin(CGFloat(rotateHelper.rotateByAngle) * .pi/180)
            dy = frameHeight * cos(CGFloat(rotateHelper.rotateByAngle) * .pi/180) + frameWidth * sin(CGFloat(rotateHelper.rotateByAngle) * .pi/180)
        }
        else if rotateHelper.rotateByAngle <= 180 {
            let modAngle = rotateHelper.rotateByAngle - 90
            dx = frameHeight * cos(CGFloat(modAngle) * .pi/180) + frameWidth * sin(CGFloat(modAngle) * .pi/180)
            dy = frameWidth * cos(CGFloat(modAngle) * .pi/180) + frameHeight * sin(CGFloat(modAngle) * .pi/180)
        }
        else if rotateHelper.rotateByAngle <= 270 {
            let modAngle = rotateHelper.rotateByAngle - 180
            dx = frameWidth * cos(CGFloat(modAngle) * .pi/180) + frameHeight * sin(CGFloat(modAngle) * .pi/180)
            dy = frameHeight * cos(CGFloat(modAngle) * .pi/180) + frameWidth * sin(CGFloat(modAngle) * .pi/180)
        }
        else{
            let modAngle = rotateHelper.rotateByAngle - 270
            dx = frameHeight * cos(CGFloat(modAngle) * .pi/180) + frameWidth * sin(CGFloat(modAngle) * .pi/180)
            dy = frameWidth * cos(CGFloat(modAngle) * .pi/180) + frameHeight * sin(CGFloat(modAngle) * .pi/180)
        }
        
        
        let rectRatio = abs(dx / dy)
        let viewRatio =  uiImage.size.width / uiImage.size.height
        
        var scale : CGFloat = 1
        if rectRatio > viewRatio{
            scale = uiImage.size.width / abs(dx)
        }
        else{
            scale = uiImage.size.height / abs(dy)
        }
        
        
        return 1/scale
        
        
//        let widthScale = frameWidth / newImage.size.width
//        let heightScale = frameHeight / newImage.size.height
//        return max(widthScale, heightScale)
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        
        scrollView.delegate = context.coordinator
        scrollView.maximumZoomScale = minimumZoomScale * 10
        scrollView.minimumZoomScale = minimumZoomScale
        scrollView.bouncesZoom = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        
        verticalOffsetNew = (viewSize.height - frameHeight)/2
        horizontalOffsetNew = (viewSize.width - frameWidth)/2
        
        
//        let imageView = UIImageView(image: uiImage)
//        let dummyContainer = UIView()
//        dummyContainer.addSubview(imageView)
//        scrollView.addSubview(dummyContainer)
        
        let imageView = UIImageView(image: uiImage)
        scrollView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInset = UIEdgeInsets(top: verticalOffsetNew, left: horizontalOffsetNew, bottom: verticalOffsetNew, right: horizontalOffsetNew)
        
        scrollView.setContentOffset(CGPoint(x: 100, y: 100), animated: false)
        
        /*
        let temp = RotateHelperWithFunc()
        let rotateGesture = UIRotationGestureRecognizer(target: self, action:     #selector(temp.handleRotate(_:)))
        scrollView.addGestureRecognizer(rotateGesture)
         */
    
        
        
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
         
         
        
//        imageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
//        imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
         
        
        
//        imageView.transform = CGAffineTransform(rotationAngle: radians);
        
//        scrollView.contentSize.height = frameHeight
//        scrollView.frame.origin.y = -200
        
        scroll = scrollView
        
//        scrollView.transform = CGAffineTransform(rotationAngle: radians)
        
        return scrollView
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    func updateUIView(_ scrollView: UIScrollView, context: Context) {
        // reintializing imageview to take into consideration new image
        
//        let currentZoomScale = scrollView.zoomScale
        
        let subviews = scrollView.subviews
        for subview in subviews{
            subview.removeFromSuperview()
        }
        
        
        verticalOffsetNew = (viewSize.height - frameHeight)/2
        horizontalOffsetNew = (viewSize.width - frameWidth)/2
        
        let CGrotation = CGFloat(rotateHelper.rotateByAngle)
        let radians = CGrotation * Double.pi/180
        
        newImage = uiImage.rotate(radians: Float(radians))!
//        newImage = uiImage
        
        /*
        let imageView1 = UIImageView(image: newImage)
        let dummyContainer = UIView()
        dummyContainer.addSubview(imageView1)
        scrollView.addSubview(dummyContainer)
        */
        
        let imageView1 = UIImageView(image: newImage)
        scrollView.addSubview(imageView1)
        imageView1.translatesAutoresizingMaskIntoConstraints = false
        
//        let tr = CGAffineTransform.identity.rotated(by: radians)
//        scrollView.subviews.first?.transform = tr
        
        
        /*
        let temp = RotateHelperWithFunc()
        let rotateGesture = UIRotationGestureRecognizer(target: self, action:     #selector(temp.handleRotate(_:)))
        imageView1.addGestureRecognizer(rotateGesture)
         */
        
        scrollView.contentInset = UIEdgeInsets(top: verticalOffsetNew, left: horizontalOffsetNew, bottom: verticalOffsetNew, right: horizontalOffsetNew)
        
        
//        let topSet = Float(frameWidth) * cos(rotateHelper.rotateByAngle * .pi/180) * sin(rotateHelper.rotateByAngle * .pi/180)
//
//        let horizSet = Float(frameHeight) * cos(rotateHelper.rotateByAngle * .pi/180) * sin(rotateHelper.rotateByAngle * .pi/180)
//
//
//        scrollView.setContentOffset(CGPoint(x: 500, y: 500), animated: false)
        
        
        
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
         
         
         
//        imageView1.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
//        imageView1.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
//        imageView1.transform = CGAffineTransform(rotationAngle: radians);
        
        
        scrollView.minimumZoomScale = minimumZoomScale
        scrollView.maximumZoomScale = minimumZoomScale * 10
        
//        guard let imageView = scrollView.subviews.first as? UIImageView else {
//            return
//        }
        
        guard let dummyView = scrollView.subviews.first else {
            return
        }
        
        // Inject dependencies into coordinator
//        context.coordinator.zoomableView = imageView
        context.coordinator.zoomableView = dummyView
        context.coordinator.imageSize = uiImage.size
        context.coordinator.viewSize = viewSize
        context.coordinator.frameWidth = frameWidth
        context.coordinator.frameHeight = frameHeight
        context.coordinator.angleRotation = rotateHelper.rotateByAngle
        context.coordinator.newImage = newImage
//        let topConstraint = scrollView.constraints.first { $0.identifier == Constraint.top.rawValue }
//        let leadingConstraint = scrollView.constraints.first { $0.identifier == Constraint.leading.rawValue }
//        context.coordinator.topConstraint = topConstraint1
//        context.coordinator.leadingConstraint = leadingConstraint1
//        context.coordinator.trailingConstraint = trailingConstraint
////        context.coordinator.bottomConstraint = bottomConstraint
        context.coordinator.verticalOffset = verticalOffsetNew
        context.coordinator.horizontalOffset = horizontalOffsetNew
        
//        context.coordinator.croppedImage = croppedImage

        // Set initial zoom scale
//        if currentZoomScale >= minimumZoomScale && currentZoomScale <= minimumZoomScale*10{
//            scrollView.zoomScale = currentZoomScale
//        }
//        else{
//            scrollView.zoomScale = minimumZoomScale
//        }
        
        scrollView.zoomScale = minimumZoomScale
        
        
//        scrollView.transform = CGAffineTransform(rotationAngle: radians)
        
        scroll = scrollView
    }
    
    
    
    static func crop(uiImage: UIImage, width: CGFloat, height: CGFloat) -> UIImage{
        let zoomScale = scroll.zoomScale
        let xOffset = scroll.contentOffset.x / zoomScale + horizontalOffsetNew / zoomScale
        let yoffset = scroll.contentOffset.y / zoomScale + verticalOffsetNew / zoomScale
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
        var frameWidth: CGFloat?
        var frameHeight: CGFloat?
        var angleRotation: Float?
        var newImage: UIImage?
//        var croppedImage: UIImage?

        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            zoomableView
        }
        
        
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            let topSet = (Float(frameWidth!) * cos(angleRotation! * .pi/180) * sin(angleRotation! * .pi/180)) - Float(verticalOffset!)
               
            let horizSet = (Float(frameHeight!) * cos(angleRotation! * .pi/180) * sin(angleRotation! * .pi/180)) - Float(horizontalOffset!)
               
               /*
            let fullWidth = imageSize!.width * cos(CGFloat(angleRotation!) * .pi/180) + imageSize!.height * sin(CGFloat(angleRotation!) * .pi/180)
            
            let fullHeight = imageSize!.height * cos(CGFloat(angleRotation!) * .pi/180) + imageSize!.width * sin(CGFloat(angleRotation!) * .pi/180)
               
            let zoomScale = scrollView.zoomScale
            let xOffset = scrollView.contentOffset.x / zoomScale + horizontalOffsetNew / zoomScale
            let yoffset = scrollView.contentOffset.y / zoomScale + verticalOffsetNew / zoomScale
            
            let pt1 = CGPoint(x: 0, y: imageSize!.height * cos(CGFloat(angleRotation!) * .pi/180))
            let pt2 = CGPoint(x: imageSize!.height * sin(CGFloat(angleRotation!) * .pi/180), y: 0)
            let pt3 = CGPoint(x: fullWidth, y: imageSize!.width * sin(CGFloat(angleRotation!) * .pi/180))
            let pt4 = CGPoint(x: imageSize!.width * cos(CGFloat(angleRotation!) * .pi/180), y: fullHeight)
            
            
            let ptCheck1 = CGPoint(x: xOffset, y: yoffset)
            let ptCheck2 = CGPoint(x: xOffset, y: yoffset + frameHeight!)
            let ptCheck3 = CGPoint(x: xOffset + frameWidth!, y: xOffset + frameHeight!)
            let ptCheck4 = CGPoint(x: xOffset + frameWidth!, y: yoffset)
            
            
            let checkValue1 = ((ptCheck1.x - pt1.x) * (pt2.y - pt1.y)) - ((ptCheck1.y - pt1.y) * (pt2.x - pt1.x))
            
            let checkValue2 = ((ptCheck2.x - pt1.x) * (pt4.y - pt1.y)) - ((ptCheck2.y - pt1.y) * (pt4.x - pt1.x))
            
            let checkValue3 = ((ptCheck3.x - pt3.x) * (pt4.y - pt3.y)) - ((ptCheck3.y - pt3.y) * (pt4.x - pt3.x))
            
            let checkValue4 = ((ptCheck4.x - pt2.x) * (pt3.y - pt2.y)) - ((ptCheck4.y - pt2.y) * (pt3.x - pt2.x))
            
            if checkValue1 > 0 {
                let centerX = scrollView.subviews.first!.frame.size.width/2 - frameWidth!/2
                let centerY = scrollView.subviews.first!.frame.size.height/2 - frameHeight!/2
                let anim = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.5) {
                    scrollView.isScrollEnabled = false
                    scrollView.setContentOffset(CGPoint(x: Int(centerX), y: Int(centerY)), animated: false)
                        scrollView.isScrollEnabled = true
                }
                anim.startAnimation()
            }
            
            if checkValue2 < 0 {
                let centerX = scrollView.subviews.first!.frame.size.width/2 - frameWidth!/2
                let centerY = scrollView.subviews.first!.frame.size.height/2 - frameHeight!/2
                let anim = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.5) {
                    scrollView.isScrollEnabled = false
                    scrollView.setContentOffset(CGPoint(x: Int(centerX), y: Int(centerY)), animated: false)
                        scrollView.isScrollEnabled = true
                }
                anim.startAnimation()
            }
            
            if checkValue3 > 0 {
                let centerX = scrollView.subviews.first!.frame.size.width/2 - frameWidth!/2
                let centerY = scrollView.subviews.first!.frame.size.height/2 - frameHeight!/2
                let anim = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.5) {
                    scrollView.isScrollEnabled = false
                    scrollView.setContentOffset(CGPoint(x: centerX, y: centerY), animated: false)
                        scrollView.isScrollEnabled = true
                }
                anim.startAnimation()
            }
            
            if checkValue4 < 0 {
                let centerX = scrollView.subviews.first!.frame.size.width/2 - frameWidth!/2
                let centerY = scrollView.subviews.first!.frame.size.height/2 - frameHeight!/2
                let anim = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.5) {
                    scrollView.isScrollEnabled = false
                    scrollView.setContentOffset(CGPoint(x: centerX, y: centerY), animated: false)
                        scrollView.isScrollEnabled = true
                }
                anim.startAnimation()
            }
            
            
            */
            
            
            print("zoomScale = \(scrollView.zoomScale)")
            print("xoffset = \(scrollView.contentOffset.x)")
            print("yoffset = \(scrollView.contentOffset.y)")
            print("topSet = \(topSet)")
            print("horizSet = \(horizSet)")
        }
        
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
         
//            let topSet = (Float(frameWidth!) * cos(angleRotation! * .pi/180) * sin(angleRotation! * .pi/180)) - Float(verticalOffset!)
//
//         let horizSet = (Float(frameHeight!) * cos(angleRotation! * .pi/180) * sin(angleRotation! * .pi/180)) - Float(horizontalOffset!)
//
            
            
            
            
            let zoomScale = scrollView.zoomScale
            let xOffset = scrollView.contentOffset.x / zoomScale + horizontalOffsetNew / zoomScale
            let yoffset = scrollView.contentOffset.y / zoomScale + verticalOffsetNew / zoomScale
            
            let pt1 = CGPoint(x: 0, y: imageSize!.height * cos(CGFloat(angleRotation!) * .pi/180))
            let pt2 = CGPoint(x: imageSize!.height * sin(CGFloat(angleRotation!) * .pi/180), y: 0)
            let pt3 = CGPoint(x: newImage!.size.width, y: imageSize!.width * sin(CGFloat(angleRotation!) * .pi/180))
            let pt4 = CGPoint(x: imageSize!.width * cos(CGFloat(angleRotation!) * .pi/180), y: newImage!.size.height)
            
            
            let ptCheck1 = CGPoint(x: xOffset, y: yoffset)
            let ptCheck2 = CGPoint(x: xOffset, y: yoffset + frameHeight!)
            let ptCheck3 = CGPoint(x: xOffset + frameWidth!, y: xOffset + frameHeight!)
            let ptCheck4 = CGPoint(x: xOffset + frameWidth!, y: yoffset)
            
            
            let checkValue1 = ((ptCheck1.x - pt1.x) * (pt2.y - pt1.y)) - ((ptCheck1.y - pt1.y) * (pt2.x - pt1.x))
            
            let checkValue2 = ((ptCheck2.x - pt1.x) * (pt4.y - pt1.y)) - ((ptCheck2.y - pt1.y) * (pt4.x - pt1.x))
            
            let checkValue3 = ((ptCheck3.x - pt3.x) * (pt4.y - pt3.y)) - ((ptCheck3.y - pt3.y) * (pt4.x - pt3.x))
            
            let checkValue4 = ((ptCheck4.x - pt2.x) * (pt3.y - pt2.y)) - ((ptCheck4.y - pt2.y) * (pt3.x - pt2.x))
            
            if checkValue1 > 0 {
                let centerX = scrollView.subviews.first!.frame.size.width/2 - frameWidth!/2
                let centerY = scrollView.subviews.first!.frame.size.height/2 - frameHeight!/2
                let anim = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.5) {
                    scrollView.isScrollEnabled = false
                    scrollView.setContentOffset(CGPoint(x: Int(centerX), y: Int(centerY)), animated: false)
                        scrollView.isScrollEnabled = true
                }
                anim.startAnimation()
            }
            
            if checkValue2 < 0 {
                let centerX = scrollView.subviews.first!.frame.size.width/2 - frameWidth!/2
                let centerY = scrollView.subviews.first!.frame.size.height/2 - frameHeight!/2
                let anim = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.5) {
                    scrollView.isScrollEnabled = false
                    scrollView.setContentOffset(CGPoint(x: Int(centerX), y: Int(centerY)), animated: false)
                        scrollView.isScrollEnabled = true
                }
                anim.startAnimation()
            }
            
            if checkValue3 > 0 {
                let centerX = scrollView.subviews.first!.frame.size.width/2 - frameWidth!/2
                let centerY = scrollView.subviews.first!.frame.size.height/2 - frameHeight!/2
                let anim = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.5) {
                    scrollView.isScrollEnabled = false
                    scrollView.setContentOffset(CGPoint(x: centerX, y: centerY), animated: false)
                        scrollView.isScrollEnabled = true
                }
                anim.startAnimation()
            }
            
            if checkValue4 > 0 {
                let centerX = scrollView.subviews.first!.frame.size.width/2 - frameWidth!/2
                let centerY = scrollView.subviews.first!.frame.size.height/2 - frameHeight!/2
                let anim = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.5) {
                    scrollView.isScrollEnabled = false
                    scrollView.setContentOffset(CGPoint(x: centerX, y: centerY), animated: false)
                        scrollView.isScrollEnabled = true
                }
                anim.startAnimation()
            }
            
            
            
            
            
            
//            if Int(scrollView.contentOffset.y) < Int(topSet) {
//                let anim = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.5) {
//                    scrollView.isScrollEnabled = false
//                    scrollView.setContentOffset(CGPoint(x: Int(scrollView.contentOffset.x), y: Int(topSet)), animated: false)
//                        scrollView.isScrollEnabled = true
//                }
//                anim.startAnimation()
//            }
            
//            if Int(scrollView.contentOffset.x) < Int(horizSet) {
//                let anim = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.5) {
//                    scrollView.isScrollEnabled = false
//                    scrollView.setContentOffset(CGPoint(x: Int(horizSet), y: Int(scrollView.contentOffset.y)), animated: false)
//                        scrollView.isScrollEnabled = true
//                }
//                anim.startAnimation()
//            }
        }
        
        func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
            let zoomScale = scrollView.zoomScale
            let xOffset = scrollView.contentOffset.x / zoomScale + horizontalOffsetNew / zoomScale
            let yoffset = scrollView.contentOffset.y / zoomScale + verticalOffsetNew / zoomScale
            
            let pt1 = CGPoint(x: 0, y: imageSize!.height * cos(CGFloat(angleRotation!) * .pi/180))
            let pt2 = CGPoint(x: imageSize!.height * sin(CGFloat(angleRotation!) * .pi/180), y: 0)
            let pt3 = CGPoint(x: newImage!.size.width, y: imageSize!.width * sin(CGFloat(angleRotation!) * .pi/180))
            let pt4 = CGPoint(x: imageSize!.width * cos(CGFloat(angleRotation!) * .pi/180), y: newImage!.size.height)
            
            
            let ptCheck1 = CGPoint(x: xOffset, y: yoffset)
            let ptCheck2 = CGPoint(x: xOffset, y: yoffset + frameHeight!)
            let ptCheck3 = CGPoint(x: xOffset + frameWidth!, y: xOffset + frameHeight!)
            let ptCheck4 = CGPoint(x: xOffset + frameWidth!, y: yoffset)
            
            
            let checkValue1 = ((ptCheck1.x - pt1.x) * (pt2.y - pt1.y)) - ((ptCheck1.y - pt1.y) * (pt2.x - pt1.x))
            
            let checkValue2 = ((ptCheck2.x - pt1.x) * (pt4.y - pt1.y)) - ((ptCheck2.y - pt1.y) * (pt4.x - pt1.x))
            
            let checkValue3 = ((ptCheck3.x - pt3.x) * (pt4.y - pt3.y)) - ((ptCheck3.y - pt3.y) * (pt4.x - pt3.x))
            
            let checkValue4 = ((ptCheck4.x - pt2.x) * (pt3.y - pt2.y)) - ((ptCheck4.y - pt2.y) * (pt3.x - pt2.x))
            
            if checkValue1 > 0 {
                let centerX = scrollView.subviews.first!.frame.size.width/2 - frameWidth!/2
                let centerY = scrollView.subviews.first!.frame.size.height/2 - frameHeight!/2
                let anim = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.5) {
                    scrollView.isScrollEnabled = false
                    scrollView.setContentOffset(CGPoint(x: Int(centerX), y: Int(centerY)), animated: false)
                        scrollView.isScrollEnabled = true
                }
                anim.startAnimation()
            }
            
            if checkValue2 < 0 {
                let centerX = scrollView.subviews.first!.frame.size.width/2 - frameWidth!/2
                let centerY = scrollView.subviews.first!.frame.size.height/2 - frameHeight!/2
                let anim = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.5) {
                    scrollView.isScrollEnabled = false
                    scrollView.setContentOffset(CGPoint(x: Int(centerX), y: Int(centerY)), animated: false)
                        scrollView.isScrollEnabled = true
                }
                anim.startAnimation()
            }
            
            if checkValue3 > 0 {
                let centerX = scrollView.subviews.first!.frame.size.width/2 - frameWidth!/2
                let centerY = scrollView.subviews.first!.frame.size.height/2 - frameHeight!/2
                let anim = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.5) {
                    scrollView.isScrollEnabled = false
                    scrollView.setContentOffset(CGPoint(x: centerX, y: centerY), animated: false)
                        scrollView.isScrollEnabled = true
                }
                anim.startAnimation()
            }
            
            if checkValue4 > 0 {
                let centerX = scrollView.subviews.first!.frame.size.width/2 - frameWidth!/2
                let centerY = scrollView.subviews.first!.frame.size.height/2 - frameHeight!/2
                let anim = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.5) {
                    scrollView.isScrollEnabled = false
                    scrollView.setContentOffset(CGPoint(x: centerX, y: centerY), animated: false)
                        scrollView.isScrollEnabled = true
                }
                anim.startAnimation()
            }
            
            
        }

    }
}




extension UIImage {
    func rotate(radians: Float) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!

        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        // Draw the image at its center
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}


class RotateHelper: ObservableObject{
    @Published var rotateByAngle: Float = 0
}

/*
class RotateHelperWithFunc: ObservableObject{
    @EnvironmentObject var rotateHelper: RotateHelper
//    init(rotateHelper: RotateHelper){
//        self.rotateHelper = rotateHelper
//        print("Rotate Helper with function Called")
//    }
    
    @objc func handleRotate(_ gesture: UIRotationGestureRecognizer) {
        rotateHelper.rotateByAngle += Float(gesture.rotation)
        print(rotateHelper.rotateByAngle)
    }
}
 */
 
