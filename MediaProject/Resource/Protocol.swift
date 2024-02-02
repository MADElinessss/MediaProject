//
//  Protocol.swift
//  MediaProject
//
//  Created by Madeline on 2/2/24.
//

import UIKit

protocol TVSeriesTableViewCellDelegate: AnyObject {
    func didSelectSeries(withID seriesID: Int)
}
