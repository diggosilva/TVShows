//
//  ViewController.swift
//  TVShows
//
//  Created by Diggo Silva on 21/03/25.
//

import UIKit

class FeedViewController: UIViewController {
    
    let service = Service()
    var listShows: [Show] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "TV Shows"
        
        service.getShows(url: "shows") { result in
            
        }
    }

}
