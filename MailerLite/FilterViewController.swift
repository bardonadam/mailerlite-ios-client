//
//  FilterViewController.swift
//  MailerLite
//
//  Created by Adam Bardon on 21/02/2019.
//  Copyright © 2019 Adam Bardon. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    let filterToolbarViewHeight: CGFloat = Constants.UI.FilterToolbarHeight
    
    enum ContentType {
        case Stats
        case FilterAndStats
        case OrdersSegmentedControl
    }
    
    private lazy var filterToolbarView: FilterToolbarView = {
        return FilterToolbarView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: filterToolbarViewHeight))
    }()
    
    private var totalHeight: CGFloat?
    
    func setup() {
        view.translatesAutoresizingMaskIntoConstraints = false
        
        if let parent = parent {
            view.topAnchor.constraint(equalTo: parent.view.safeAreaLayoutGuide.topAnchor).isActive = true
            view.leftAnchor.constraint(equalTo: parent.view.leftAnchor).isActive = true
            view.widthAnchor.constraint(equalTo: parent.view.widthAnchor).isActive = true
        }
        
        view.addSubview(filterToolbarView)
        view.bringSubviewToFront(filterToolbarView)
        
        totalHeight = filterToolbarViewHeight
        
        view.heightAnchor.constraint(equalToConstant: getTotalHeight()).isActive = true
        
        if let parent = parent as? SubscriberListViewController {
            filterToolbarView.delegate = parent
            parent.delegate = filterToolbarView
        }
    }
    
    func getTotalHeight() -> CGFloat {
        return totalHeight ?? 0
    }
}

