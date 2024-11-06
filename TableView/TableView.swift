//
//  TableView.swift
//  TableView
//
//  Created by user on 06.11.2024.
//

import UIKit

protocol TableViewDataSource {
    func numberOfRows(in tableView: TableView) -> Int
    func tableView(_ tableView: TableView, cellForRowAt row: Int) -> TableViewCell
}

class TableView: UIScrollView {
    
    //MARK: - Private Property
    private var visibleCells: [TableViewCell] = []
    private var reusableCells: [String: [TableViewCell]] = [:]
    private var registeredCells: [String: TableViewCell.Type] = [:]
    
    
    //MARK: - Property
    var rowHeight: CGFloat = 44.0
    var dataSource: TableViewDataSource?
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        alwaysBounceVertical = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Methods
    // Метод для регистрации класса ячеек
    func register(_ cellClass: TableViewCell.Type, forCellReuseIdentifier identifier: String) {
        registeredCells[identifier] = cellClass
    }
    
    //Метод отвечает за полное обновление данных таблицы
    func reloadData() {
        //очищаем старые видимые ячейки
        for cell in visibleCells {
            recycleCell(cell)
        }
        visibleCells.removeAll()
        
        guard let dataSource = dataSource else {return}
        
        //получаем количество строк
        let numberOfRows = dataSource.numberOfRows(in: self)
        
        //устанавливаем контент на основе количества строк и высоты
        contentSize = CGSize(width: self.frame.width, height: CGFloat(numberOfRows) * rowHeight)
        
        for row in 0..<numberOfRows {
            //получаем ячейку и задаем ее параметры
            let cell = dataSource.tableView(self, cellForRowAt: row)
            cell.frame = CGRect(x: 0, y: CGFloat(row) * rowHeight, width: self.frame.width, height: rowHeight)
            addSubview(cell)
            visibleCells.append(cell)
        }
    }
    
    func dequeueReusableCell(withIdentifier identifier: String) -> TableViewCell? {
        var cells = reusableCells[identifier]
        if let cell = cells?.popLast() {
            return cell
        }
        
        if let cellClass = registeredCells[identifier] {
            let newCell = cellClass.init(reuseIdentifier: identifier)
            return newCell
        }
        
        return nil
    }
}



extension TableView {
    private func recycleCell(_ cell: TableViewCell) {
        guard let reuseIdentifier = cell.reuseIdentifier else { return}
        cell.prepareForReuse()
        
        if reusableCells[reuseIdentifier]?.count ?? 0 >= 3 {
            reusableCells[reuseIdentifier]?.removeFirst()
        }
        
        if reusableCells[reuseIdentifier] != nil {
            reusableCells[reuseIdentifier]?.append(cell)
        } else {
            reusableCells[reuseIdentifier] = [cell]
        }
        
        cell.removeFromSuperview()
    }
}
