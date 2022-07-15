//
//  TabbarView.swift
//  english
//
//  Created by polykuzin on 15/07/2022.
//

import SwiftUI
import EN_Summary

struct TabbarView : View {

    @State
    private var selectedTab : TabbarType = .summary

    var body : some View {
        TabView(selection: $selectedTab) {
            summary.tag(TabbarType.summary)
            settings.tag(TabbarType.settings)
        }
    }

    private var summary : some View {
        EN_SummaryView()
            .tabItem {
                Label("Catalog", systemImage: "house")
            }
    }

    private var settings : some View {
        EN_SummaryView()
            .tabItem {
                Label("Catalog", systemImage: "house")
            }
    }
}

#if DEBUG
struct TabbarView_Previews : PreviewProvider {
    
    static var previews : some View {
        TabbarView()
    }
}
#endif
