//
//  TodoItemView.swift
//  DeepLink
//
//  Created by Ginger on 19/10/2020.
//

import SwiftUI

struct TodoItemView: View {
    @State var uuid: String
    
    var body: some View {
        TextField("UUID", text: $uuid)
    }
}

struct TodoItemView_Previews: PreviewProvider {
    static var previews: some View {
        TodoItemView(uuid: "me")
    }
}
