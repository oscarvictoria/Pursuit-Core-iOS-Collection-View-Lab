//
//  ViewController.swift
//  CollectionViewsLab
//
//  Created by Oscar Victoria Gonzalez  on 1/15/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit
import ImageKit

class ViewController: UIViewController {

    var country = [Countries]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }


@IBOutlet weak var collectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCountries()
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    func loadCountries() {
        CountriesAPIClient.getCountries { (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let countries):
                self.country = countries
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let countryDVC = segue.destination as? CountryDVC,
            let indexpath = collectionView.indexPathsForSelectedItems?.first else {
                fatalError("error")
        }
        let theCountry = country[indexpath.row]
        countryDVC.country = theCountry
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return country.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as? CountryCell else {
            fatalError("could not get cell")
        }
        let countryCell = country[indexPath.row]
        let imageURL = "https://www.countryflags.io/\(countryCell.alpha2Code)/shiny/64.png"
        cell.countryImageView.getImage(with: imageURL) { (result) in
            switch result {
            case .failure(let appError):
                print("app error \(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    cell.countryImageView.image = image
                }
            }
        }
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
