//
//  HomeView.swift
//  DeepLink
//
//  Created by Ginger on 19/10/2020.
//

import SwiftUI

struct HomeView: View {
    @State var todoItems = [TodoItem(), TodoItem(), TodoItem()]
    @State var activeUUID: UUID?
    
    var body: some View {
        NavigationView {
            List(todoItems) { todoItem in
                NavigationLink(destination: TodoItemView(uuid: "\(todoItem.id)"), tag: todoItem.id, selection: $activeUUID) {
                    Text("\(todoItem.id)")
                }
            }
            .navigationTitle(Text("Home"))
            .onOpenURL { url in
                if case .todoItem(let id) = url.detailPage {
                    activeUUID = id
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
