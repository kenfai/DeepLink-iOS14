//
//  DeepLinkApp.swift
//  DeepLink
//
//  Created by Ginger on 19/10/2020.
//

import SwiftUI

enum PageIdentifier: Hashable {
    case todoItem(id: UUID)
}

enum TabIdentifier: Hashable {
    case home, settings
}

extension URL {
    var isDeeplink: Bool {
        return scheme == "my-url-scheme" // matches my-url-scheme://<rest-of-the-url>
    }
    
    var tabIdentifier: TabIdentifier? {
        guard isDeeplink else {
            return nil
        }
        
        switch host {
        case "home": return .home // matches my-url-scheme://home/
        case "settings": return .settings // matches my-url-scheme://settings/
        default: return nil
        }
    }
    
    var detailPage: PageIdentifier? {
        guard let pageIdentifier = tabIdentifier,
              pathComponents.count > 1,
              let uuid = UUID(uuidString: pathComponents[1]) else {
            return nil
        }
        
        switch pageIdentifier {
        case .home: return .todoItem(id: uuid)
        default: return nil
        }
    }
}

@main
struct DeepLinkApp: App {
    @State private var activeTab: TabIdentifier = .home
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $activeTab) {
                HomeView()
                    .tabItem {
                        VStack {
                            Image(systemName: "house")
                            Text("Home")
                        }
                    }
                    .tag(TabIdentifier.home)
                
                SettingsView()
                    .tabItem {
                        VStack {
                            Image(systemName: "gearshape")
                            Text("Settings")
                        }
                    }
                    .tag(TabIdentifier.settings)
            }
            .onOpenURL { url in
                guard let tabIdentifier = url.tabIdentifier else {
                    return
                }
                
                activeTab = tabIdentifier
            }
        }
    }
}
