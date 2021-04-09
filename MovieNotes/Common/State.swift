//
//  State.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 09.04.2021.
//  Copyright © 2021 Богдан Семенюк. All rights reserved.
//

import Foundation

enum State {
    case loading
    case finishedLoading
    case error(Error)
}
