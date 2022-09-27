//
//  DrainCheckPickerController.swift
//  
//
//  Created by Noah Little on 25/9/2022.
//

import UIKit
import Preferences

class DrainCheckPickerController: PSListItemsController
{
    override func tableViewStyle() -> UITableView.Style
    {
        if #available(iOS 13.0, *)
        {
            return .insetGrouped
        }
        else
        {
            return .grouped
        }
    }
}
