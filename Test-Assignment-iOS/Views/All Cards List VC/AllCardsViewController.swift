//
//  ViewController.swift
//  Test-Assignment-iOS
//
//  Created by Sofia Ksenofontova on 02.08.2023.
//

import UIKit
import SnapKit

final class AllCardsViewController: UIViewControllerWithCoordinator {
    
    //MARK: - Properties
    var cards : [CardModel] = []
    
    private lazy var plusBtn : UIButton = {
        let btn = UIButton()
        btn.layer.backgroundColor = UIColor.clear.cgColor
        
        if #available(iOS 13.0, *) {
            let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 25, weight: .light, scale: .large)
            btn.setImage(UIImage(systemName: "plus", withConfiguration: imageConfiguration), for: .normal)
        } else {
            btn.setImage(UIImage(named: "plus"), for: .normal)
        }
        btn.tintColor = .systemBlue
        return btn
    }()
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(MainCardsTableViewCell.self, forCellReuseIdentifier: MainCardsTableViewCell.reuseIdentifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = true
        tableView.allowsMultipleSelection = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        return tableView
    }()
    
    
    @objc func addNewCard(){
        SavedCardsManager.shared.saveCard(cardModel: CardModel())
        self.fetchDataFromDB()
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view.addSubview(self.tableView)
        
        self.setUpNavBar()
        self.setUpLayout()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
  
    }

    //MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        self.fetchDataFromDB()
    }
    
}

//MARK: - extension for utilities: layout set up + fetching DB objects
private extension AllCardsViewController{
    
    func fetchDataFromDB(){
        self.cards = SavedCardsManager.shared.convertCardsToModels(cardsArray: SavedCardsManager.shared.readCards()).sorted(by: {
            $0.timestamp < $1.timestamp
        })
        
        self.tableView.reloadData()
        
    }
    
    func setUpNavBar(){
        self.setUpNavigationTitle(text: "Картки")
        self.setUpRightNavBarItem(menuBtn: self.plusBtn, selector: #selector(self.addNewCard))
        
    }
    
    func setUpLayout(){
        self.tableView.snp.makeConstraints{
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension AllCardsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {1}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {self.cards.count}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MainCardsTableViewCell.reuseIdentifier, for: indexPath) as! MainCardsTableViewCell
        cell.selectionStyle = .none
        
        cell.config(card: self.cards[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! MainCardsTableViewCell
        cell.isSelected = true
        
        guard let coordinator = self.coordinator else { return }
        coordinator.openVCWithoutStoryboardWithParams(type: CardDetailsViewController.self, params: ["card": self.cards[indexPath.row]] )
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {CGFloat(70)}
    
}

