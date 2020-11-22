//
//  View+Helper.swift
//  TapToSnap
//
//  Created by Mohammad Kamar Shad on 10/31/20.
//  Copyright © 2020 MKS. All rights reserved.
//

import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, content: (Self) -> Content) -> some View {
        if condition {
            content(self)
        }
        else {
            self
        }
    }
}
