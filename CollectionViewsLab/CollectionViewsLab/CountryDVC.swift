//
//  CountryDVC.swift
//  CollectionViewsLab
//
//  Created by Oscar Victoria Gonzalez  on 1/15/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class CountryDVC: UIViewController {
    
    var country: Countries?
    
    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        guard let countries = country else {
            fatalError("error")
        }
        let imageURL = "https://www.countryflags.io/\(countries.alpha2Code)/shiny/64.png"
        nameLabel.text = countries.name
        populationLabel.text = countries.population.description
        countryImageView.getImage(with: imageURL) { (result) in
            switch result {
            case .failure(let error):
                print("\(error)")
            case .success(let image):
                DispatchQueue.main.async {
                    self.countryImageView.image = image
                }
            }
        }
    }
}
