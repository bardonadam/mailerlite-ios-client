//
//  ABActionSheet.swift
//  ABActionSheet
//
//  Created by Adam Bardon on 20/12/2017.
//

import UIKit

struct ABActionSheetOption {
    let title: String
    let style: UIAlertAction.Style
    
    init(title: String, style: UIAlertAction.Style) {
        self.title = title
        self.style = style
    }
}

protocol ABActionSheetDelegate {
    func didSelectedOption(withIndex index: Int)
}

class ABActionSheet: UIViewController {
    
    @IBOutlet weak var optionTableView: UITableView!
    @IBOutlet weak var optionTableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var cancelButton: UIButton!
    
    enum TitleCellHeight: CGFloat {
        case short = 44
        case medium = 64
        case big = 84
        case ultraBig = 104
    }
    
    let optionTableItemHeight: CGFloat = 60
    
    var completion: ((ABActionSheet) -> Void)?
    var delegate: ABActionSheetDelegate?
    
    var actionSheetTitle: String?
    var message: String?
    
    var options: [ABActionSheetOption]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.isOpaque = false
        
        optionTableView.layer.cornerRadius = 14
        optionTableView.layer.masksToBounds = true
        
        cancelButton.layer.cornerRadius = 14
        cancelButton.layer.masksToBounds = true
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.tintColor = .Steel
        
        optionTableView.dataSource = self
        optionTableView.delegate = self
        optionTableView.register(UINib(nibName: "ABActionSheetTitleCell", bundle: nil), forCellReuseIdentifier: "ABActionSheetTitleCell")
        optionTableView.register(UINib(nibName: "ABActionsheetOptionCell", bundle: nil), forCellReuseIdentifier: "ABActionsheetOptionCell")
        optionTableView.separatorStyle = .none
        optionTableView.tableFooterView = UIView()
        optionTableView.layoutMargins = UIEdgeInsets.zero
        optionTableView.separatorInset = UIEdgeInsets.zero
        
        optionTableViewHeightConstraint.constant = getTitleCellHeight() + optionTableItemHeight * CGFloat(options?.count ?? 0)
        
        if let completion = completion {
            completion(self)
        }
    }
    
    func present(title: String, message: String? = nil, options: [ABActionSheetOption]?, _ completion: @escaping (ABActionSheet) -> Void) {
        let modalViewController = self
        modalViewController.modalPresentationStyle = .overCurrentContext
        modalViewController.actionSheetTitle = title
        modalViewController.message = message
        modalViewController.options = options
        modalViewController.completion = completion

        present(actionSheet: modalViewController)
    }
    
    func present(withTitlee title: String, message: String? = nil, options: [ABActionSheetOption]?, _ completion: @escaping (ABActionSheet) -> Void) {
        let modalViewController = self
        modalViewController.modalPresentationStyle = .overCurrentContext
        modalViewController.actionSheetTitle = title
        modalViewController.message = message
        modalViewController.options = options
        modalViewController.completion = completion
        
        present(actionSheet: modalViewController)
    }
    
    private func present(actionSheet: ABActionSheet) {
        if let rootController = UIApplication.shared.keyWindow?.rootViewController {
            var currentController: UIViewController! = rootController
            while( currentController.presentedViewController != nil ) {
                currentController = currentController.presentedViewController
            }
            currentController.present(actionSheet, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func getTitleCellHeight() -> CGFloat {
        var titleCellHeight: TitleCellHeight
        
        if message != nil {
            titleCellHeight = .big
        }
        else {
            titleCellHeight = .short
        }
        
        return titleCellHeight.rawValue
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        
        if touch?.view == view {            
            if let touchY = touch?.location(in: view).y, touchY < optionTableView.frame.origin.y {
                dismiss(animated: true, completion: nil)
            }
        }
    }
}

extension ABActionSheet: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (options?.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return getTitleCellHeight()
        }
        else {
            return optionTableItemHeight
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ABActionSheetTitleCell", for: indexPath) as! ABActionSheetTitleCell
            
            cell.titleLabelTopConstraint.constant = 12
            
            cell.titleLabel.textColor = .ShamrockGreen
            cell.titleLabel.text = actionSheetTitle
            
            cell.messageLabel.textColor = .gray
            cell.messageLabel.text = message
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ABActionsheetOptionCell", for: indexPath) as! ABActionsheetOptionCell
            
            if let options = options {
                let option = options[indexPath.row - 1]
                cell.nameLabel.text = option.title
                cell.nameLabel.textColor = option.style == .destructive ? .red : .Onyx
            }
        
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // skips title cell
        if indexPath.row > 0 {
            dismiss(animated: true, completion: {
                self.delegate?.didSelectedOption(withIndex: indexPath.row - 1)
            })
        }
    }
}
