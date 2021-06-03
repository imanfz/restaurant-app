//
//  ViewController.swift
//  Restaurant App
//
//  Created by Iman Faizal on 29/05/21.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var restaurantTableView: UITableView!
    
    var restaurant = [Restaurant]()
    var count = 0
    var request = AF.request("https://restaurant-api.dicoding.dev/list")
    var vSpinner: UIView?
    
    // MARK: - Properties
    let loadingIndicator: ProgressView = {
        let progress = ProgressView(colors: [.red, .systemGreen, .systemBlue], lineWidth: 5)
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //self.showSpinner(onView: self.view)
        restaurantTableView.isHidden = true
        self.setupUI()
        loadingIndicator.isAnimating = true
        fetchData()
        
        restaurantTableView.dataSource = self
        restaurantTableView.delegate = self
        restaurantTableView.register(UINib(nibName: "RestaurantTableViewCell", bundle: nil), forCellReuseIdentifier: "RestaurantCell")
        
        let view = UIView()
        let button = UIButton(type: .system)
        button.semanticContentAttribute = .forceRightToLeft
        button.setImage(UIImage(systemName: "person.fill"), for: .normal)
        //button.setTitle("Profile", for: .normal)
        button.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchDown)
        button.sizeToFit()
        view.addSubview(button)
        view.frame = button.bounds
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: view)
        
        //navigationItem.title = "Restaurant App"
    }
    
    @objc func buttonClicked(sender: UIBarButtonItem) {
        let profile = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
            
        // Push/mendorong view controller lain
        self.navigationController?.pushViewController(profile, animated: true)
    }
    
    private func fetchData() {
        request.validate().responseDecodable(of: Restaurants.self) { (response) in
            guard let result = response.value else {return}
            self.restaurant = result.restaurants
            self.count = result.count as Int
            
            self.restaurantTableView.reloadData()
            self.restaurantTableView.isHidden = false
            self.loadingIndicator.isAnimating = false
        }
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
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as? RestaurantTableViewCell {
            let restaurant = restaurant[indexPath.row]
            let url = URL(string: "https://restaurant-api.dicoding.dev/images/medium/\(restaurant.pictureId)")!
            let data = try? Data(contentsOf: url)
            cell.photoRestaurant.image = UIImage(data: data!)
            cell.nameRestaurant.text = restaurant.name
            cell.descRestaurant.text = restaurant.description
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Memanggil View Controller dengan berkas NIB/XIB di dalamnya
        let detail = DetailViewController(nibName: "DetailViewController", bundle: nil)
            
        // Mengirim data hero
        detail.restaurant = restaurant[indexPath.row]
            
        // Push/mendorong view controller lain
        self.navigationController?.pushViewController(detail, animated: true)
    }
}

extension ViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
}
