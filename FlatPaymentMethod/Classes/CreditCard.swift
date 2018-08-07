//
//  CreditCard.swift
//  FlatPaymentMethod
//
//  Created by Ampe on 8/6/18.
//

import Foundation

@IBDesignable
open class CreditCard: UIView {
    
    // MARK: Views
    open weak var cardView: UIView!
    open weak var cardLogo: UIImage!
    open weak var numberLabel: UILabel!
    open weak var ccvLabel: UILabel!
    open weak var dateLabel: UILabel!
    open weak var nameLabel: UILabel!
    
    // MARK: Designable Initalizers
    public convenience init() {
        
        self.init(frame: CGRect.zero)
    }
    
    public override convenience init(frame: CGRect) {
        
        self.init(frame: frame)
    }
    
    // MARK: Programmatic Initalizer
    public init(_ frame: CGRect) {
        
        let cardView = UIView()
        self.cardView = cardView
        
        let cardLogo = UIImage()
        self.cardLogo = cardLogo
        
        let numberLabel = UILabel()
        self.numberLabel = numberLabel
        
        let ccvLabel = UILabel()
        self.ccvLabel = ccvLabel
        
        let dateLabel = UILabel()
        self.dateLabel = dateLabel
        
        let nameLabel = UILabel()
        self.nameLabel = nameLabel
        
        super.init(frame: frame)
        
        initViews()
        
        addViews()
        addConstraints()
    }
    
    // MARK: Storyboard Initalizer
    public required init?(coder aDecoder: NSCoder) {
        
        let cardView = UIView()
        self.cardView = cardView
        
        let cardLogo = UIImage()
        self.cardLogo = cardLogo
        
        let numberLabel = UILabel()
        self.numberLabel = numberLabel
        
        let ccvLabel = UILabel()
        self.ccvLabel = ccvLabel
        
        let dateLabel = UILabel()
        self.dateLabel = dateLabel
        
        let nameLabel = UILabel()
        self.nameLabel = nameLabel
        
        super.init(coder: aDecoder)
        
        initViews()
        
        addViews()
        addConstraints()
    }
}

private extension CreditCard {
    func initViews() {
        
        cardView.layer.borderWidth = 1.0
        cardView.layer.cornerRadius = 8.0
        cardView.layer.borderColor = UIColor.black.cgColor
        
        numberLabel.text = "••••  ••••  ••••  3847"
        
        ccvLabel.text = "•••"
        
        dateLabel.text = "07/22"
        
        nameLabel.text = "CHRISTIAN AMPE"
    }
    
    func addViews() {
        
        addSubview(cardView)
        addSubview(numberLabel)
        addSubview(ccvLabel)
        addSubview(dateLabel)
        addSubview(nameLabel)
    }
    
    func addConstraints() {
        
        addCardViewConstraints()
        addCardLogoConstraints()
        addNumberLabelConstraints()
        addCCVLabelConstraints()
        addDateLabelConstraints()
        addNameLabelConstraints()
    }
    
    func addCardViewConstraints() {
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        cardView.widthAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: PaymentConstants.creditCardAspectRatio).isActive = true
        
        if frame.width/frame.height >= PaymentConstants.creditCardAspectRatio {
            cardView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            cardView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        } else {
            cardView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            cardView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            cardView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        }
        
        cardView.layoutIfNeeded()
    }
    
    func addCardLogoConstraints() {
        
    }
    
    func addNumberLabelConstraints() {
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        numberLabel.bottomAnchor.constraint(equalTo: ccvLabel.topAnchor).isActive = true
        numberLabel.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: cardView.frame.height/10).isActive = true
    }
    
    func addCCVLabelConstraints() {
        ccvLabel.translatesAutoresizingMaskIntoConstraints = false
        
        ccvLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -cardView.frame.height/20).isActive = true
        ccvLabel.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: cardView.frame.height/10).isActive = true
    }
    
    func addDateLabelConstraints() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dateLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: cardView.frame.height/10).isActive = true
    }
    
    func addNameLabelConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -cardView.frame.height/10).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: cardView.frame.height/10).isActive = true
    }
}
