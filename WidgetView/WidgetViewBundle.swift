//
//  WidgetViewBundle.swift
//  WidgetView
//
//  Created by 김은찬 on 10/28/25.
//

import WidgetKit
import SwiftUI

@main
struct WidgetViewBundle: WidgetBundle {
    var body: some Widget {
        WidgetView()
        WidgetViewControl()
        WidgetViewLiveActivity()
    }
}
