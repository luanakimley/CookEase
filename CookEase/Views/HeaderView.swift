//
//  HeaderView.swift
//  CookEase
//
//  Created by Luana Kimley on 28/02/2024.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 0).foregroundColor(Color.yellow)
            
            VStack {
                HStack(spacing: 10) {
                    Image(systemName: "fork.knife.circle").resizable()
                        .frame(width: 30, height: 30).foregroundStyle(.black)
                    Text("CookEase").font(.system(size: 45)).bold().foregroundStyle(.black)
                }
                Text("Where cooking becomes a breeze").foregroundStyle(.black)
            }
            
        }.frame(height: 200)
    }
}

#Preview {
    HeaderView()
}
