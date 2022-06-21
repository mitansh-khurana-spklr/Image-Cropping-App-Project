//
//  CroppingPage.swift
//  Project
//
//  Created by Mitansh Khurana on 14/06/22.
//





//  OldCroppingPage.swift
//  Project
//
//  Created by Mitansh Khurana on 18/06/22.
//

import Foundation



import SwiftUI

var croppedImage = UIImage()
var finalImageCropped = UIImage()
var croppingWidth: CGFloat = 350
var croppingHeight: CGFloat = 350
var aspectRatioListHorizontal: [[CGFloat]] = [[1,1], [5,4], [4,3], [3,2], [16, 9], [2, 1]]
var aspectRatioListVertical: [[CGFloat]] = [[1,1], [4,5], [3,4], [2,3], [9,16], [1,2]]

//[[], 4/5, 4/3, 3/2, 16/9, 2/1]

struct CroppingPage: View {
    
    @Binding var uiImage: UIImage
    @Binding var isCropped: Bool
    @Binding var imageToShow: UIImage
    
    @State var viewState = CGSize.zero
    
    @State var rotation : Float = 0.0
    
    @State var rotateState: Float = 0
    
    
    
    @State var frameWidth : CGFloat = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height/2)
    @State var frameHeight : CGFloat = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height/2)
    
    
    @State var aspectRatio: CGFloat = 1
    @State var aspectRatioSize: CGSize = CGSize(width: 1, height: 1)
    
    
    @State var portrait: Bool = true
    
    @State var horizontalOffset = CGFloat(0)
    @State var verticalOffset = CGFloat(0)
    
    
    
    @EnvironmentObject var rotateHelper: RotateHelper
    
    @State var alignment: String = "Horiontal"
    @State var aspectRatioList: [[CGFloat]] = [[1,1], [5,4], [4,3], [3,2], [16, 9], [2, 1]]
    
//    @State var isShowingFilterView = false
    
//    @State var rotatedBoxWidth: CGFloat
//    @State var rotatedBoxHeight: CGFloat
    
    
    var body: some View {
        
        GeometryReader{ totalGeometry in
            
                ZStack {
                    Color.black
                        .edgesIgnoringSafeArea(.vertical)
                    
                    VStack{                        
                        Group{
                             ZStack {
                                 GeometryReader { geometry in
                                     ZoomableView(uiImage: $uiImage, viewSize: geometry.size, frameWidth: $frameWidth, frameHeight: $frameHeight, rotation: $rotation, aspectRatioSize: $aspectRatioSize)
                                 }

                                 ZStack {
                                     Rectangle()
                                         .opacity(0.01)
                                         .allowsHitTesting(false)
                                         .frame(width: frameWidth, height: frameHeight)
                                     .border(.white, width: 3)
                                     
                                     Rectangle()
                                         .allowsHitTesting(false)
                                         .opacity(0.01)
                                         .frame(width: frameWidth, height: frameHeight/3)
                                         .border(.white, width: 0.75)
                                     
                                     Rectangle()
                                         .allowsHitTesting(false)
                                         .opacity(0.01)
                                         .frame(width: frameWidth/3, height: frameHeight)
                                         .border(.white, width: 0.75)
                                 }
                                 
    //                             Image(systemName: "arrow.up.left.and.arrow.down.right")
    //                                 .font(.system(size: 20))
    //                                 .background(Circle().frame(width: 25, height: 25).foregroundColor(.white))
    //                                 .frame(width: frameWidth, height: frameHeight, alignment: .topLeading)
    //                                 .foregroundColor(.black)
    //                                 .offset(x: -5, y: -5)
    //                                 .gesture(DragGesture()
    //                                    .onChanged{drag in
    //                                        frameWidth -= drag.translation.width
    //                                        frameHeight -= drag.translation.height
    //
    //                                    })
                             }
                             .navigationBarItems(
                                trailing:
                                    Button(action: {
                                        let CGrotation = CGFloat(rotateHelper.rotateByAngle)
                                        let radians = CGrotation * Double.pi/180
                                        let newImage = uiImage.rotate(radians: Float(radians))
                                        croppedImage = newImage!
                                        croppingWidth = frameWidth
                                        croppingHeight = frameHeight

                                        finalImageCropped = ZoomableView.crop(uiImage: croppedImage, width: croppingWidth, height: croppingHeight)
                                        UIImageWriteToSavedPhotosAlbum(finalImageCropped, nil, nil, nil)

                                    }) {
                                        Text("Next")
                                            .foregroundColor(.blue)
//                                            .fontWeight(.semibold)
//                                            .font(.title3)
                                    }
                             )
                         }
                        
                        
                        
                        Group{
                            Spacer()
                            Spacer()
                            
                        }
                        
                        AspectRatioAndRotateView(aspectRatio: $aspectRatio, aspectRatioSize: $aspectRatioSize, portrait: $portrait, aspectRatioList: $aspectRatioList, alignment: $alignment, frameWidth: $frameWidth, frameHeight: $frameHeight, verticalOffset: $verticalOffset, horizontalOffset: $horizontalOffset, totalGeometry: totalGeometry)
                        
                    }
                }
        }
        
    }
}

//struct CroppingPage_Previews: PreviewProvider {
//    static var previews: some View {
//        CroppingPage(uiImage: .constant(UIImage(named: "Landscape")!))
//    }
//}
























