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
    
    private let tableView = TableView()
    
    let array = [
        CellColor(color: .red, label: "red"),
        CellColor(color: .yellow, label: "yellow"),
        CellColor(color: .brown, label: "brown"),
        CellColor(color: .blue, label: "blue"),
        CellColor(color: .green, label: "green"),
        CellColor(color: .purple, label: "purple")
    ]

    
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

extension ViewController: TableViewDataSource {
    func numberOfRows(in tableView: TableView) -> Int {
        array.count
    }
    
    func tableView(_ tableView: TableView, cellForRowAt row: Int) -> TableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return TableViewCell(reuseIdentifier: "cell")
        }
        
        let number = array[row]
        
        cell.label.text = number.label
        cell.backgroundColor = number.color
   
        return cell
    }
}

