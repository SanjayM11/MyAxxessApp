//
//  DetailViewController.swift
//  MyAxxessApp
//
//  Created by Sanjay Mohnani on 28/07/20.
//  Copyright © 2020 Sanjay Mohnani. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    // MARK:- member declarations
    private var record : Record!
    private var scrollView : UIScrollView!
    private var baseView : UIView!
    private var idLabel : UILabel!
    private var dateLabel : UILabel!
    private var typeLabel : UILabel!
    private var dataLabel : UILabel!
    private var imgView : UIImageView!
    
    // MARK:- life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = StringLiteral.kDetailView
        self.view.backgroundColor = UIColor.white
        createView()
    }
    
    init(withRecord record: Record) {
        super.init(nibName: nil, bundle: nil)
        self.record = record
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Private helper methods
    private func createView(){
        scrollView = UIScrollView.init(frame: .zero)
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    
        baseView = UIView.init(frame: .zero)
        baseView.frame.size.width = self.view.frame.size.width
        
        createIdLabel()
        
        createDateLabel()
        
        createTypeLabel()
        
        let height:CGFloat = createDetailedView()
        
        baseView.frame.size.width = self.view.frame.size.width
        baseView.frame.size.height = height
        
        scrollView.addSubview(baseView)
        scrollView.contentSize = CGSize.init(width: self.view.frame.size.width, height: height)
        baseView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func createIdLabel(){
        idLabel = UILabel.init(frame: .zero)
        idLabel.adjustsFontSizeToFitWidth = true
        baseView.addSubview(idLabel)
        idLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.left.equalToSuperview().offset(10)
            $0.width.equalTo(self.view.frame.size.width - 20)
            $0.height.equalTo(20)
            $0.right.equalToSuperview().offset(-10)
        }
        idLabel.textAlignment = .center
        idLabel.text = ""
        if let text = record.id{
            idLabel.text = StringLiteral.kID + text
        }
    }
    
    private func createDateLabel(){
        dateLabel = UILabel.init(frame: .zero)
        baseView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints{
            $0.top.equalTo(idLabel).offset(30)
            $0.left.equalToSuperview().offset(10)
            $0.height.equalTo(20)
            $0.right.equalToSuperview().offset(-10)
        }
        dateLabel.textAlignment = .center
        dateLabel.text = ""
        if let text = record.date{
            dateLabel.text = StringLiteral.kDate + text
        }
    }
    
    private func createTypeLabel(){
        typeLabel = UILabel.init(frame: .zero)
        baseView.addSubview(typeLabel)
        typeLabel.snp.makeConstraints{
            $0.top.equalTo(dateLabel).offset(30)
            $0.left.equalToSuperview().offset(10)
            $0.height.equalTo(20)
            $0.right.equalToSuperview().offset(-10)
        }
        typeLabel.textAlignment = .center
        typeLabel.text = ""
        if let text = record.type{
            typeLabel.text = StringLiteral.kType + text
        }
    }
    
    private func createDetailedView() -> CGFloat{
        var height:CGFloat = 110
        if let type = record.type, type == StringLiteral.kText.lowercased(){
            dataLabel = UILabel.init(frame: .zero)
            dataLabel.numberOfLines = 0
            baseView.addSubview(dataLabel)
            dataLabel.snp.makeConstraints{
                $0.top.equalTo(typeLabel).offset(30)
                $0.width.equalToSuperview().offset(-20)
                $0.left.equalToSuperview().offset(10)
                $0.right.equalToSuperview().offset(-10)
                $0.bottom.equalToSuperview().offset(-10)
            }
            dataLabel.textAlignment = .center
            if let text = record.data{
                dataLabel.text = text
            }
            height = height + dataLabel.frame.size.height
        }else{
            imgView = UIImageView.init(frame: .zero)
            imgView.contentMode = .scaleAspectFit
            baseView.addSubview(imgView)
            imgView.snp.makeConstraints{
                $0.top.equalTo(typeLabel).offset(30)
                $0.width.equalToSuperview().offset(-20)
                $0.left.equalToSuperview().offset(10)
                $0.right.equalToSuperview().offset(-10)
                $0.bottom.equalToSuperview().offset(-10)
            }
            if let urlString = record.data{
                loadImageFromUrl(urlString)
            }
            height = height + imgView.frame.size.height
        }
        return height
    }
    
    private func loadImageFromUrl(_ urlString : String){
        imgView.loadThumbnail(urlSting: urlString){ (flag) in
            if flag == true{
                DispatchQueue.main.async {
                    if let image = self.imgView.image{
                        let height =  (self.imgView.frame.width * image.size.height) /  image.size.width
                        self.imgView.frame.size.height = height
                        self.scrollView.contentSize = CGSize.init(width: self.view.frame.size.width, height: 110 + height)
                    }
                }
            }
        }
    }
}
