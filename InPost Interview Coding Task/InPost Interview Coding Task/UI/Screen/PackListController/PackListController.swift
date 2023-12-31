//
//  ViewController.swift
//  InPost Interview Coding Task
//
//  Created by Damian Piwowarski on 03/11/2022.
//

import UIKit

final class PackListController: UIViewController {

    @IBOutlet private(set) var stackView: UIStackView!
    @IBOutlet private(set) var scrollView: UIScrollView!
    
    private let pullToRefresh = UIRefreshControl()
    
    private let packNetworking = PackNetworking()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Lista przesyłek"
        
        view.backgroundColor = .groupViewGray
        
        setUp()
        loadPacks()
    }
    
    private func setUp() {
        scrollView.insertSubview(pullToRefresh, at: 0)
        pullToRefresh.addTarget(self, action: #selector(handlePullToRefresh), for: .valueChanged)
    }
    
    @objc
    private func handlePullToRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.loadPacks()
        }
    }
    
    private func loadPacks() {
        packNetworking.getPacks { [weak self] result in
            guard let self = self else { return }
            
            self.removePacks()
            
            if case .success(let packs) = result {
                let filteredPacks = packs.filter { $0.status != .unknown }
                let readyToPickupPacks = filteredPacks.filter { $0.status == .readyToPickup }.sortPacks()
                if readyToPickupPacks.isEmpty == false {
                    self.addGroupView("Gotowe do odbioru", isFirst: true)
                    readyToPickupPacks.forEach {
                        self.addPackView($0)
                    }
                }
                
                let restOfthePacks = filteredPacks.filter { $0.status != .readyToPickup }.sortPacks()
                if restOfthePacks.isEmpty == false {
                    self.addGroupView("Pozostałe")
                    restOfthePacks.forEach {
                        self.addPackView($0)
                    }
                }
            }
            
            self.pullToRefresh.endRefreshing()
        }
    }
    
    private func removePacks() {
        stackView.arrangedSubviews.forEach { subview in
            subview.removeFromSuperview()
        }
    }
    
    private func addGroupView(_ groupName: String?, isFirst: Bool = false) {
        let groupView = PackListGroupView(isFirst: isFirst)
        groupView.setup(groupName: groupName)
        stackView.addArrangedSubview(groupView)
    }
    
    private func addPackView(_ pack: Pack) {
        let packView = PackView()
        packView.setup(pack: pack)
        stackView.addArrangedSubview(packView)
    }
}
