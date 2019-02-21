//
//  FilterToolbarView.swift
//  MailerLite
//
//  Created by Adam Bardon on 21/02/2019.
//  Copyright © 2019 Adam Bardon. All rights reserved.
//

import UIKit

protocol FilterToolbarProtocol {
    func didChangeFilter(filterState: FilterState)
}

enum FilterState: String {
    case All
    case Active
    case Unsubscribed
    
    static let allValues = [All, Active, Unsubscribed]
}

class FilterToolbarView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var filterButton: UIButton!
    
    var filterState = FilterState.All
    var delegate: FilterToolbarProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        loadNib()
        addSubview(contentView)
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.frame = self.bounds
        contentView.backgroundColor = .Bunker
        
        filterButton.layer.masksToBounds = true
        filterButton.layer.cornerRadius = Constants.UI.CornerRadius
        filterButton.titleEdgeInsets.left = 10
        filterButton.titleEdgeInsets.right = 10
    }
    
    func update() {
        switch filterState {
        case .All:
            filterButton.setTitle(FilterState.All.rawValue, for: .normal)
        case .Active:
            filterButton.setTitle(FilterState.Active.rawValue, for: .normal)
        case .Unsubscribed:
            filterButton.setTitle(FilterState.Unsubscribed.rawValue, for: .normal)
        }
    }
    
    @IBAction func filterButtonAction(_ sender: Any) {
        var options = [ABActionSheetOption]()

        for optionTitle in FilterState.allValues {
            options.append(ABActionSheetOption(title: optionTitle.rawValue, style: .default))
        }

        ABActionSheet().present(title: Constants.Strings.Filter.Title, message: nil, options: options) { [unowned self] actionSheet in
            actionSheet.delegate = self
        }
        
    }
}

extension FilterToolbarView: ABActionSheetDelegate {
    func didSelectedOption(withIndex index: Int) {
        filterState = FilterState.allValues[index]
        update()
        delegate?.didChangeFilter(filterState: filterState)
    }
}
