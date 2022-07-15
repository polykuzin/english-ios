//
//  EN_SummaryList.swift
//  
//
//  Created by polykuzin on 15/07/2022.
//

import Combine
import SwiftUI

struct CountriesList: View {
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                
            }
            .navigationViewStyle(DoubleColumnNavigationViewStyle())
        }
    }
}

#if DEBUG
struct CountriesList_Previews: PreviewProvider {
    static var previews: some View {
        CountriesList()
    }
}
#endif
