//
//  RefreshableTableView.swift
//  MovieNotes
//
//  Created by Богдан Семенюк on 14.04.2021.
//  Copyright © 2021 Богдан Семенюк. All rights reserved.
//

import UIKit

final class RefreshableTableView: UITableView {
    override func awakeFromNib() {
        super.awakeFromNib()
        let refreshControlView = UIRefreshControl()
        refreshControlView.alpha = 0
        refreshControl = refreshControlView
    }
}
