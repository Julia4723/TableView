//
//  ViewController.swift
//  TableView
//
//  Created by user on 06.11.2024.
//

import UIKit


struct CellColor {
    
    let color: UIColor
    let label: String
}


class ViewController: UIViewController {
    
    //MARK: - Private Property
    private let tableView = TableView()
    
    private let arrayCell = [
        CellColor(color: .red, label: "red"),
        CellColor(color: .yellow, label: "yellow"),
        CellColor(color: .brown, label: "brown"),
        CellColor(color: .blue, label: "blue"),
        CellColor(color: .green, label: "green"),
        CellColor(color: .purple, label: "purple")
    ]

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tableView.frame = view.bounds
        
        tableView.dataSource = self
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        
        tableView.reloadData()
    }
}


//MARK: - TableViewDataSource
extension ViewController: TableViewDataSource {
    func numberOfRows(in tableView: TableView) -> Int {
        arrayCell.count
    }
    
    func tableView(_ tableView: TableView, cellForRowAt row: Int) -> TableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return TableViewCell(reuseIdentifier: "cell")
        }
        
        let cellItem = arrayCell[row]
        
        cell.label.text = cellItem.label
        cell.backgroundColor = cellItem.color
   
        return cell
    }
}

