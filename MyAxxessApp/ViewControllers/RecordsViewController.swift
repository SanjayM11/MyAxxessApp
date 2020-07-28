//
//  RecordsViewController.swift
//  MyAxxessApp
//
//  Created by Sanjay Mohnani on 27/07/20.
//  Copyright © 2020 Sanjay Mohnani. All rights reserved.
//

import UIKit
import SnapKit

class RecordsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK:- member declarations
    private var tableView : UITableView!
    private var label : UILabel!
    private var segmentControl : UISegmentedControl!
    private var records = [Record]()
    private let rechability = try! Reachability()
    
    // MARK:- life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = StringLiteral.kRecords
        
        addSortByLabel()
        addSegmentControl()
        createTableView()
        getRecords()
    }
    
    // MARK:- Private helper methods
    private func addSortByLabel(){
        label = UILabel(frame: .zero)
        self.view.addSubview(label)
        label.text = StringLiteral.kSortBy
        label.sizeToFit()
        label.textColor = UIColor.white
        label.snp.makeConstraints{
            $0.top.equalToSuperview().offset(70)
            $0.left.equalToSuperview().offset(10)
            $0.width.equalTo(100)
            $0.height.equalTo(40)
        }
    }
    
    private func addSegmentControl() {
        let segmentItems = [StringLiteral.kNone, StringLiteral.kText, StringLiteral.kImage]
        segmentControl = UISegmentedControl(items: segmentItems)
        self.view.addSubview(segmentControl)
        segmentControl.snp.makeConstraints {
            $0.top.equalToSuperview().offset(70)
            $0.left.equalTo(label.frame.size.width + 10 + 10)
            $0.right.equalToSuperview().offset(-10)
            $0.height.equalTo(40)
        }
        segmentControl.addTarget(self, action: #selector(segmentControl(_:)), for: .valueChanged)
        segmentControl.selectedSegmentIndex = 0
    }
    
    @objc func segmentControl(_ segmentedControl: UISegmentedControl) {
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            // Zeroth segment tapped
            break
        case 1:
            // First segment tapped
            records = records.sorted { (record1, record2) -> Bool in
                if record1.type == StringLiteral.kText.lowercased(), record2.type == StringLiteral.kImage.lowercased(){
                    return true
                }
                return false
            }
            self.tableView.reloadData()
            self.tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: true)
        case 2:
            // Second segment tapped
            records = records.sorted { (record1, record2) -> Bool in
                if record1.type == StringLiteral.kImage.lowercased(), record2.type == StringLiteral.kText.lowercased(){
                    return true
                }
                return false
            }
            self.tableView.reloadData()
            self.tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: true)
        default:
            break
        }
    }
    
    private func createTableView(){
        tableView = UITableView(frame: .zero)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(segmentControl).offset(50)
            $0.left.right.bottom.equalToSuperview()
        }
        tableView.separatorStyle = .singleLine
        tableView.register(RecordCell.self, forCellReuseIdentifier: RecordCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 100
    }
    
    private func getRecords(){
        if rechability.connection != .unavailable{
            APIManager.getRecords {[weak self] (records, error) in
                if let error = error{
                    print(error)
                }
                else if let records = records{
                    self?.records = records
                    if let records = self?.records{
                        DatabaseManager.shared.deleteAllRecordsFromDb()
                        DatabaseManager.shared.saveRecordsInDB(records: records)
                    }
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            }
        }
        else{
            self.records = DatabaseManager.shared.getRecordsFromDB()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK:- Table view datasource & delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecordCell.identifier, for: indexPath) as! RecordCell
        let record = records[indexPath.item]
        cell.tag = indexPath.row
        cell.reuseCellForRecord(record)
        if let type = record.type, type == StringLiteral.kImage.lowercased(), let url = record.data{
            let image = cell.imgView.getImageFromCache(urlSting: url)
            if image == nil{
                cell.imgView.loadThumbnail(urlSting: url, row: cell.tag) { (flag, image, row) in
                    if flag == true, cell.tag == row, let _ = image{
                        DispatchQueue.main.async {
                            tableView.reloadRows(at: [indexPath], with: .none)
                        }
                    }
                }
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let record = records[indexPath.item]
        let dvc = DetailViewController.init(withRecord: record)
        self.navigationController?.pushViewController(dvc, animated: true)
    }
}
