//
//  ScrollViewController.swift
//  ZXReader
//
//  Created by 曾富田 on 2016/12/22.
//  Copyright © 2016年 刘成军. All rights reserved.
//

import UIKit

protocol ScrollViewControllerDelegate: class {
    func pushMainView()
}

class ScrollViewController: UIViewController,UIScrollViewDelegate {
    
    var scrollView: UIScrollView!
    var pageControl: UIPageControl!
    weak var delegate: ScrollViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)
        
//        scrollView.snp.makeConstraints { (make) in
//            make.edges.equalTo(self.view)
//        }
        
        scrollView.contentSize = CGSize(width: self.view.width*3, height: self.view.height)
        scrollView.isPagingEnabled = true
        
        let imageViewOne = UIImageView()
        imageViewOne.image = UIImage(named: "kc_img_guide_3")
        imageViewOne.contentMode = .scaleToFill
        scrollView.addSubview(imageViewOne)
        imageViewOne.frame = CGRect(x: 0, y: 0, width: self.view.width, height: self.view.height)
        
        let imageViewTwo = UIImageView()
        imageViewTwo.image = UIImage(named: "kc_img_guide_2")
        scrollView.addSubview(imageViewTwo)
        imageViewTwo.contentMode = .scaleToFill
        imageViewTwo.frame = CGRect(x: self.view.width, y: 0, width: self.view.width, height: self.view.height)
        
        let imageViewThree = UIImageView()
        imageViewThree.image = UIImage(named: "kc_img_guide_1")
        imageViewThree.isUserInteractionEnabled = true
        scrollView.addSubview(imageViewThree)
        imageViewThree.contentMode = .scaleToFill
        imageViewThree.frame = CGRect(x: self.view.width*2, y: 0, width: self.view.width, height: self.view.height)
        
//        let button = UIButton()
//        button.backgroundColor = UIColor.white
//        button.setTitle("点击进入", for: UIControlState())
//        button.setTitleColor(UIColor(rgba:"#485b7e"), for: UIControlState())
//        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
//        imageViewThree.addSubview(button)
        
//        button.snp.makeConstraints { (make) in
//            make.right.equalTo(imageViewThree).offset(-44)
//            make.bottom.equalTo(imageViewThree).offset(-64)
//            make.size.equalTo(CGSize(width: 120, height: 40))
//        }
        
        pageControl = UIPageControl()
        pageControl.backgroundColor = UIColor.clear
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        self.view.addSubview(pageControl)
        
//        pageControl.snp.makeConstraints { (make) in
//            make.centerX.equalTo(self.view)
//            make.bottom.equalTo(self.view).offset(-40)
//            make.size.equalTo(CGSize(width: 124, height: 40))
//        }
        
        
        // Do any additional setup after loading the view.
    }
    
    //UIScrollViewDelegate方法，每次滚动结束后调用
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //通过scrollView内容的偏移计算当前显示的是第几页
        let page = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        //设置pageController的当前页
        pageControl.currentPage = page
    }
    
    func tapButton() {
        self.delegate.pushMainView()
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
