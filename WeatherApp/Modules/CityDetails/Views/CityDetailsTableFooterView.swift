//
//  CityDetailsTableFooterView.swift
//  WeatherApp
//
//  Created by RuslanKa on 02.11.2019.
//  Copyright © 2019 RuslanKa. All rights reserved.
//

import UIKit

final class CityDetailsTableFooterView: UITableViewHeaderFooterView {
    
    static var className: String {
        return String(describing: self)
    }
    
    var delegate: CityDetailsTableFooterDelegate?
    
    @IBOutlet weak var button: UIButton!
    
    @IBAction func buttonAction(_ sender: UIButton) {
        delegate?.footerTouched()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = UIColor(white: 0, alpha: 0.3)
    }
    
    func setup(with text: String) {
        button.setTitle(text, for: .normal)
    }
}
