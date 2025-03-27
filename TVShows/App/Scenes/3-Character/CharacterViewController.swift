//
//  CharacterViewController.swift
//  TVShows
//
//  Created by Diggo Silva on 26/03/25.
//

import UIKit

class CharacterViewController: UIViewController {
    
    let charView = CharacterView()
    
    override func loadView() {
        super.loadView()
        view = charView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
