//
//  CreditCardView.swift
//  FlatPaymentMethod
//
//  Created by Ampe on 8/6/18.
//

import Foundation
import PaymentValidator

@IBDesignable
open class CreditCardView: UIView {
    
    // MARK: Views
    open weak var cardView: UIView!
    open weak var cardLogo: UIImageView!
    open weak var numberLabel: UILabel!
    open weak var cvvLabel: UILabel!
    open weak var dateLabel: UILabel!
    open weak var nameLabel: UILabel!
    
    // MARK: Properties
    open lazy var validator = CreditCardTypeValidator()
    
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
        
        let cvvLabel = UILabel()
        self.cvvLabel = cvvLabel
        
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
        
        let cvvLabel = UILabel()
        self.cvvLabel = cvvLabel
        
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

// MARK: - Public Setup Methods
public extension CreditCardView {
    func setSupportedCards(_ cards: [CreditCardType]) {
        validator = CreditCardTypeValidator(cards)
    }
    
    func validateNumber(_ number: String) {
        updateView(for: validator.card(for: number), numberLength: number.count)
    }
}

// MARK: - Update Methods For Credit Card Type Validation State
private extension CreditCardView {
    func updateView(for state: CreditCardTypeValidationState, numberLength: Int) {
        
        if let grouping = state.segmentGrouping(for: numberLength) {
            updateNumberGrouping(with: grouping)
        }
        
        // todo remove after testing is complete
        if let cards = state.cards {
            cards.forEach { card in
                print("Potential Card Type: \(card)")
            }
        }
    }
    
    func updateNumberGrouping(with grouping: [Int]) {
        print("Segment Grouping: \(grouping)")
    }
}

// MARK: - Private Setup Methods
private extension CreditCardView {
    func initViews() {
        
        cardView.layer.borderWidth = 1.0
        cardView.layer.cornerRadius = 8.0
        cardView.layer.borderColor = UIColor.black.cgColor
        
        cardLogo.contentMode = .scaleAspectFit
        cardLogo.clipsToBounds = true
        
        numberLabel.adjustsFontSizeToFitWidth = true
        numberLabel.minimumScaleFactor = 0.1
        numberLabel.lineBreakMode = .byClipping
        numberLabel.numberOfLines = 0
        
        cvvLabel.adjustsFontSizeToFitWidth = true
        cvvLabel.minimumScaleFactor = 0.1
        cvvLabel.lineBreakMode = .byClipping
        cvvLabel.numberOfLines = 0
        
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.minimumScaleFactor = 0.1
        dateLabel.lineBreakMode = .byClipping
        dateLabel.numberOfLines = 0
        
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.1
        nameLabel.lineBreakMode = .byClipping
        nameLabel.numberOfLines = 0
        
        cardLogo.image = UIImage(named: "mastercard.png", in: Bundle(for: CreditCardView.self), compatibleWith: nil)
        numberLabel.text = "••••  ••••  ••••  3847"
        cvvLabel.text = "•••"
        dateLabel.text = "07/22"
        nameLabel.text = "CHRISTIAN AMPE"
    }
    
    func addViews() {
        
        addSubview(cardView)
        addSubview(cardLogo)
        addSubview(numberLabel)
        addSubview(cvvLabel)
        addSubview(dateLabel)
        addSubview(nameLabel)
    }
    
    func addConstraints() {
        
        addCardViewConstraints()
        addCardLogoConstraints()
        addNumberLabelConstraints()
        addCVVLabelConstraints()
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
        cardLogo.widthAnchor.constraint(equalToConstant: cardView.frame.width/5).isActive = true
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
    
    func addCVVLabelConstraints() {
        
        cvvLabel.translatesAutoresizingMaskIntoConstraints = false
        
        cvvLabel.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: cardView.frame.height/10).isActive = true
        
        cvvLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -cardView.frame.height/20).isActive = true
        cvvLabel.heightAnchor.constraint(equalToConstant: cardView.frame.height/20).isActive = true
    }
    
    func addNumberLabelConstraints() {
        
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        numberLabel.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: cardView.frame.height/10).isActive = true
        
        numberLabel.bottomAnchor.constraint(equalTo: cvvLabel.topAnchor).isActive = true
        numberLabel.heightAnchor.constraint(equalToConstant: cardView.frame.height/10).isActive = true
    }
}
