//
//  InbuiltFilterView.swift
//  Project
//
//  Created by Mitansh Khurana on 18/06/22.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct InbuiltFilterView: View {
    @State private var currentFilter = CIFilter(name: "CISepiaTone")
    let context = CIContext()
//    @Binding var uiImage : UIImage
    @State var uiImageShow = finalImageCropped
    @State var filterIntensity: Float = 0
    @State var currImage: UIImage = UIImage()
    @State var showingSepia = true
    
    
    
    func applyProcessing() {
        currentFilter?.setValue(filterIntensity, forKey: kCIInputIntensityKey)

        guard let outputImage = currentFilter?.outputImage else { return }

        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            uiImageShow = UIImage(cgImage: cgimg)
        }
    }
    
    func loadImage() {
        let inputImage = finalImageCropped

        let beginImage = CIImage(image: inputImage)
        currentFilter?.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func imageWithImage(source: UIImage, rotatedByHue: CGFloat) -> UIImage {
        // Create a Core Image version of the image.
        let sourceCore = CIImage(image: source)
        // Apply a CIHueAdjust filter
        let hueAdjust = CIFilter(name: "CIHueAdjust")
        hueAdjust!.setDefaults()
        hueAdjust!.setValue(sourceCore, forKey: "inputImage")
        hueAdjust!.setValue(CGFloat(rotatedByHue), forKey: "inputAngle")
        let resultCore  = hueAdjust!.value(forKey: "outputImage") as! CIImage?
        let context = CIContext(options: nil)
        let resultRef = context.createCGImage(resultCore!, from: resultCore!.extent)
        let result = UIImage(cgImage: resultRef!)
        return result
    }

    
    var body: some View {
        ZStack {
            
            Color.black
                .edgesIgnoringSafeArea(.vertical)
            
            VStack {
                Spacer()
                if(showingSepia){
                    Image(uiImage: uiImageShow)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                }
                else{
                    Image(uiImage: currImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                }
                
                    
                Spacer()
                
            
                Slider(value: $filterIntensity)
                    .onChange(of: filterIntensity) { newValue in
                        loadImage()
                        currImage = imageWithImage(source: finalImageCropped, rotatedByHue: .pi)
                    }
                    .padding()
                    .onAppear{
                        uiImageShow = finalImageCropped
                    }
                
                Spacer()
                
                
                    HStack{
                        Button(action: {
                            currentFilter = CIFilter.sepiaTone()
                            showingSepia = true
                        }) {
                            Text("Sepia")
                                .foregroundColor(.white)
                        }
                        
                        Button(action: {
                            currImage = imageWithImage(source: finalImageCropped, rotatedByHue: .pi)
                            showingSepia = false
                            
                        }) {
                            Text("Hue")
                                .foregroundColor(.white)
                        }
                        
                    }
                    .padding()
                
                
                Spacer()
                
            }
        }
    }
}

//struct InbuiltFilterView_Previews: PreviewProvider {
//    static var previews: some View {
//        InbuiltFilterView()
//    }
//}
