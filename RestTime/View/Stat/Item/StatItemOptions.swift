//
//  StatItemOptions.swift
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
            Button(action: {
                self.dismissHandler()
                self.modifyHandler()
            }) {
                Text("Modify")
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            
            Button(action: {
                self.deleteHandler()
                self.dismissHandler()
            }) {
                Text("Delete")
                    .foregroundColor(Color.red)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            
            Divider()
            
            Button(action: {
                self.dismissHandler()
            }) {
                Text("Cancel")
                    .frame(maxWidth: .infinity)
                    .padding()
            }
        }
    }
}

struct StatItemOptions_Previews: PreviewProvider {
    static var previews: some View {
        StatItemOptions(dismissHandler: {}, deleteHandler: {}, modifyHandler: {})
    }
}
