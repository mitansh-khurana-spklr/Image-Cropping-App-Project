//
//  OldCroppingPage.swift
//  Project
//
//  Created by Mitansh Khurana on 18/06/22.
//

import Foundation

/*

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
    
    @State var viewState = CGSize.zero
    
    @State var rotation : Float = 0.0
    
    
    
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
    
    @State var isShowingFilterView = false
    
//    @State var rotatedBoxWidth: CGFloat
//    @State var rotatedBoxHeight: CGFloat
    
    
    var body: some View {
        
        GeometryReader{ totalGeometry in
            
                ZStack {
                    Color.black
                        .edgesIgnoringSafeArea(.vertical)
                    
                    VStack{
//                        HStack{
//                            Button(action: {}) {
//                                Image(systemName: "pencil.slash")
//                                    .foregroundColor(.white)
//                                    .font(.title)
//
//                            }
//                            .padding(.leading)
//
//                            Spacer()
//
//                            Text("Crop Image")
//                                .foregroundColor(.white)
//                                .font(.title3)
//
//                            Spacer()
//
//
//
//                            Button(action: {
//                                let CGrotation = CGFloat(rotateHelper.rotateByAngle)
//                                let radians = CGrotation * Double.pi/180
//                                let newImage = uiImage.rotate(radians: Float(radians))
//                                croppedImage = newImage!
//                                croppingWidth = frameWidth
//                                croppingHeight = frameHeight
//
//                                finalImageCropped = ZoomableView.crop(uiImage: croppedImage, width: croppingWidth, height: croppingHeight)
//                                UIImageWriteToSavedPhotosAlbum(finalImageCropped, nil, nil, nil)
//
//                            }) {
//                                Text("Next")
//                                    .foregroundColor(.blue)
//                                    .fontWeight(.semibold)
//                                    .font(.title3)
//                            }
//                        }
//                        .padding(.trailing)
//                        .navigationBarTitleDisplayMode(.inline)
//                        .toolbar {
//                            ToolbarItem(placement: .principal) {
//                                HStack {
//                                        Text("Crop Image")
//                                            .font(.headline)
//                                            .foregroundColor(.white)
//
//                                        }
//                                    }
//
//                                }
                        
                
//                        Spacer()
//                        Spacer()
//                        Spacer()
//                        Spacer()
                        
                        Group{
                             ZStack {
                                 GeometryReader { geometry in
                                     ZoomableView(uiImage: $uiImage, viewSize: geometry.size, frameWidth: $frameWidth, frameHeight: $frameHeight, rotation: $rotation, aspectRatioSize: $aspectRatioSize)
                                 }
    //                             .gesture(RotationGesture().onChanged{angle in
    //                                 rotation += Float(angle.degrees)
    //                             })
    //                             .rotationEffect(.degrees(rotation))
    //                             .frame(width: frameWidth, height: frameHeight)
    //                             .border(.white)
                                 
                                 
                                 
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
                            
                            Slider(value: $rotateHelper.rotateByAngle, in: 0...360)
                            
                         }
                        
                        
                        
                        
                        Spacer()
                        Spacer()
                        
                        
                        VStack{
                            
                            HStack {
                                /*
                                Button(action: {
                                
                                    withAnimation(.default){
                                        if aspectRatio > 1 {
                                            aspectRatio = 1 / aspectRatio
                                            frameHeight = min(totalGeometry.size.width, totalGeometry.size.height/2)
                                            frameWidth = frameHeight * aspectRatio
                                            
                                            verticalOffset = (totalGeometry.size.height - frameHeight)/2
                                            
                                            horizontalOffset = (totalGeometry.size.width - frameWidth)/2
                                            
                                        }
                                        portrait = true
                                    }
                                    
                                }) {
                                    Image(systemName: "rectangle.portrait")
                                }
                                .foregroundColor(portrait ? .yellow: .white)
                                .font(.title)
                                
                                Button(action: {
                                    
                                    withAnimation(.default) {
                                        if aspectRatio < 1{
                                            aspectRatio = 1 / aspectRatio
                                            frameWidth = totalGeometry.size.width
                                            frameHeight = frameWidth/aspectRatio
                                            
                                            verticalOffset = (totalGeometry.size.height - frameHeight)/2
                                            
                                            horizontalOffset = (totalGeometry.size.width - frameWidth)/2
                                            
                                        }
                                        portrait = false
                                    }
                                    
                                }) {
                                    Image(systemName: "rectangle")
                                }
                                .foregroundColor(portrait ? .white: .yellow)
                                .font(.title)
                                
                                */
                                
                                Button(action: {
                                    withAnimation(.default) {
                                        if rotateHelper.rotateByAngle < 90{
                                            rotateHelper.rotateByAngle = 90
                                        }
                                        else if rotateHelper.rotateByAngle < 180 {
                                            rotateHelper.rotateByAngle = 180
                                        }
                                        else if rotateHelper.rotateByAngle < 270 {
                                            rotateHelper.rotateByAngle = 270
                                        }
                                        else{
                                            rotateHelper.rotateByAngle = 0
                                        }
                                    }
                                    
                                }) {
                                    Image(systemName: "rotate.right")
                                        .foregroundColor(.white)
                                        .font(.title)
                                        .offset(y: -5)
                                }
                                
                                
                                Button(action: {
                                    isShowingFilterView = true
                                }) {
                                    Image(systemName: "camera.filters")
                                        .foregroundColor(.white)
                                        .font(.title)
                                        .offset(y: -5)
                                }
                            }
                            .padding(.bottom)
        //
                            
                            NavigationLink(destination: InbuiltFilterView(), isActive: $isShowingFilterView) {
                                EmptyView()
                                    
                            }
                            
                            
                            HStack {
                                
                                if(alignment == "Horizontal"){
                                    Button(action: {
                                        alignment = "Vertical"
                                        aspectRatioList = aspectRatioListVertical
                                    }) {
                                        VStack {
                                            ZStack {
                                                Rectangle()
                                                    .frame(width: 30, height: 20)
                                                    .opacity(0.6)
                                                    .border(.white, width: 2)
                                                    .padding(.bottom, 6)
                                                .foregroundColor(.white)
                                            }
                                                
//                                            Spacer()
                                            
                                            Text("Horizontal")
                                                .foregroundColor(.white)
                                                .fontWeight(.semibold)
                                                .font(.title3)
                                        }
                                        .frame(width: 110, height: 100)
                                        .background(Color(red: 15/255, green: 15/255, blue: 15/255, opacity: 1.0))
                                        .cornerRadius(10)
                                    }
                                }
                                else{
                                    Button(action: {
                                        alignment = "Horizontal"
                                        aspectRatioList = aspectRatioListHorizontal
                                    }) {
                                        VStack {
                                            ZStack {
                                                Rectangle()
                                                    .frame(width: 20, height: 30)
                                                    .opacity(0.6)
                                                    .border(.white, width: 2)
                                                    .padding(.bottom, 6)
                                                .foregroundColor(.white)
                                            }
                                                
//                                            Spacer()
                                            
                                            Text("Vertical")
                                                .foregroundColor(.white)
                                                .fontWeight(.semibold)
                                                .font(.title3)
                                        }
                                        .frame(width: 110, height: 100)
                                        .background(Color(red: 15/255, green: 15/255, blue: 15/255, opacity: 1.0))
                                        .cornerRadius(10)
                                    }
                                }
                                
                                ScrollView(.horizontal){
                                    HStack{
                                        if(alignment == "Horizontal"){
                                            ForEach(aspectRatioListHorizontal, id:\.self){aspect in
                                                    
                                                Button(action: {
                                                        
                                                withAnimation(.default){
                                                        aspectRatio = aspect[0]/aspect[1]
                                                    aspectRatioSize.width = aspect[0]
                                                    aspectRatioSize.height = aspect[1]
                                                            
                                                        
                                                        if(aspectRatio == 1){
                                                            frameWidth =  min(totalGeometry.size.width, totalGeometry.size.height/2)
                                                        }
                                                        else{
                                                            frameWidth = totalGeometry.size.width
                                                        }
                                                        frameHeight = frameWidth/aspectRatio
                                                        portrait = false
                                                            
                                                            
                                                        verticalOffset = (totalGeometry.size.height - frameHeight)/2
                                                            
                                                        horizontalOffset = (totalGeometry.size.width - frameWidth)/2
                                                        }
                                                        
                                                }) {
                                                    VStack {
                                                        
                                                        ZStack {
                                                            Rectangle()
                                                                .frame(width: 30, height: 30*aspect[1]/aspect[0])
                                                                .opacity(0.6)
                                                                .border(.white, width: 2)
                                                                .padding(.bottom, 6)
                                                            .foregroundColor(.white)
                                                        }
                                                            
            //                                            Spacer()
                                                        
                                                        Text("\(Int(aspect[0])) : \(Int(aspect[1]))")
                                                            .foregroundColor(.white)
                                                            .fontWeight(.semibold)
                                                            .font(.title3)
                                                    }
                                                    .frame(width: 110, height: 100)
                                                    .background(Color(red: 15/255, green: 15/255, blue: 15/255, opacity: 1.0))
                                                    .cornerRadius(10)
                                                }
                //                                    .padding()
                                            }
                                        }
                                        else{
                                            ForEach(aspectRatioListVertical, id:\.self){aspect in
                                                    
                                                Button(action: {
                                                        
                                                withAnimation(.default){
                                                        aspectRatio = aspect[0]/aspect[1]
                                                    aspectRatioSize.width = aspect[0]
                                                    aspectRatioSize.height = aspect[1]
                                                            
        
                                                        frameHeight = min(totalGeometry.size.width, totalGeometry.size.height/2)
                                                            frameWidth = frameHeight * aspectRatio
                                                        portrait = true
                                                        
                                                        verticalOffset = (totalGeometry.size.height - frameHeight)/2
                                                            
                                                        horizontalOffset = (totalGeometry.size.width - frameWidth)/2
                                                        }
                                                        
                                                }) {
                                                    VStack {
                                                        
                                                        ZStack {
                                                            Rectangle()
                                                                .frame(width: 30*aspect[0]/aspect[1], height: 30)
                                                                .opacity(0.6)
                                                                .border(.white, width: 2)
                                                                .padding(.bottom, 6)
                                                            .foregroundColor(.white)
                                                        }
                                                            
            //                                            Spacer()
                                                        
                                                        Text("\(Int(aspect[0])) : \(Int(aspect[1]))")
                                                            .foregroundColor(.white)
                                                            .fontWeight(.semibold)
                                                            .font(.title3)
                                                    }
                                                    .frame(width: 110, height: 100)
                                                    .background(Color(red: 15/255, green: 15/255, blue: 15/255, opacity: 1.0))
                                                    .cornerRadius(10)
                                                }
                //                                    .padding()
                                            }
                                        }
                                        
                                    }
                                    .frame(minWidth: UIScreen.main.bounds.size.width)
                                    .padding(.horizontal)
                                }
                            }
                            .padding([.vertical, .horizontal])
                            .background(Color(red: 30/255, green: 30/255, blue: 30/255, opacity: 1.0))
                            .frame(height: 150)
                        }
                        
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

*/

