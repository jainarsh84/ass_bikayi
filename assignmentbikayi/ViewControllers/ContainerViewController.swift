//
//  ViewController.swift
//  assignmentbikayi
//
//  Created by Arsh Jain on 18/02/22.
//

import UIKit

class ContainerViewController: UIViewController {
    
    enum MenuState{
        case open
        case closed
    }
    private var menuState: MenuState = .closed
    
    let menuVC = MenuViewController()
    let homeVC = HomeViewController()
    var navVC = UINavigationController()
    lazy var  prizeVC = PrizeListViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        addchildVCs()
    }
    
    
    private func addchildVCs(){
        
        //Menu
        menuVC.delegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        
        //Home
        homeVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
        
    }
}

extension ContainerViewController: HomeViewControllerDelegate{
    func didTapMenuButton() {
        toggleMenu(completion: nil)
    }
    func toggleMenu(completion: (()-> Void)?){
        switch menuState{
        case .closed:
            //open it
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [.curveEaseInOut]) {
                self.navVC.view.frame.origin.x = self.homeVC.view.frame.width - 100
            } completion: { [weak self] done in
                if done{
                    self?.menuState = .open
                }
            }

        
        case .open:
            //close it
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [.curveEaseInOut]) {
                self.navVC.view.frame.origin.x = 0
            } completion: { [weak self] done in
                if done{
                    self?.menuState = .closed
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
        }
    }
}
extension ContainerViewController: MenuViewControllerDelegate{
    
    func didSelect(menuItem: MenuViewController.menuOptions) {
        toggleMenu(completion: nil)
            switch menuItem{
            case .Home:
                self.resetToHome()
                
            case .NoblePrizeWinnersList:
                self.addPrize()
                
            case .settings:
                break
            }
        }
    
    func addPrize(){
        
        let vc = prizeVC
        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: homeVC)
        homeVC.title = vc.title
    }
    
    func resetToHome(){
        prizeVC.view.removeFromSuperview()
        prizeVC.didMove(toParent: nil)
        homeVC.title = "Home"
        
    }
}
