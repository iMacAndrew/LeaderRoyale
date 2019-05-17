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
            UserDefaults.standard.set(true, forKey: "seenOnboard")
            dismiss(animated: true)
        } else {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .beginFromCurrentState, animations: {
                self.scrollView.contentOffset.x = CGFloat(nextPageIndex) * self.view.frame.width
            })
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

        UIView.animate(withDuration: 0.1, delay: 0.0, options: .beginFromCurrentState, animations: {
            if (percentOffset.x > 0 && percentOffset.x <= 0.25) {

                self.slides[0].image.transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
                self.slides[1].image.transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)

            } else if(percentOffset.x > 0.25 && percentOffset.x <= 0.50) {
                self.slides[1].image.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.25, y: (0.50-percentOffset.x)/0.25)
                self.slides[2].image.transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)

            } else if(percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
                self.slides[2].image.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.25, y: (0.75-percentOffset.x)/0.25)
                self.slides[3].image.transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)

            } else if(percentOffset.x > 0.75 && percentOffset.x <= 1) {
                self.slides[3].image.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.25, y: (1-percentOffset.x)/0.25)
                self.slides[4].image.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
            }
        })

    }

    func createSlides() -> [Slide] {

        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.image.image = UIImage(named: "crown")
        slide1.imageWidthConstraint.constant = 150
        slide1.titleLabel.text = "Welcome to Leader Royale!"
        slide1.descLabel.text = "Manage and lead your clans more efficiently."
        slide1.delegate = self

        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.image.image = UIImage(named: "membersOnboard")
        slide2.titleLabel.text = "Clan and Player Stats!"
        slide2.descLabel.text = "Easily view clan and player stats to see overall performance."
        slide2.delegate = self

        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.image.image = UIImage(named: "TwoKings")
        slide3.titleLabel.text = "Player Recognitions!"
        slide3.descLabel.text = "Weekly recognitions show best and worst performing clan members in different categories."
        slide3.delegate = self

        let slide4:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide4.image.image = UIImage(named: "recruits")
        slide4.titleLabel.text = "War Stats!"
        slide4.descLabel.text = "View war logs with member participation and win rates. Keep track of which members have skipped, lost, or won their war day battles."
        slide4.delegate = self

        let slide5:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide5.image.image = UIImage(named: "barbarianThinking")
        slide5.titleLabel.text = "Memory Game!"
        slide5.descLabel.text = "Test out your memory with the card matching mini game."
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
