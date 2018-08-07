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
    open weak var cardLogo: UIImageView!
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
        
        let cardLogo = UIImageView()
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
        
        let cardLogo = UIImageView()
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
        
        cardLogo.contentMode = .scaleAspectFit
        cardLogo.layer.borderColor = UIColor.black.cgColor
        cardLogo.layer.borderWidth = 1.0
        
        numberLabel.adjustsFontSizeToFitWidth = true
        numberLabel.minimumScaleFactor = 0.1
        numberLabel.lineBreakMode = .byClipping
        numberLabel.numberOfLines = 0
        
        ccvLabel.adjustsFontSizeToFitWidth = true
        ccvLabel.minimumScaleFactor = 0.1
        ccvLabel.lineBreakMode = .byClipping
        ccvLabel.numberOfLines = 0
        
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.minimumScaleFactor = 0.1
        dateLabel.lineBreakMode = .byClipping
        dateLabel.numberOfLines = 0
        
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.1
        nameLabel.lineBreakMode = .byClipping
        nameLabel.numberOfLines = 0
        
        cardLogo.image = UIImage(named: "visa.png")
        numberLabel.text = "••••  ••••  ••••  3847"
        ccvLabel.text = "•••"
        dateLabel.text = "07/22"
        nameLabel.text = "CHRISTIAN AMPE"
    }
    
    func addViews() {
        
        addSubview(cardView)
        addSubview(cardLogo)
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
        
        cardLogo.translatesAutoresizingMaskIntoConstraints = false
        
        cardLogo.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: cardView.frame.height/10).isActive = true
        cardLogo.topAnchor.constraint(equalTo: cardView.topAnchor, constant: cardView.frame.height/10).isActive = true
        cardLogo.heightAnchor.constraint(equalToConstant: cardView.frame.height/5).isActive = true
        cardLogo.widthAnchor.constraint(equalTo: cardView.widthAnchor).isActive = true
    }
    
    func addNameLabelConstraints() {
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: cardView.frame.height/10).isActive = true
        
        nameLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -cardView.frame.height/10).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: cardView.frame.height/10).isActive = true
    }
    
    func addDateLabelConstraints() {
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dateLabel.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: cardView.frame.height/10).isActive = true
        
        dateLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: cardView.frame.height/15).isActive = true
    }
    
    func addCCVLabelConstraints() {
        
        ccvLabel.translatesAutoresizingMaskIntoConstraints = false
        
        ccvLabel.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: cardView.frame.height/10).isActive = true
        
        ccvLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -cardView.frame.height/20).isActive = true
        ccvLabel.heightAnchor.constraint(equalToConstant: cardView.frame.height/20).isActive = true
    }
    
    func addNumberLabelConstraints() {
        
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        numberLabel.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: cardView.frame.height/10).isActive = true
        
        numberLabel.bottomAnchor.constraint(equalTo: ccvLabel.topAnchor).isActive = true
        numberLabel.heightAnchor.constraint(equalToConstant: cardView.frame.height/10).isActive = true
    }
}
