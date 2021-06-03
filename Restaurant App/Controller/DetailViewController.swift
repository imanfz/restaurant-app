//
//  DetailViewController.swift
//  Restaurant App
//
//  Created by Iman Faizal on 02/06/21.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController {

    @IBOutlet weak var nameRestaurant: UILabel!
    @IBOutlet weak var photoRestaurant: UIImageView!
    @IBOutlet weak var addressRestaurant: UILabel!
    @IBOutlet weak var cityRestaurant: UILabel!
    @IBOutlet weak var categoriesRestaurant: UILabel!
    @IBOutlet weak var titleDesc: UILabel!
    @IBOutlet weak var descRestaurant: UILabel!
    
    var url = "https://restaurant-api.dicoding.dev/detail/"
    var restaurant: Restaurant?
    
    // MARK: - Properties
    let loadingIndicator: ProgressView = {
        let progress = ProgressView(colors: [.red, .systemGreen, .systemBlue], lineWidth: 5)
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        loadingIndicator.isAnimating = true
        
        if let result = restaurant {
            url = url + result.id
            fetchData()
        }
    
        navigationItem.title = "Detail"
    }

    private func fetchData() {
        AF.request(url).validate().responseDecodable(of: DetailRestaurants.self) { (response) in
            guard let result = response.value else {return}
            self.showData(detail: result.restaurant)
            self.loadingIndicator.isAnimating = false
        }
    }
    
    private func showData(detail: DetailRestaurant) {
        nameRestaurant.text = detail.name
        let url = URL(string: "https://restaurant-api.dicoding.dev/images/large/\(detail.pictureId)")!
        let data = try? Data(contentsOf: url)
        photoRestaurant.image = UIImage(data: data!)
        addressRestaurant.text = "Address\t: " + detail.address
        cityRestaurant.text = "City\t\t: " + detail.city
        
        var category = ""
        for categories in detail.categories {
            if category == "" {
                category.append(categories.name)
            } else {
                category.append(", " + categories.name)
            }
        }
        
        categoriesRestaurant.text = "Category\t: " + category
        titleDesc.text = "Description\t:"
        descRestaurant.text = detail.description
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
            
        self.view.backgroundColor = .white
            
        self.view.addSubview(loadingIndicator)

        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor
                .constraint(equalTo: self.view.centerXAnchor),
            loadingIndicator.centerYAnchor
                .constraint(equalTo: self.view.centerYAnchor),
            loadingIndicator.widthAnchor
                .constraint(equalToConstant: 50),
            loadingIndicator.heightAnchor
                .constraint(equalTo: self.loadingIndicator.widthAnchor)
        ])
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
