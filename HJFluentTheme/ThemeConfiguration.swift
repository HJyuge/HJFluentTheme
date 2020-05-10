//
//  ThemeConfiguration.swift
//  HJFluentTheme
//
//  Created by SpeakNow on 2020/5/8.
//  Copyright © 2020 SpeakNow. All rights reserved.
//

import Foundation

let colorConfig = [
    "dark":[
        "nav-bg-color": "#13171B",
        "vc-bg-main-color": "#13171B",
        "view-color":"#07C160",
        "text-main-color": "#FFFFFFDE",
        "tab-bg-color": "#1F2226",
    ],
    
    "light":[
        "nav-bg-color": "#F2F5F7",
        "vc-bg-main-color": "#F2F5F7",
        "view-color":"#07C160",
        "text-main-color": "#000000FF",
        "tab-bg-color": "#F2F5F7",
    ],
    
    "red":[
        "nav-bg-color": "0xFF534E",
        "vc-bg-main-color": "0xFF534E",
        "view-color":"#07C160",
        "text-main-color": "0xFF534E",
        "tab-bg-color": "0xFF534E",
    ]
]

let imageConfig = [
    "dark":[
        "work_item_discuss_home": "dark_work_item_discuss_home",
        "work_item_guide_home": "dark_work_item_guide_home",
    ],
    
    "light":[
        "work_item_discuss_home": "work_item_discuss_home",
        "work_item_guide_home": "work_item_guide_guest",
    ],
    
    "red":[
        "work_item_discuss_home": "work_item_discuss_home",
        "work_item_guide_home": "work_item_guide_guest",
    ]
]

let kNavBgColor = "nav-bg-color"
let kTextMainColor = "text-main-color"
let kVCBgMainColor = "vc-bg-main-color"
let kTabBgColor = "tab-bg-color"
let kViewColor = "view-color"

let kWorkItemDiscussHomeImage = "work_item_discuss_home"
let kWorkItemGuideHomeImage = "work_item_guide_home"

let kdarkMode = "dark"
let klightModel = "light"
let kredModel = "red"

class ThemeConfiguration: NSObject,TMThemeConfiguration {
    var themeMode: String {
        get {
            return mode
        }
        set(themeMode) {
            mode = themeMode
        }
    }
    
    private var mode = "light"
    
    public func resolveSpecificColorPath(_ path: String) -> String? {
        let sequeances = path.split(separator: ".").compactMap { "\($0)" }
        if let mode = sequeances.first,let key = sequeances.last {
            let colorStr = colorConfig[mode]?[key]
            return colorStr
        }
        return nil
    }
    
    public func resolveSpecificImagePath(_ path: String) -> String? {
        let sequeances = path.split(separator: ".").compactMap { "\($0)" }
        if let mode = sequeances.first,let key = sequeances.last {
            let imageStr = imageConfig[mode]?[key]
            return imageStr
        }
        return nil
    }
}

