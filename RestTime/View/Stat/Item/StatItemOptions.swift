//
//  StatItemOptions.swift
//  RestTime
//
//  Created by Joey Green on 2022/4/10.
//

import SwiftUI

struct StatItemOptions: View {
    
    private let dismissHandler: () -> Void
    private let deleteHandler: () -> Void
    private let modifyHandler: () -> Void
    @State private var showDeleteAlert = false
    
    private let MODIFY: LocalizedStringKey = "Modify"
    private let DELETE: LocalizedStringKey = "Delete"
    private let CANCEL: LocalizedStringKey = "Cancel"
    private let DELETE_PROMPT: LocalizedStringKey = "This will delete the current record."
    
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
                withAnimation {
                    self.dismissHandler()
                    self.modifyHandler()
                }
            }) {
                Text(MODIFY)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            
            Button(action: {
                showDeleteAlert = true
            }) {
                Text(DELETE)
                    .foregroundColor(Color.red)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            
            Divider()
            
            Button(action: {
                self.dismissHandler()
            }) {
                Text(CANCEL)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
        }
        .alert(isPresented: $showDeleteAlert) {
            Alert(
                title: Text(""),
                message: Text(DELETE_PROMPT),
                primaryButton: .destructive(Text(DELETE)) {
                    withAnimation {
                        self.deleteHandler()
                        self.dismissHandler()
                    }
                },
                secondaryButton: .cancel()
            )
        }
    }
}

struct StatItemOptions_Previews: PreviewProvider {
    static var previews: some View {
        StatItemOptions(dismissHandler: {}, deleteHandler: {}, modifyHandler: {})
    }
}
