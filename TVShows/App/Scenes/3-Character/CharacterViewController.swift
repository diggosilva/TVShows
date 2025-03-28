//
//  CharacterViewController.swift
//  TVShows
//
//  Created by Diggo Silva on 26/03/25.
//

import UIKit

class CharacterViewController: UIViewController {
    
    let characterView = CharacterView()
    
    override func loadView() {
        super.loadView()
        view = characterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
