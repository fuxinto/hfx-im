//
//  ContentView.swift
//  FXSwitUIDemo
//
//  Created by 湘 zhou on 2021/3/30.
//

import SwiftUI

struct FXShowTextView: View {
    @State var text:String
    var body: some View {
        Text(text)
            .font(.subheadline)
            .padding()
            .background(Color.gray)
            .cornerRadius(8)
            .padding()
    }
}


