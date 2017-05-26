//
//  MCExpandableContractable.swift
//  SideGuideGZ
//
//  Created by zhen gong on 5/26/17.
//  Copyright © 2017 zhen gong. All rights reserved.
//

import Foundation

internal protocol MCExpandableContractable {
    func expand()
    func contract()
    func prepForExpand()
}
