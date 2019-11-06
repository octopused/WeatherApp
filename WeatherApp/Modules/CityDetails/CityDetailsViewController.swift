//
//  CityDetailsViewController.swift
//  WeatherApp
//
//  Created by RuslanKa on 02.11.2019.
//  Copyright © 2019 RuslanKa. All rights reserved.
//

import UIKit

final class CityDetailsViewController: UIViewController {

    var output: CityDetailsViewOutput?
    var adapter: CityDetailsTableAdapter?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        output?.viewDidLoad()
    }

    func setupUI() {
        tableView.bounces = false
        tableView.rowHeight = UITableView.automaticDimension
        adapter?.bind(tableView: tableView)
    }
}

extension CityDetailsViewController: CityDetailsViewInput {
    func reloadView() {
        tableView.reloadData()
    }
    
    func set(weatherInfoList: [WeatherInfo], footerText: String, isShowTime: Bool) {
        adapter?.set(weatherInfos: weatherInfoList, isShowTime: isShowTime)
        adapter?.setFooterText(footerText)
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
}
