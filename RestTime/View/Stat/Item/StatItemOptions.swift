//
//  StatItemBottomCardContent.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/10.
//

import SwiftUI

struct StatItemOptions: View {
    var body: some View {
        VStack {
            Button("Modify", action: {})
                .frame(maxWidth: .infinity)
                .padding()
            
            Button("Delete", role: .destructive, action: {})
                .frame(maxWidth: .infinity)
                .padding()
            
            Divider()
            
            Button("Cancel", action: {})
                .frame(maxWidth: .infinity)
                .padding()
        }
    }
}

struct StatItemOptions_Previews: PreviewProvider {
    static var previews: some View {
        StatItemOptions()
    }
}
