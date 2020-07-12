//
//  ActivityIndicator.swift
//  List
//
//  Created by Miguel Goñi on 12/07/2020.
//  Copyright © 2020 Miguel Goñi. All rights reserved.
//

import Foundation
import UIKit

class ActivityIndicatorScreen: UIView, Nibbable {
    
    @IBOutlet var loadingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet var backGroundView: UIView!
    
    // MARK: Nibbable
    var view: UIView!
    
    private let transparency: CGFloat
    
    init(transparency: CGFloat = 0.8) {
        
        self.transparency = transparency
        
        super.init(frame: UIScreen.main.bounds)
        
        viewFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        loadingActivityIndicator.color = .black
        backGroundView.backgroundColor = .white
        backGroundView.alpha = transparency
    }
    
    func show(view: UIView) {
        
        alpha = 1
        if self.superview == nil {
            view.addSubview(self)
            loadingActivityIndicator.startAnimating()
        }
    }
    
    func hide(animated: Bool = true, completion: (() -> Void)? = nil) {
        if animated == true {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3, animations: {
                    self.alpha = 0
                }, completion: { (finished) in
                    if self.superview != nil, finished {
                        self.loadingActivityIndicator.stopAnimating()
                        self.removeFromSuperview()
                        completion?()
                    }
                })
            }
        } else {
            self.loadingActivityIndicator.stopAnimating()
            self.removeFromSuperview()
            completion?()
        }
    }
    
    deinit {
        loadingActivityIndicator.stopAnimating()
        removeFromSuperview()
    }
}

