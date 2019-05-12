//
//  OnBoardingViewController.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 4/10/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import UIKit

class OnBoardingViewController: UIViewController,  UIScrollViewDelegate, nextButtonProtocol {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!

    var slides:[Slide] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self
        slides = createSlides()
        setupSlideScrollView(slides: slides)

        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
        view.backgroundColor = .dark
    }

    func didClickNext() {
        let nextPageIndex = pageControl.currentPage + 1
        if nextPageIndex >= pageControl.numberOfPages {
            dismiss(animated: true)
        } else {
            UIView.animate(withDuration: 0.5) {
                self.scrollView.contentOffset.x = CGFloat(nextPageIndex) * self.view.frame.width
            }
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)

        let maximumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x

        // vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y

        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maximumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset

        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)

        if(percentOffset.x > 0 && percentOffset.x <= 0.25) {

            slides[0].image.transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
            slides[1].image.transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)

        } else if(percentOffset.x > 0.25 && percentOffset.x <= 0.50) {
            slides[1].image.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.25, y: (0.50-percentOffset.x)/0.25)
            slides[2].image.transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)

        } else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
            slides[2].image.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.25, y: (0.75-percentOffset.x)/0.25)
            slides[3].image.transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)

        } else if(percentOffset.x > 0.75 && percentOffset.x <= 1) {
            slides[3].image.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.25, y: (1-percentOffset.x)/0.25)
            slides[4].image.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
        }

    }

    func createSlides() -> [Slide] {

        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.image.image = UIImage(named: "crown")
        slide1.titleLabel.text = "Welcome to Leader Royale!"
        slide1.descLabel.text = "Manage your clans"
        slide1.delegate = self

        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.image.image = UIImage(named: "crown")
        slide2.titleLabel.text = "Clan and Player Stats!"
        slide2.descLabel.text = "See how well your clan and each of the members \n are doing with helpful statistics"
        slide2.delegate = self

        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.image.image = UIImage(named: "crown")
        slide3.titleLabel.text = "Player Recognitions!"
        slide3.descLabel.text = "Easily see which members are current \n doing the best and the worst"
        slide3.delegate = self

        let slide4:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide4.image.image = UIImage(named: "crown")
        slide4.titleLabel.text = "War Stats!"
        slide4.descLabel.text = "Look through the clan war history to see \n war wins and player participation!"
        slide4.delegate = self

        let slide5:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide5.image.image = UIImage(named: "crown")
        slide5.titleLabel.text = ""
        slide5.descLabel.text = ""
        slide5.delegate = self

        return [slide1, slide2, slide3, slide4, slide5]
    }

    func setupSlideScrollView(slides : [Slide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true

        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }

}
