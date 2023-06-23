//
//  ProductListView.swift
//  KedaTechTest
//
//  Created by Marshall Kurniawan on 23/06/23.
//

import SwiftUI

struct ProductListView: View {
    let navigationTitle: String
    let names = ["Holly", "Josh", "Rhonda", "Ted"]
    @State private var searchText = ""
    var searchResults: [String] {
        if searchText.isEmpty {
            return names
        } else {
            return names.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.adaptive(minimum: 160))
                ], spacing: 20) {
                    ForEach(searchResults, id: \.self) { name in
                        NavigationLink {
                            Text(name)
                        } label: {
                            VStack {
                                AsyncImage(url: URL(string: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg"),
                                           content: { image in
                                               image.resizable()
                                                   .aspectRatio(contentMode: .fit)
                                                   .frame(maxWidth: 200, maxHeight: 100)
                                           },
                                           placeholder: {
                                               ProgressView()
                                           })
                                Text(name)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle(navigationTitle)
        }
        .searchable(text: $searchText)
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(navigationTitle: "")
    }
}
