//
//  UIExtView.swift
//  BazBluetooth
//
//  Created by Usuario  on 19/08/24.
//

import Foundation
import UIKit

enum Anchor { case left, top, right, bottom }


let width = UIScreen.main.bounds.width
let height = UIScreen.main.bounds.height

let greenColor = UIColor(red: 0.00, green: 0.73, blue: 0.14, alpha: 1.00)


extension UIView {
    
    static func topPadding() -> CGFloat {
       if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0.0
        } else {
            return 0.0
        }
    }
    
    static func bottomPadding() -> CGFloat {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0.0
        } else {
            return 0.0
        }
    }
    
    
    func dropShadow(scale: Bool = true) {
      layer.masksToBounds = false
      layer.shadowColor = UIColor.black.cgColor
      layer.shadowOpacity = 0.5
      layer.shadowOffset = CGSize(width: -1, height: 1)
      layer.shadowRadius = 1

      layer.shadowPath = UIBezierPath(rect: bounds).cgPath
      layer.shouldRasterize = true
      layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func addAnchorsWithMargin(_ margin:CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leftAnchor.constraint(equalTo: self.superview!.leftAnchor, constant: margin).isActive = true
        self.topAnchor.constraint(equalTo: self.superview!.topAnchor, constant: margin).isActive = true
        self.rightAnchor.constraint(equalTo: self.superview!.rightAnchor, constant: -margin).isActive = true
        self.bottomAnchor.constraint(equalTo: self.superview!.bottomAnchor, constant: -margin).isActive = true
    }
    
    /**
     Description: Centers the view in the superview, using the superview's **size** and **XYAxis** position, not the left, top, right, bottom anchors to avoid issues with the *UISCrollViews*
     Parameters: None
     */
    func addAnchorsCenterAndFillContainerWithSize() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: self.superview!.widthAnchor).isActive = true
        self.heightAnchor.constraint(equalTo: self.superview!.heightAnchor).isActive = true
        self.centerXAnchor.constraint(equalTo: self.superview!.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: self.superview!.centerYAnchor).isActive = true
    }
    
    /**
     Adds 2 optional alignment parameterts (**centerX**, **centerY**), 2 optional size dimensions (**width** and **height**) and up to 4 border anchors **.left**, **.top**, **.right** and **.bottom**. One of them (defined in **withAnchor** can be relative to another view
     
     - Parameter centerX: **Bool** value (or *nil*) to define if the view should be centered **horizontally** to the superview. (optional)
     - Parameter centerY: **Bool** value (or *nil*) to define if the view should be centered **vertically** to the superview. (optional)
     - Parameter width: The **width** of the view (optional)
     - Parameter width: The **width** of the view (optional)
     - Parameter height: The **height** of the view (optional)
     - Parameter left: The **left** margin to the superview
     - Parameter top: The **top** margin to the superview
     - Parameter right: The **right** margin to the superview. *Magniture adjusted to be positive for margins inside the view*
     - Parameter bottom: The **bottom** margin to the superview. *Magniture adjusted to be positive for margins inside the view*
     - Parameter withAnchor: The **Anchor** type that is relative to the **relativeToView** view. *This parameter can be omited*
     - Parameter relativeToView: The **UIView** object that is the reference for the **withAnchor** anchor. *This parameter can be omited*
     
     - Returns: None
     */
    func addAnchorsAndCenter(centerX: Bool?, centerY: Bool?, width: CGFloat?, height: CGFloat?, left: CGFloat?, top: CGFloat?, right: CGFloat?, bottom: CGFloat?, withAnchor: Anchor? = nil, relativeToView: UIView? = nil) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if centerX != nil,
           centerX! {
            self.centerXAnchor.constraint(equalTo: self.superview!.centerXAnchor).isActive = true
        }
        if centerY != nil,
           centerY! {
            self.centerYAnchor.constraint(equalTo: self.superview!.centerYAnchor).isActive = true
        }
        
        self.addAnchorsAndSize(width: width, height: height, left: left, top: top, right: right, bottom: bottom, withAnchor: withAnchor, relativeToView: relativeToView)
    }
    
    /**
     Adds 2 optional size dimensions (**width** and **height**) and up to 4 border anchors **.left**, **.top**, **.right** and **.bottom**. One of them (defined in **withAnchor** can be relative to another view
     
     - Parameter width: The **width** of the view (optional)
     - Parameter height: The **height** of the view (optional)
     - Parameter left: The **left** margin to the superview
     - Parameter top: The **top** margin to the superview
     - Parameter right: The **right** margin to the superview. *Magniture adjusted to be positive for margins inside the view*
     - Parameter bottom: The **bottom** margin to the superview. *Magniture adjusted to be positive for margins inside the view*
     - Parameter withAnchor: The **Anchor** type that is relative to the **relativeToView** view. *This parameter can be omited*
     - Parameter relativeToView: The **UIView** object that is the reference for the **withAnchor** anchor. *This parameter can be omited*
     
     - Returns: None
     */
    func addAnchorsAndSize(width: CGFloat?, height: CGFloat?, left: CGFloat?, top: CGFloat?, right: CGFloat?, bottom: CGFloat?, withAnchor: Anchor? = nil, relativeToView: UIView? = nil) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        if width != nil {
            self.widthAnchor.constraint(equalToConstant: width!).isActive = true
        }
        if height != nil {
            self.heightAnchor.constraint(equalToConstant: height!).isActive = true
        }
        self.addAnchors(left: left, top: top, right: right, bottom: bottom, withAnchor: withAnchor, relativeToView: relativeToView)
    }
    
    /**
     Adds up to 4 border anchors **.left**, **.top**, **.right** and **.bottom**. One of them (defined in **withAnchor** can be relative to another view
     
     - Parameter left: The **left** margin to the superview
     - Parameter top: The **top** margin to the superview
     - Parameter right: The **right** margin to the superview. *Magniture adjusted to be positive for margins inside the view*
     - Parameter bottom: The **bottom** margin to the superview. *Magniture adjusted to be positive for margins inside the view*
     - Parameter withAnchor: The **Anchor** type that is relative to the **relativeToView** view. *This parameter can be omited*
     - Parameter relativeToView: The **UIView** object that is the reference for the **withAnchor** anchor. *This parameter can be omited*
     
     - Returns: None
     */
    func addAnchors(left: CGFloat?, top: CGFloat?, right: CGFloat?, bottom: CGFloat?, withAnchor: Anchor? = nil, relativeToView: UIView? = nil) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        let superView = self.superview!
        if withAnchor != nil && relativeToView != nil {
            /**
             * Anchors relative to oposite anchors of reference view
             **/
            switch withAnchor! {
             case .left:
                    if left != nil {
                        self.leftAnchor.constraint(equalTo: relativeToView!.rightAnchor, constant: left!).isActive = true
                    }
                case .top:
                    if top != nil {
                        self.topAnchor.constraint(equalTo: relativeToView!.bottomAnchor, constant: top!).isActive = true
                    }
                case .right:
                    if right != nil {
                        self.rightAnchor.constraint(equalTo: relativeToView!.leftAnchor, constant: -right!).isActive = true
                    }
                case .bottom:
                    if bottom != nil {
                        self.bottomAnchor.constraint(equalTo: relativeToView!.topAnchor, constant: -bottom!).isActive = true
                    }
            }
        }
        
        /**
         * Anchors relative to same anchors of superview
         **/
        if let _anchor = withAnchor {
            if _anchor == .left {
                if top != nil {
                    self.topAnchor.constraint(equalTo: superView.topAnchor, constant: top!).isActive = true
                }
                if right != nil {
                    self.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -right!).isActive = true
                }
                if bottom != nil {
                    self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -bottom!).isActive = true
                }
            }
            if _anchor == .top {
                if left != nil {
                    self.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: left!).isActive = true
                }
                if right != nil {
                    self.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -right!).isActive = true
                }
                if bottom != nil {
                    self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -bottom!).isActive = true
                }
            }
            if _anchor == .right {
                if left != nil {
                    self.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: left!).isActive = true
                }
                if top != nil {
                    self.topAnchor.constraint(equalTo: superView.topAnchor, constant: top!).isActive = true
                }
                if bottom != nil {
                    self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -bottom!).isActive = true
                }
            }
            if _anchor == .bottom {
                if left != nil {
                    self.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: (left!)).isActive = true
                }
                if top != nil {
                    self.topAnchor.constraint(equalTo: superView.topAnchor, constant: top!).isActive = true
                }
                if right != nil {
                    self.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -right!).isActive = true
                }
            }
        } else {
            if left != nil {
                self.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: left!).isActive = true
            }
            if top != nil {
                self.topAnchor.constraint(equalTo: superView.topAnchor, constant: top!).isActive = true
            }
            if right != nil {
                self.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -right!).isActive = true
            }
            if bottom != nil {
                self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -bottom!).isActive = true
            }
        }
    }
}


