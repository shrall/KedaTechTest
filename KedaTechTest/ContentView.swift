//
//  ContentView.swift
//  KedaTechTest
//
//  Created by Marshall Kurniawan on 23/06/23.
//

import SwiftUI

struct ContentView: View {
    @State private var tabSelection = 1
    var body: some View {
        TabView(selection: $tabSelection) {
            ProductListView(navigationTitle: "Products")
                .tabItem {
                    Label("Products", systemImage: "magnifyingglass")
                }
                .tag(1)
            ProductListView(navigationTitle: "Favorites")
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
                .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
