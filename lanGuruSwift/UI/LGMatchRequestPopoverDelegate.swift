//
//  LGMatchRequestPopoverDelegate.swift
//  lanGuruSwift
//
//  Created by Felix Belau on 05.11.14.
//  Copyright (c) 2014 Felix Belau. All rights reserved.
//

import Foundation

protocol LGMatchRequestPopoverDelegate
{
    func startMatchRequest(friendToChallenge : User)
    func acceptMatchRequest(matchID : Int)
}