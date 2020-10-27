//
//  View.swift
//  
//
//  Created by Дмитрий Лисин on 26.10.2020.
//

import SwiftUI

public extension View {
    func userFeedback(isPresented: Binding<Bool>) -> some View {
        modifier(UserFeedbackModifier(isPresented: isPresented))
    }
}
