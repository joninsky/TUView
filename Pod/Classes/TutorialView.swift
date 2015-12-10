//
//  TutorialView.swift
//  TutorialView
//
//  Created by JV on 11/4/15.
//  Copyright © 2015 PebbleBee. All rights reserved.
//

import UIKit

public class TutorialView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    //Properties
    var layout: UICollectionViewFlowLayout?
    var pagingControl: UIPageControl?
    var dismissInstructions: UILabel?
    
    var viewDictionary: [String:UIView]?
    
    var arrayOfImages: [UIImage] = [UIImage]()
    
    var viewToCover: UIView?
    
    var currentIndex: NSIndexPath?
    
    var dismissGesture: UITapGestureRecognizer?
    
    var timerToRemoveLabel: NSTimer?
    
    //LifeCycle Functions
    public init() {
        //Instatniate the collection view flow layout
        self.layout = UICollectionViewFlowLayout()
        //Call super initalizer with a frame that is 0,0,0,0 and the flow layout
        super.init(frame: CGRectMake(0, 0, 0, 0), collectionViewLayout: self.layout!)
        
        //Instantiate the paging view
        self.pagingControl = UIPageControl()
        
        //Set up self (the collection view)
        self.registerClass(TutorialViewCell.self, forCellWithReuseIdentifier: "tutorialCell")
        self.dataSource = self
        self.delegate = self
        self.pagingEnabled = true
        
        //Set up the label
        self.dismissInstructions = UILabel()
        self.dismissInstructions?.text = "Double Tap to dismiss!"
        self.dismissInstructions?.numberOfLines = 0
        self.dismissInstructions?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        //Set Up the flow layout
        self.layout?.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        //Turn off translates masks for everything
        self.translatesAutoresizingMaskIntoConstraints = false
        self.pagingControl?.translatesAutoresizingMaskIntoConstraints = false
        self.dismissInstructions?.translatesAutoresizingMaskIntoConstraints = false
        
        //Create the dictionary that hold sthe views for autolayout
        self.viewDictionary = ["me":self, "pagingControl":self.pagingControl!, "dismissInstructions": self.dismissInstructions!]

        //Subscribe to interface Change Notifications
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "orientationChanged:", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
        //Set up gesture recognizer
        self.dismissGesture = UITapGestureRecognizer(target: self, action: "dismiss:")
        self.dismissGesture?.numberOfTapsRequired = 2
        self.addGestureRecognizer(self.dismissGesture!)
        
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Public functions
    public func addTutorial(viewToCover view: UIView, arrayOfImages: [UIImage]) {
        
        self.arrayOfImages = arrayOfImages
        
        self.viewToCover = view
        
        self.viewToCover?.addSubview(self)
        
        self.viewToCover?.addSubview(self.pagingControl!)
        
        self.viewToCover?.addSubview(self.dismissInstructions!)
        
        self.pagingControl?.numberOfPages = self.arrayOfImages.count
        
        self.setUpRelativeToView(self.viewToCover!, otherViews: self.viewDictionary!)
        
        //Set up timer
        if self.timerToRemoveLabel == nil {
            self.timerToRemoveLabel = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "removelabel:", userInfo: nil, repeats: false)
        }
        
    }
    
    func setPagingControlColor(currentPageColor: UIColor, notCurrentPageColor: UIColor) {
        self.pagingControl?.currentPageIndicatorTintColor = currentPageColor
        self.pagingControl?.pageIndicatorTintColor = notCurrentPageColor
    }

    
    //Collection View Functions
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return self.arrayOfImages.count
        
    }
    
    public func dismiss(gesture: UITapGestureRecognizer) {
        if self.superview != nil {
            self.viewToCover = nil
            self.removeFromSuperview()
            self.pagingControl?.removeFromSuperview()
            if self.dismissInstructions?.superview != nil {
                self.dismissInstructions?.removeFromSuperview()
            }
        }
    }
    
    func removelabel(sender: AnyObject) {
        self.dismissInstructions?.removeFromSuperview()
        self.timerToRemoveLabel?.invalidate()
        self.timerToRemoveLabel = nil
    }
    
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let Cell = self.dequeueReusableCellWithReuseIdentifier("tutorialCell", forIndexPath: indexPath) as! TutorialViewCell
    
        Cell.cellImage.image = self.arrayOfImages[indexPath.row]
        
        return Cell
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(self.frame.width, self.frame.height)
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }

    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        
        let visibleRect = CGRect(origin: self.contentOffset, size: self.bounds.size)
        
        let thePoint = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMinY(visibleRect))
        
        self.currentIndex = self.indexPathForItemAtPoint(thePoint)
        
        self.pagingControl?.currentPage = self.currentIndex!.row

    }
    
    func orientationChanged(notification: NSNotification) {
        
        
        guard let flowLayout = self.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        if UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication().statusBarOrientation) {
            flowLayout.itemSize = CGSize(width: self.frame.width, height: self.frame.height)
        } else {
            flowLayout.itemSize = CGSize(width: self.frame.width, height: self.frame.height)
        }
        
        flowLayout.invalidateLayout()
    }
    
    
    //Auto Layout Functions
    func setUpRelativeToView(theView: UIView, otherViews: [String:UIView]) {
        
        var arrayOfConstraints = [NSLayoutConstraint]()
        
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[me]|", options: [], metrics: nil, views: otherViews)
        
        for c in verticalConstraints {
            arrayOfConstraints.append(c)
        }
        
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[me]|", options: [], metrics: nil, views: otherViews)
        
        for c in horizontalConstraints {
            arrayOfConstraints.append(c)
        }
        
        let pagingViewHorizontalConstraint = NSLayoutConstraint(item: self.pagingControl!, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: theView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        
        arrayOfConstraints.append(pagingViewHorizontalConstraint)
        
        
        let pagingViewVerticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[pagingControl]-30-|", options: [], metrics: nil, views: otherViews)
        
        for c in pagingViewVerticalConstraints {
            arrayOfConstraints.append(c)
        }
        
        let dismissInstructionsVerticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-30-[dismissInstructions]", options: [], metrics: nil, views: otherViews)
        
        for c in dismissInstructionsVerticalConstraints {
            arrayOfConstraints.append(c)
        }
        
        let dismissInstructionsHorizontalConstraint = NSLayoutConstraint(item: self.dismissInstructions!, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: theView, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0)
        
        let moredismissButtonHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-(>=0)-[dismissInstructions]-(>=0)-|", options: [], metrics: nil, views: otherViews)
        
        for c in moredismissButtonHorizontalConstraints {
            arrayOfConstraints.append(c)
        }

        arrayOfConstraints.append(dismissInstructionsHorizontalConstraint)
        
        theView.addConstraints(arrayOfConstraints)
        
        
    }
    
    
    
    
//End Class
}
