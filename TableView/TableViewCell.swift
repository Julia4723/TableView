//
//  TableViewCell.swift
//  TableView
//
//  Created by user on 06.11.2024.
//

import UIKit

class TableViewCell: UIView {
    var reuseIdentifier: String?
    
    var label = UILabel()
    
    required init(reuseIdentifier: String?) {
        self.reuseIdentifier = reuseIdentifier
        super.init(frame: .zero)
        setup()
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        
    }
    
    func prepareForReuse() {
        // Метод вызывается перед повторным использованием ячейки
    }
    
    private func setupLabel() {
           addSubview(label)
           label.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
               label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
               label.centerYAnchor.constraint(equalTo: centerYAnchor)
           ])
       }
}
