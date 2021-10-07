//
//  UIViewController+Extension.swift
//  Dazo
//
//  Created by Danish on 28/09/21.
//

import Foundation
import UIKit
import TTGSnackbar

extension UIViewController{
    
    func showSnackBar(message:String,image: UIImage,isImage:Bool,duration:TTGSnackbarDuration, animationType: TTGSnackbarAnimationType,bgColor:UIColor){
            let snackbar = TTGSnackbar(message: message, duration:duration)
            snackbar.animationType = animationType
            snackbar.backgroundColor = bgColor
            snackbar.topMargin = 0
            // Add icon image
            if isImage{
                snackbar.icon = image
            }
            snackbar.show()
        }
    
    func showToast(message:String,bgColor:UIColor) {
        let snackbar = TTGSnackbar(message: message, duration: .short)
        snackbar.backgroundColor = bgColor
        snackbar.animationType = .slideFromTopBackToTop
        snackbar.topMargin = 30
        snackbar.show()
    }
    
    /**
     to get the identifier of View Controller
     */
    
   class func identifier() -> String {
        return String(describing: self)
    }
    
    var hasSafeArea: Bool {
        guard
            #available(iOS 11.0, tvOS 11.0, *)
            else {
                return false
            }
        return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
    }
}
