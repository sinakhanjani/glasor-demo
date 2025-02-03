//
//  Enumeration.swift
//  Glasor
//
//  Created by Teodik Abrami on 11/19/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import Foundation

enum Sexual: Int {
    case none, male, female
}

enum Alert {
    case none, success, failed, server, network, invalidInput, duplicate, json, data, noLogin, wrongCode, noData
}

enum Activation: Int {
    case none, active, deActive
}

enum SideMenuItem {
    case none, main, sefareshList, pm, aboutUS, darkhastHamkari, rahnama
}

enum UserHistory {
    case old, new
}

enum Exapandable {
    case expand, unExpand
}
enum Buying {
    case add, sum, substact, remove
}

enum NotifyForms: String {
    case homework = "homework"
    case exam = "exam"
    case news = "news"
}

enum Weeks: String {
    case shanbe = "شنبه"
    case yekshanbe = "یکشنبه"
    case doshanbe = "دوشنبه"
    case seshanbe = "سه شنبه"
    case charshanbe = "چهارشنبه"
    case panjshanbe = "پنج شنبه"
}
