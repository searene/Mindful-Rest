//
//  StatItemBottomCardContent.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/10.
//

import SwiftUI

struct StatItemOptions: View {
    
    private let dismissHandler: () -> Void;
    private let deleteHandler: () -> Void;
    
    init(dismissHandler: @escaping () -> Void,
         deleteHandler: @escaping () -> Void) {
        self.dismissHandler = dismissHandler
        self.deleteHandler = deleteHandler
    }
    
    var body: some View {
        VStack {
            Button("Modify", action: {})
                .frame(maxWidth: .infinity)
                .padding()
            
            Button("Delete", role: .destructive, action: {
                self.deleteHandler()
            })
                .frame(maxWidth: .infinity)
                .padding()
            
            Divider()
            
            Button("Cancel", action: {
                self.dismissHandler()
            })
                .frame(maxWidth: .infinity)
                .padding()
        }
    }
}

struct StatItemOptions_Previews: PreviewProvider {
    static var previews: some View {
        StatItemOptions(dismissHandler: {}, deleteHandler: {})
    }
}
