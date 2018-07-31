//
//  Helper.swift
//  Assignment_1
//
//  Created by SJ cheng on 31/1/18.
//  Copyright © 2018 Shajie Chen. All rights reserved.
//

import UIKit
// MARK: GCDBlackBox

func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
    DispatchQueue.main.async {
        updates()
    }
}
