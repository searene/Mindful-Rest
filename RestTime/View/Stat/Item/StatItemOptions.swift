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
    private let modifyHandler: () -> Void;
    
    init(dismissHandler: @escaping () -> Void,
         deleteHandler: @escaping () -> Void,
         modifyHandler: @escaping () -> Void) {
        self.dismissHandler = dismissHandler
        self.deleteHandler = deleteHandler
        self.modifyHandler = modifyHandler
    }
    
    var body: some View {
        VStack {
            Button("Modify", action: {
                self.dismissHandler()
                self.modifyHandler()
            })
                .frame(maxWidth: .infinity)
                .padding()
            
            Button("Delete", role: .destructive, action: {
                self.deleteHandler()
                self.dismissHandler()
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
        StatItemOptions(dismissHandler: {}, deleteHandler: {}, modifyHandler: {})
    }
}
