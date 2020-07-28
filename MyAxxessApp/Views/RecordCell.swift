//
//  RecordCell.swift
//  MyAxxessApp
//
//  Created by Sanjay Mohnani on 27/07/20.
//  Copyright © 2020 Sanjay Mohnani. All rights reserved.
//

import UIKit

class RecordCell: UITableViewCell {
    // MARK:- member declarations
    static let identifier: String = "RecordCellIdentifier"
    private var baseView: UIView!
    private var idLabel: UILabel!
    private var dateLabel: UILabel!
    private var descriptionLabel : UILabel!
    var imgView : UIImageView!

    // MARK:- life cycle methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configure()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- private methods
    private func configure() {
        self.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)

        baseView = UIView(frame: .zero)
        baseView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        baseView.roundCorners(corners: [.layerMinXMaxYCorner,
                                        .layerMaxXMinYCorner,
                                        .layerMinXMinYCorner,
                                        .layerMaxXMaxYCorner], radius: 10)
        self.contentView.addSubview(baseView)
        baseView.snp.makeConstraints {
            $0.left.top.equalToSuperview().offset(10)
            $0.bottom.right.equalToSuperview().offset(-10)
        }
        
        createIdLabel()
        
        createDateLabel()
        
        createDetailView()
    }
    
    private func createIdLabel(){
        // id label creation
        idLabel = UILabel(frame: .zero)
        baseView.addSubview(idLabel)
        idLabel.adjustsFontSizeToFitWidth = true
        idLabel.font = UIFont.init(name: FontName.kTimesNewRoman, size: 16)
        idLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.top.equalToSuperview().offset(10)
            $0.width.equalToSuperview().multipliedBy(0.75)
        }
    }
    
    private func createDateLabel(){
        // date label creation
        dateLabel = UILabel(frame: .zero)
        dateLabel.font = UIFont.init(name: FontName.kTimesNewRoman, size: 14)
        baseView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-10)
            $0.top.equalToSuperview().offset(10)
        }
    }
    
    private func createDetailView(){
        // description label creation
        descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.font = UIFont.init(name: FontName.kTimesNewRoman, size: 15)
        descriptionLabel.numberOfLines = 0
        baseView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.top.equalTo(idLabel.snp_bottomMargin).offset(10)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        imgView = UIImageView(frame: .zero)
        baseView.addSubview(imgView)
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.right.equalToSuperview().offset(-10)
            $0.top.equalTo(idLabel.snp_bottomMargin).offset(10)
            //$0.height.equalTo(100)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
    
    // MARK:- public methods
    func reuseCellForRecord(_ record : Record){
        self.idLabel.text = ""
        self.dateLabel.text = ""
        if let id = record.id{
            self.idLabel.text = id
        }
        if let date = record.date{
            self.dateLabel.text = date
        }
        self.imgView.image = nil
        self.descriptionLabel.text = ""
        imgView.snp.removeConstraints()
        descriptionLabel.snp.removeConstraints()
        if let type = record.type{
            if type == StringLiteral.kImage.lowercased(){
                if let data = record.data{
                    self.imgView.isHidden = false
                    self.imgView.image = self.imgView.getImageFromCache(urlSting: data)
                    var height = 0
                    if let image = self.imgView.image{
                        height =  Int(((self.frame.width - 20) * image.size.height) /  image.size.width)
                    }
                    imgView.snp.makeConstraints {
                        $0.left.equalToSuperview().offset(10)
                        $0.right.equalToSuperview().offset(-10)
                        $0.top.equalTo(idLabel.snp_bottomMargin).offset(10)
                        $0.height.equalTo(height)
                        $0.bottom.equalToSuperview().offset(-10)
                    }
                }
            }else{
                if let data = record.data{
                    self.descriptionLabel.text = data
                    self.descriptionLabel.isHidden = false
                    descriptionLabel.snp.makeConstraints {
                        $0.left.equalToSuperview().offset(10)
                        $0.right.equalToSuperview().offset(-10)
                        $0.top.equalTo(idLabel.snp_bottomMargin).offset(10)
                        $0.bottom.equalToSuperview().offset(-10)
                    }
                }
            }
        }
    }
}
