//
//  ViewController.swift
//  tipsy
//
//  Created by viramesh on 1/7/15.
//  Copyright (c) 2015 vbits. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var fieldBillAmount: UITextField!
    @IBOutlet weak var labelTipString: UILabel!
    @IBOutlet weak var labelTipStringTop: NSLayoutConstraint!
    @IBOutlet weak var labelTip: UILabel!
    @IBOutlet weak var labelTipTop: NSLayoutConstraint!
    @IBOutlet weak var labelTotal: UILabel!
    @IBOutlet weak var segmentTipAmount: UISegmentedControl!
    @IBOutlet weak var viewTip: UIView!
    @IBOutlet weak var viewBill: UIView!
    @IBOutlet weak var viewBillTop: NSLayoutConstraint!
    @IBOutlet weak var viewTipControl: UIView!
    @IBOutlet weak var viewTipControlTriangle: UIView!
    var btnTipPercentage: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.fieldBillAmount.becomeFirstResponder()
        labelTip.text = "$0.00"
        labelTotal.text = "$0.00"
        
        self.viewTipControl.alpha = 0

        btnTipPercentage = UIButton.buttonWithType(.Custom) as UIButton
        btnTipPercentage.frame = CGRectMake(30, 216, 64, 32)
        btnTipPercentage.backgroundColor = UIColor.clearColor()
        btnTipPercentage.layer.cornerRadius = 16
        btnTipPercentage.layer.borderWidth = 1
        btnTipPercentage.layer.borderColor = UIColor.blackColor().CGColor
        btnTipPercentage.setTitle("18%", forState: UIControlState.Normal)
        btnTipPercentage.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        btnTipPercentage.addTarget(self, action: "toggleTipControl", forControlEvents: .TouchUpInside)
        viewTip.addSubview(btnTipPercentage)
        
        var mask = CAShapeLayer()
        mask.frame = viewTipControlTriangle.layer.bounds
        
        let width = viewTipControlTriangle.layer.frame.width
        let height = viewTipControlTriangle.layer.frame.height
        var path = CGPathCreateMutable()
        
        CGPathMoveToPoint(path, nil, 0, 0)
        CGPathAddLineToPoint(path, nil, 10, 12)
        CGPathAddLineToPoint(path, nil, 20, 0)
        CGPathAddLineToPoint(path, nil, 0, 0)
        CGPathCloseSubpath(path)
        
        mask.path = path
        viewTipControlTriangle.layer.mask = mask
    }
    
    func toggleTipControl() {
        let duration: NSTimeInterval = 0.4
        let options = UIViewAnimationOptions.CurveEaseOut
        let delay: NSTimeInterval = 0.0
        UIView.animateWithDuration(duration, delay: delay, options: options, animations: {
            if(self.viewTipControl.alpha == 1) {
                self.viewTipControl.alpha = 0
                self.labelTipStringTop.constant -= 20
                self.labelTipTop.constant -= 20
                self.btnTipPercentage.frame.origin.y -= 20
                self.viewTip.layoutIfNeeded()
            }
            else {
                self.viewTipControl.alpha = 1
                self.labelTipStringTop.constant += 20
                self.labelTipTop.constant += 20
                self.btnTipPercentage.frame.origin.y += 20
                self.viewTip.layoutIfNeeded()
            }
        },
        completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditBillAmount(sender: AnyObject) {
        
        var billStr = fieldBillAmount.text
        
        if(countElements(billStr) > 0) {
        
            if(billStr.substringToIndex(advance(billStr.startIndex, 1)) == "$") {
                billStr = billStr.substringFromIndex(advance(billStr.startIndex,1))
            }
        }
        
        
        var billAmount = billStr._bridgeToObjectiveC().doubleValue
        var tipPercentages = [0.18, 0.2, 0.22]
        var tip = billAmount * tipPercentages[segmentTipAmount.selectedSegmentIndex]
        var total = billAmount + tip
        
        fieldBillAmount.text = "$"+"\(billStr)"
        labelTip.text = String(format: "$%.2f", tip)
        labelTotal.text = String(format: "$%.2f", total)
        
        let duration: NSTimeInterval = 0.4
        let options = UIViewAnimationOptions.CurveEaseOut
        let delay: NSTimeInterval = 0.0
        UIView.animateWithDuration(duration, delay: delay, options: options, animations: {
            self.viewTip.alpha = 1
            self.viewBillTop.constant = 50
            self.viewBill.layoutIfNeeded()
        }, completion: nil)

        btnTipPercentage.setTitle(segmentTipAmount.titleForSegmentAtIndex(segmentTipAmount.selectedSegmentIndex), forState: UIControlState.Normal)

    }

}

