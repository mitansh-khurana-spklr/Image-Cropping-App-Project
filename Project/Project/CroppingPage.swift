//
//  CroppingPage.swift
//  Project
//
//  Created by Mitansh Khurana on 14/06/22.
//

import SwiftUI

var croppedImage = UIImage()
var finalImage = UIImage()
var croppingWidth: CGFloat = 350
var croppingHeight: CGFloat = 350
var aspectRatioList: [[CGFloat]] = [[1,1], [4,5], [4,3], [3,2], [16, 9], [2, 1]]

//[[], 4/5, 4/3, 3/2, 16/9, 2/1]

struct CroppingPage: View {
    
    @State var uiImage = UIImage(named: "Landscape")!
    @State private var isShowPhotoLibrary = false
    
    @State var viewState = CGSize.zero
    
    
    @State var frameWidth : CGFloat = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height/2)
    @State var frameHeight : CGFloat = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height/2)
    @State var aspectRatio: CGFloat = 1
    @State var portrait: Bool = true
    
    @State var horizontalOffset = CGFloat(0)
    @State var verticalOffset = CGFloat(0)
    
    
    var body: some View {
        
        GeometryReader{ totalGeometry in
            
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.vertical)
                
                VStack{
                    HStack{
                        Button(action: {}) {
                            Image(systemName: "pencil.slash")
                                .foregroundColor(.white)
                                .font(.title)
                            
                        }
                        .padding(.leading)
                        
                        Spacer()
                        
                        Text("Crop Image")
                            .foregroundColor(.white)
                            .font(.title3)
                        
                        Spacer()
                        
                        
                        
                        Button(action: {
                            croppedImage = uiImage
                            croppingWidth = frameWidth
                            croppingHeight = frameHeight
                            
                            finalImage = ZoomableView.crop(uiImage: croppedImage, width: croppingWidth, height: croppingHeight)
                            UIImageWriteToSavedPhotosAlbum(finalImage, nil, nil, nil)
                            
                        }) {
                            Text("Next")
                                .foregroundColor(.blue)
                                .fontWeight(.semibold)
                                .font(.title3)
                        }
                    }
                    .padding(.trailing)
                    
            
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    
                    Group{
                         ZStack {
                             GeometryReader { geometry in
                                 ZoomableView(uiImage: $uiImage, viewSize: geometry.size, frameWidth: $frameWidth, frameHeight: $frameHeight)
                             }
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
                        
                        
                     }
                    
                    
                    Spacer()
                    Spacer()
                    
                    
                    VStack{
                        
                        HStack {
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
                        }
                        .padding(.bottom)
    //
                        
                        
                        
                        ScrollView(.horizontal){
                            HStack{
                                ForEach(aspectRatioList, id:\.self){aspect in
                                        
                                    Button(action: {
                                            
                                    withAnimation(.default){
                                            aspectRatio = aspect[0]/aspect[1]
                                                
                                            if(aspectRatio >= 1){
                                                if(aspectRatio == 1){
                                                        frameWidth =  min(totalGeometry.size.width, totalGeometry.size.height/2)
                                            }
                                                else{
                                                    frameWidth = totalGeometry.size.width
                                                    }
                                                    frameHeight = frameWidth/aspectRatio
                                                    portrait = false
                                                }
                                            else{
                                                frameHeight = min(totalGeometry.size.width, totalGeometry.size.height/2)
                                                frameWidth = frameHeight * aspectRatio
                                                    portrait = true
                                                }
                                                
                                            verticalOffset = (totalGeometry.size.height - frameHeight)/2
                                                
                                            horizontalOffset = (totalGeometry.size.width - frameWidth)/2
                                            }
                                            
                                    }) {
                                        Text("\(Int(aspect[0])) : \(Int(aspect[1]))")
                                            .foregroundColor(.white)
                                            .fontWeight(.semibold)
                                            .font(.title3)
                                            .frame(width: 90, height: 60)
                                            .background(Color(red: 0.105, green: 0.105, blue: 0.105, opacity: 1.0))
                                            .cornerRadius(10)
                                        }
    //                                    .padding()
                                }
                            }
                            .frame(minWidth: UIScreen.main.bounds.size.width)
                        }
                        
                            
                        

                        
                        
                        
                        Text("Select Aspect Ratio")
                            .foregroundColor(.white)
                            .font(.title3)
                            .padding(.top)
                            
                    }
                    
                    
                    Group {
                        Spacer()
                            .frame(height: 40)
                        
                        
                        Button(action: {
                            self.isShowPhotoLibrary = true
                        }) {
                            HStack {
                                Image(systemName: "photo")
                                    .font(.system(size: 20))

                                Text("Select Image")
                                    .font(.headline)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .sheet(isPresented: $isShowPhotoLibrary) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: $uiImage)
            }
            
        }
        
    }
}

struct CroppingPage_Previews: PreviewProvider {
    static var previews: some View {
        CroppingPage()
    }
}
