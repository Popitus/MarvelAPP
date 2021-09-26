//
//  LoadingView.swift
//  MarvelMulti (iOS)
//
//  Created by MacAMD on 24/9/21.
//

import SwiftUI

struct LoadingView: View {
    @State private var animate = false
    @State var texto: String = ""
    
    var body: some View {
        VStack{
            Circle()
                .fill(Color.red)
                .frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .scaleEffect(animate ? 1.0 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever())
            Text("Buscando \(texto)...")
                .foregroundColor(Color.gray)
                .bold()
        }
        .onAppear{
            self.animate = true
        }
        .onDisappear{
            self.animate = false
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
