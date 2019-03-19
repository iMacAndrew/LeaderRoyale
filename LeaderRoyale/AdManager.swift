//
//  AdManager.swift
//  LeaderRoyale
//
//  Created by Andy Humphries on 3/18/19.
//  Copyright © 2019 Marz Software. All rights reserved.
//

import Foundation
import GoogleMobileAds

class AdManager {
    private var interstitial: GADInterstitial!

    static let shared = AdManager()

    private init() {
        GADMobileAds.configure(withApplicationID: "ca-app-pub-7190012204747216~1062489759")
    }

    func preload() {
        #if DEBUG
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        #else
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-7190012204747216/7047052401")
        #endif

        let request = GADRequest()
        interstitial.load(request)
    }

    func present(on viewController: UIViewController) {
        guard interstitial.isReady else {
            return
        }

        interstitial.present(fromRootViewController: viewController)
        preload()
    }
}
