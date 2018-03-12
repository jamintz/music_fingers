//
//  NewPageViewController.swift
//  Jamie's Magic Fingers
//
//  Created by Jason Mintz on 12/10/17.
//  Copyright © 2017 Jason Mintz. All rights reserved.
//

import UIKit

class NewPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var pageControl = UIPageControl()
    var views = [[String:String]]()
    var allViews = [TopViewController]()
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = getViews().index(of: viewController) else {
            return nil
        }
        
        if viewControllerIndex == 0 {
            return nil
        } else {
            return getViews()[viewControllerIndex-1]
        }
    }

    
    func configurePageControl() {
        pageControl.isHidden = false
        if self.view.subviews.count == 1{
            pageControl = UIPageControl(frame: CGRect(x: 0,y: self.view.bounds.maxY - 40,width: self.view.bounds.width,height: 50))
            self.pageControl.tintColor = UIColor.black
            self.pageControl.pageIndicatorTintColor = UIColor.white
            self.pageControl.currentPageIndicatorTintColor = UIColor.black
            self.view.addSubview(pageControl)

        }
        
        self.pageControl.numberOfPages = getViews().count
//        self.pageControl.currentPage = getViews().index(of: viewController)

    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int
    {
        return 0
    }
    
    func doHide() {
        for v in getViews(){
            let tvc = v as! TopViewController
            tvc.hTopInstrument.isHidden = true
            tvc.vTopInstrument.isHidden = true
            tvc.hTopShadow.isHidden = true
            tvc.vTopShadow.isHidden = true
        }
        pageControl.isHidden = true
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = getViews().index(of: viewController) else {
            return nil
        }
        if viewControllerIndex == getViews().count - 1 {
            return nil
        } else {
            return getViews()[viewControllerIndex+1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = getViews().index(of: pageContentViewController)!
    }
    
    func newVc(viewController:String,instrument:String,direction:String) -> UIViewController {
        let vc = UIStoryboard(name:"Main",bundle:nil).instantiateViewController(withIdentifier: "main") as! TopViewController
        var _ = vc.view
        vc.hTopInstrument.image = UIImage(named:instrument)
        vc.vTopInstrument.image = UIImage(named:instrument)
        if direction == "vertical"{
            vc.hTopInstrument.isHidden = true
            vc.hTopShadow.isHidden = true
            vc.vTopInstrument.isHidden = false
            vc.vTopShadow.isHidden = false
        } else {
            vc.vTopInstrument.isHidden = true
            vc.vTopShadow.isHidden = true
            vc.hTopInstrument.isHidden = false
            vc.hTopShadow.isHidden = false
        }
        return vc
    }

    func getViews() -> [UIViewController]{
        if allViews.count > 0 {
            return allViews
        } else {
            for view in views {
                allViews.append(self.newVc(viewController: "main",instrument:view["instrument"]!,direction:view["direction"]!) as! TopViewController)
            }
            return allViews
        }
    }

    override func viewDidLoad() {
        for v in self.view.subviews{
            if v == pageControl{
                v.removeFromSuperview()
            }
        }

        super.viewDidLoad()
        self.dataSource = nil
        self.dataSource = self
        self.delegate = self
        configurePageControl()
        doMove()
        
        if let firstViewController = getViews().first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: false,
                               completion: nil)
        }

        // Do any additional setup after loading the view.
    }
    
    func doMove() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
