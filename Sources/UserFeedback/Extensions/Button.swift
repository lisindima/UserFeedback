//
//  Button.swift
//  
//
//  Created by Дмитрий Лисин on 14.11.2020.
//

import SwiftUI

struct SendButton: View {
    var title: String
    var loading: Bool = false
    var colorButton: Color = .accentColor
    var colorText: Color = .white
    var action: () -> Void
    
    var body: some View {
        #if os(iOS)
        phone
        #else
        watch
        #endif
    }
    
    var watch: some View {
        Button(action: action) {
            if loading {
                ProgressView()
            } else {
                Text(title)
            }
        }
    }
    
    var phone: some View {
        Button(action: action) {
            if loading {
                ProgressView()
                    .padding()
            } else {
                HStack {
                    Spacer()
                    Text(title)
                        .fontWeight(.bold)
                        .foregroundColor(colorText)
                    Spacer()
                }.padding()
            }
        }
        .disabled(loading)
        .background(colorButton)
        .cornerRadius(8)
    }
}
