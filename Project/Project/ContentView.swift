//
//  ContentView.swift
//  Project
//
//  Created by Mitansh Khurana on 14/06/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var rotateHelper = RotateHelper()
    var body: some View {
        SelectImageView()
            .environmentObject(rotateHelper)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
