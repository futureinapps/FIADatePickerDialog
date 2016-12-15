//
//  FIADatePickerDialog.swift
//  FIADatePickerDialog
//
//  Created by Айрат Галиуллин on 14.12.16.
//  Copyright © 2016 Fucher in Apps OOO. All rights reserved.
//

import UIKit

fileprivate let datePickerTextColorKeyPath = "textColor"
fileprivate typealias EmptyResultBlock = (()->())
fileprivate let actionButtonHeight:CGFloat = 50
fileprivate let titleLabelHeight:CGFloat = 50
fileprivate let containerViewMargin:CGFloat = 32
fileprivate let defaultAnimationDuration:TimeInterval = 0.1
fileprivate let titleLabelFont = UIFont.boldSystemFont(ofSize: 22)
fileprivate let containerCornerRadius:CGFloat = 15
fileprivate let borderWidth:CGFloat = 0.5
fileprivate let borderColor = UIColor.hexStringToUIColor(hex: "333333", alpha: 0.5)

@objc public protocol FIADatePickerDialogDelegate {
    func submit(with date:Date!,and sender:Any)
    @objc optional func cancel(with sender:Any)
}

public class FIADatePickerDialog: NSObject,FIADatePickerDialogActionDelegate {
    
    private var globalView:UIView!
    private var datePicker:UIDatePicker!
    private var containerView:UIView!
    private var submitButton:UIButton!
    private var cancelButton:UIButton!
    private var titleLabel:FIADatePickerDialogLabel!
    private var target:UIView!
    public var delegate:FIADatePickerDialogDelegate?
    public var datepickerTextColor = UIColor.fia_yellow()
    public var datepickerContainerBGRColor = UIColor.darkGray
    public var globalContainerBGRColor = UIColor.hexStringToUIColor(hex: "000000", alpha: 0.7)
    public var submitActionTitle = "ACCEPT"
    public var cancelActionTitle = "CANCEL"
    public var submitActionBGRColor = UIColor.clear
    public var cancelActionBGRColor = UIColor.clear
    public var submitActionTextColor = UIColor.fia_yellow()
    public var cancelActionTextColor = UIColor.fia_yellow()
    public var titleLabelTextColor = UIColor.white
    public var actionButtonFont = UIFont.boldSystemFont(ofSize: 17)
    public var isWithoutTitle = false
    private var animated:Bool = false
    private var sender:Any!
    
    public init(with targetView:UIView!){
        super.init()
        guard targetView != nil else{
            fatalError("Target view should not be nil")
        }
        datePicker = UIDatePicker()
        target = targetView
        let tViewRect = target!.bounds
        guard tViewRect.size.height > datePicker.bounds.size.height+titleLabelHeight+actionButtonHeight else {
            fatalError("Target view heaight should not be less than dialog height")
        }
        globalView = UIView(frame: tViewRect)
        let cW = tViewRect.size.width - containerViewMargin
        let cViewCenter = CGPoint(x:tViewRect.size.width/2,y:tViewRect.size.height/2)
        containerView = UIView(frame: CGRect(x: 0, y: 0, width: cW, height: datePicker.bounds.height+actionButtonHeight+titleLabelHeight))
        datePicker.center = CGPoint(x:containerView.bounds.size.width/2,y: datePicker.center.y + titleLabelHeight)
        containerView.center = cViewCenter
        submitButton = UIButton(frame: CGRect(x:0,y:datePicker.bounds.size.height+titleLabelHeight,width:containerView.bounds.size.width/2,height:actionButtonHeight))
        cancelButton = UIButton(frame: CGRect(x:containerView.bounds.size.width/2,y:datePicker.bounds.size.height+titleLabelHeight,width:containerView.bounds.size.width/2,height:actionButtonHeight))
        let titleLabelFrame = CGRect(x: 0, y: 0, width: containerView.bounds.size.width, height: titleLabelHeight)
        titleLabel = FIADatePickerDialogLabel(frame: titleLabelFrame)
    }
    
    public func show(mode:UIDatePickerMode,withDate defaultDate:Date=Date(),withAnimation animation:Bool=true,withTitle title:String="",withSender:Any){
        sender = withSender
        configureDefaultAppearence(mode:mode,withDate:defaultDate)
        if title == ""{
            if !isWithoutTitle {
                isWithoutTitle = true
                setSize(without: isWithoutTitle)
            }
        } else {
            if isWithoutTitle {
                isWithoutTitle = false
                setSize(without: isWithoutTitle)
            }
            titleLabel.text = title
            containerView.addSubview(titleLabel)
        }
        target.addSubview(globalView)
        self.globalView.addSubview(self.containerView)
        self.containerView.addSubview(self.datePicker)
        self.containerView.addSubview(self.submitButton)
        self.containerView.addSubview(self.cancelButton)
        self.animated = animation
        if self.animated {
            globalView.alpha = 0
            UIView.animate(withDuration: defaultAnimationDuration*2, animations: {
                self.globalView.alpha = 1
            }, completion: nil)
            UIView.animate(withDuration: defaultAnimationDuration, delay: 0, options: .curveLinear, animations: {
                self.containerView.transform = CGAffineTransform(scaleX: 0, y: 0)
                self.target.layoutIfNeeded()
            }, completion: {finish in
                UIView.animate(withDuration: defaultAnimationDuration, delay: 0, options: .curveLinear, animations: {
                    self.containerView.transform = CGAffineTransform(scaleX: 1, y: 1)
                    self.target.layoutIfNeeded()
                }, completion: nil)
            })
        }
        
        
    }
    
    private func setSize(without label:Bool){
        if label {
            titleLabel.frame.size.height -= titleLabelHeight
            datePicker.center.y -= titleLabelHeight
            submitButton.frame.origin.y -= titleLabelHeight
            cancelButton.frame.origin.y -= titleLabelHeight
            containerView.frame.size.height -= titleLabelHeight
            containerView.frame.origin.y += titleLabelHeight/2
        } else {
            titleLabel.frame.size.height += titleLabelHeight
            datePicker.center.y += titleLabelHeight
            submitButton.frame.origin.y += titleLabelHeight
            cancelButton.frame.origin.y += titleLabelHeight
            containerView.frame.size.height += titleLabelHeight
            containerView.frame.origin.y -= titleLabelHeight/2
        }
    }
    //*****************************
    //MARK: - Actions and delegates
    //*****************************
    
    internal func submit(){
        preCancel(block:{
            guard self.delegate != nil else {
                fatalError("Delegate should not be nil")
            }
            self.delegate!.submit(with: self.datePicker.date,and:self.sender)
        })
    }
    
    internal func cancel(){
        preCancel(block: {
            if self.delegate?.cancel != nil {
                self.delegate!.cancel!(with:self.sender)
            }
        })
    }
    
    private func preCancel(block:@escaping EmptyResultBlock){
        if animated {
            UIView.animate(withDuration: defaultAnimationDuration*2, animations: {
                self.globalView.alpha = 0
            }, completion: nil)
            UIView.animate(withDuration: defaultAnimationDuration,delay: 0, options: .curveLinear,animations: {
                    self.containerView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                    self.target.layoutIfNeeded()
                },
                completion: { finish in
                    self.removeAllComponents()
                    block()
                })
        } else {
            removeAllComponents()
            block()
        }
    }
    
    private func removeAllComponents(){
        datePicker.removeFromSuperview()
        submitButton.removeFromSuperview()
        cancelButton.removeFromSuperview()
        containerView.removeFromSuperview()
        globalView.removeFromSuperview()
    }
    
    //***************************
    //MARK: - View Configurations
    //***************************
    
    private func configureDefaultAppearence(mode:UIDatePickerMode,withDate defaultDate:Date){
        configureGlobalView()
        configureDatePicker(mode:mode,withDate:defaultDate)
        configureContainerView()
        configureCancelButton()
        configureSubmitButton()
        configureTitleLabel()
    }
    
    private  func configureGlobalView(){
        globalView.backgroundColor = globalContainerBGRColor
    }
    
    //**************************************************************
    //Add Bottom Lines for containerView shadow
    //containerView.layer.shadowOpacity = 0.09;
    //containerView.layer.shadowOffset = CGSize(width: 0, height: 0)
    //containerView.layer.shadowRadius = 10.0;
    //**************************************************************
    
    private  func configureContainerView(){
        containerView.backgroundColor = datepickerContainerBGRColor
        containerView.layer.cornerRadius = containerCornerRadius
        containerView.layer.shadowColor = (datePicker.value(forKey: datePickerTextColorKeyPath) as! UIColor).cgColor
        containerView.layer.borderColor = borderColor.cgColor
        containerView.layer.borderWidth = borderWidth
    }
    
    private func configureSubmitButton(){
        submitButton.setTitle(submitActionTitle, for: .normal)
        submitButton.setTitleColor(submitActionTextColor, for: .normal)
        submitButton.addSideBorder(on: .Top, with: borderColor,and:borderWidth)
        submitButton.addSideBorder(on: .Right, with: borderColor,and:borderWidth)
        submitButton.delegate = self
        submitButton.addTarget(submitButton, action: #selector(submitButton.submit(_:)), for: .touchUpInside)
        submitButton.titleLabel?.font = actionButtonFont
        submitButton.isDatePickerAction = true
        submitButton.round(for: .bottomLeft, with: containerCornerRadius)
    }
    
    private func configureCancelButton(){
        cancelButton.setTitle(cancelActionTitle, for: .normal)
        cancelButton.setTitleColor(cancelActionTextColor, for: .normal)
        cancelButton.delegate = self
        cancelButton.titleLabel?.font = actionButtonFont
        cancelButton.addTarget(cancelButton, action: #selector(cancelButton.cancel(_:)), for: .touchUpInside)
        cancelButton.isDatePickerAction = true
        cancelButton.round(for: .bottomRight, with: containerCornerRadius)
        cancelButton.addSideBorder(on: .Top, with: borderColor,and:borderWidth)
    }
    
    private func configureDatePicker(mode:UIDatePickerMode,withDate defaultDate:Date){
        datePicker.datePickerMode = mode
        datePicker.date = defaultDate
        datePicker.setValue(datepickerTextColor, forKeyPath: datePickerTextColorKeyPath)
    }
    
    private func configureTitleLabel(){
        titleLabel.textAlignment = .center
        titleLabel.font = titleLabelFont
        titleLabel.textColor = titleLabelTextColor
        titleLabel.addSideBorder(on: .Bottom, with: borderColor,and:borderWidth)
    }
    
}
