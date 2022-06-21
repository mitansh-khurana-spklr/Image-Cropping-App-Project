//
//  AspectRatioAndRotateView.swift
//  Project
//
//  Created by Mitansh Khurana on 21/06/22.
//

import SwiftUI
import Foundation

struct AspectRatioAndRotateView: View {
    
    
    @Binding var aspectRatio: CGFloat
    @Binding var aspectRatioSize: CGSize
    @Binding var portrait: Bool
    @Binding var aspectRatioList: [[CGFloat]]
    @Binding var alignment: String
    @Binding var frameWidth: CGFloat
    @Binding var frameHeight: CGFloat
    @Binding var verticalOffset: CGFloat
    @Binding var horizontalOffset: CGFloat
    
    var totalGeometry: GeometryProxy
    
    
    @State var prevRot: CGFloat = 0
    @EnvironmentObject var rotateHelper: RotateHelper
    
    
    var body: some View {
        VStack{
            
            HStack {
                
                if(alignment == "Horizontal"){
                    Button(action: {
                        alignment = "Vertical"
                        aspectRatioList = aspectRatioListVertical
                    }) {
                        
//                                            ZStack {
//                                                Rectangle()
//                                                    .frame(width: 20, height: 14)
//                                                    .opacity(0.6)
//                                                    .border(.white, width: 2)
//                                                    .padding(.bottom, 6)
//                                                .foregroundColor(.white)
//                                            }
                                
//                                            Spacer()
                            
                        Image(systemName: "rectangle")
                            .foregroundColor(.white)
                                .font(.title)
                        
//                                        .frame(width: 80, height: 70)
//                                        .background(Color(red: 15/255, green: 15/255, blue: 15/255, opacity: 1.0))
//                                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                else{
                    Button(action: {
                        alignment = "Horizontal"
                        aspectRatioList = aspectRatioListHorizontal
                    }) {
                        VStack {
//                                            ZStack {
//                                                Rectangle()
//                                                    .frame(width: 14, height: 20)
//                                                    .opacity(0.6)
//                                                    .border(.white, width: 2)
//                                                    .padding(.bottom, 6)
//                                                .foregroundColor(.white)
//                                            }
//
//                                            Spacer()
                            
                            Image(systemName: "rectangle.portrait")
                                .foregroundColor(.white)
                                .font(.title)
                        }
//                                        .frame(width: 80, height: 70)
//                                        .background(Color(red: 15/255, green: 15/255, blue: 15/255, opacity: 1.0))
//                                        .cornerRadius(10)
                        
                    }
                    .padding(.horizontal)
                }
                    

                
                VStack {
                    
                    Text("\((rotateHelper.rotateByAngle * 100).rounded()/100)")
                        .font(.body)
                        .foregroundColor(.white)
                    
                    Slider(value: $rotateHelper.rotateByAngle, in: 0...360)
                        .padding(.horizontal)
                }
                    
                
                
                
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
                .padding(.horizontal)
                
                /*
                Button(action: {
                    let CGrotation = CGFloat(rotateHelper.rotateByAngle)
                    let radians = CGrotation * Double.pi/180
                    let newImage = uiImage.rotate(radians: Float(radians))
                    croppedImage = newImage!
                    croppingWidth = frameWidth
                    croppingHeight = frameHeight

                    finalImageCropped = ZoomableView.crop(uiImage: croppedImage, width: croppingWidth, height: croppingHeight)
                    
                    imageToShow = finalImageCropped
                    isCropped = true
//                                    isShowingFilterView = true
                }) {
                    Image(systemName: "crop")
                        .foregroundColor(.white)
                        .font(.title)
                }
                 */
            }
            .padding(.vertical)
            

            
            HStack {
                ScrollView(.horizontal, showsIndicators: false){
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
                                        
                                        /*
                                        Rectangle()
                                            .frame(width: 20, height: 20*aspect[1]/aspect[0])
                                            .opacity(0.6)
                                            .border(.white, width: 2)
                                            .padding(.bottom, 6)
                                            .foregroundColor(.white)
                                        */
                                        
                                        
                                        Text("\(Int(aspect[0])) : \(Int(aspect[1]))")
                                            .foregroundColor(.white)
                                            .font(.body)
                                    }
                                    .frame(width: 50, height: 30)
                                    .background(aspectRatio == aspect[0]/aspect[1] ? Color(red: 15/255, green: 15/255, blue: 15/255, opacity: 1.0) : nil)
                                    .cornerRadius(10)
//                                                    .padding(.horizontal)
//                                                    .overlay(aspectRatio == aspect[0]/aspect[1] ? RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2) : nil)
                                }
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
                                        
                                        
//                                                        Rectangle()
//                                                            .frame(width: 20*aspect[0]/aspect[1], height: 20)
//                                                            .opacity(0.6)
//                                                            .border(.white, width: 2)
//                                                            .padding(.bottom, 6)
//                                                            .foregroundColor(.white)
//
                                            
                                        
                                        Text("\(Int(aspect[0])) : \(Int(aspect[1]))")
                                            .foregroundColor(.white)
                                            .font(.body)
                                    }
                                    .frame(width: 50, height: 30)
                                    .background(aspectRatio == aspect[0]/aspect[1] ? Color(red: 15/255, green: 15/255, blue: 15/255, opacity: 1.0) : nil)
                                    .cornerRadius(10)
//                                                    .padding(.horizontal)
//                                                    .overlay(aspectRatio == aspect[0]/aspect[1] ? RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2) : nil)
                                
                                }
                            }
                        }
                        
                    }
                    .frame(minWidth: UIScreen.main.bounds.size.width)
                    .padding(.horizontal)
                }
                
            }
            .padding([.vertical, .horizontal])
            .frame(height: 40)
        }
        .background(Color(red: 30/255, green: 30/255, blue: 30/255, opacity: 1.0))
    }
}

//struct AspectRatioAndRotateView_Previews: PreviewProvider {
//    static var previews: some View {
//        AspectRatioAndRotateView()
//    }
//}
