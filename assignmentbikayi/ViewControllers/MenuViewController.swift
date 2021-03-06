//
//  MenuViewController.swift
//  assignmentbikayi
//
//  Created by Arsh Jain on 18/02/22.
//

import UIKit

protocol MenuViewControllerDelegate: AnyObject{
    func didSelect(menuItem: MenuViewController.menuOptions)
}

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: MenuViewControllerDelegate?
    
    enum menuOptions: String, CaseIterable{
        case Home = "Home"
        case NoblePrizeWinnersList = "Noble Prize Winners List"
        case settings = "Settings"
        
        var imageName: String{
            switch self {
            case .Home:
                return "house"
            case .NoblePrizeWinnersList:
                return "gift"
            case .settings:
                return "gear"
            }
        }
    }
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    let greyColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha:1)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = greyColor
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.backgroundColor = nil
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.size.width, height: view.bounds.size.height)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menuOptions.allCases[indexPath.row].rawValue
        cell.textLabel?.textColor = .white
        cell.imageView?.image = UIImage(systemName: menuOptions.allCases[indexPath.row].imageName)
        cell.imageView?.tintColor = .white
        cell.backgroundColor = greyColor
        cell.contentView.backgroundColor = greyColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = menuOptions.allCases[indexPath.row]
        delegate?.didSelect(menuItem: item)
        
    }
}
