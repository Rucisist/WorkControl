//
//  counters.swift
//  WorkControll
//
//  Created by Андрей Илалов on 03.10.2023.
//  Copyright © 2023 Андрей Илалов. All rights reserved.
//

import UIKit

public struct UBTextAndButtonSendAreaViewModel {
    public var maximumSymbols: Int
    public var text: String
    public let placeholderText: String
    
    public let didTextChanged: (_ text: String) -> Void
    
    public let didTapSendButton: (() -> ())?
    
    public var symbolsLeft: Int {
        return maximumSymbols - text.count
    }
    
    func isAllowed(text: String) -> Bool {
        return text.unicodeScalars.count <= maximumSymbols
    }
    
    public init(maximumSymbols: Int,
                text: String,
                placeholderText: String,
                didTextChanged: @escaping (_ text: String) -> Void,
                didTapSendButton: (() -> ())? = nil) {
        self.maximumSymbols = maximumSymbols
        self.text = text
        self.placeholderText = placeholderText
        self.didTextChanged = didTextChanged
        self.didTapSendButton = didTapSendButton
    }
}

/// Класс - область с кнопкой и текстовым полем для витрины гифтов
public class UBTextAndButtonSendAreaView: UIView {
    
    public var vm: UBTextAndButtonSendAreaViewModel {
        didSet {
        }
    }
    
    private var bigSendButton = LoadingButton(style: .orange)
    private var smallSendButton = UBIncreasedButton()
    private var textField = UBCountableTextView()

    public var textFieldFrame: CGRect {
        textField.frame
    }
    
    public var isBigButtonHide: Bool = false {
        didSet {
            bigSendButton.isHidden = isBigButtonHide
        }
    }
    
    fileprivate var textViewTrailingConstraint: NSLayoutConstraint!
    
    public init(vm: UBTextAndButtonSendAreaViewModel) {
        self.vm = vm
        super.init(frame: .zero)
        
        commonInit()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        self.vm = UBTextAndButtonSendAreaViewModel.init(maximumSymbols: 40, text: "", placeholderText: "", didTextChanged: { text in
        })
        super.init(frame: .zero)
        commonInit()
    }
    
    func commonInit() {
        setupInterface()
    }
    
    func setupInterface() {
        setupSmallSendButton()
        setupTextField()
        setupBigSendButton()
        setupConstraints()
    }
    
    @objc func didTapOkButton() {
        vm.didTapSendButton?()
    }
    
    func setupBigSendButton() {
        bigSendButton.style = .orange
        bigSendButton.layer.cornerRadius = 10.0
        bigSendButton.addTarget(self, action: #selector(didTapOkButton), for: .touchUpInside)
        bigSendButton.setTitle(NSLocalizedString("gift.compose.send.gift", comment: ""), for: .normal)
        addSubview(bigSendButton)
    }
    
    func setupSmallSendButton() {
        smallSendButton.style = .orange
        smallSendButton.layer.cornerRadius = 6.0
        smallSendButton.setImage(UIImage.safeImageLiteral(resourceName: "arrowOnPublishButton"), for: .normal)
        smallSendButton.addTarget(self, action: #selector(didTapOkButton), for: .touchUpInside)
        addSubview(smallSendButton)
    }
    
    func setupTextField() {
        textField.vm = UBCountableTextViewVM.init(maximumSymbols: vm.maximumSymbols, text: vm.text, placeholderText: vm.placeholderText, didTextChanged: vm.didTextChanged)
        addSubview(textField)
    }
    
    func setupConstraints() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        smallSendButton.translatesAutoresizingMaskIntoConstraints = false
        bigSendButton.translatesAutoresizingMaskIntoConstraints = false
        
        textField.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textField.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        textViewTrailingConstraint = textField.trailingAnchor.constraint(equalTo: trailingAnchor)
        textViewTrailingConstraint.isActive = true
        textField.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        bigSendButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 15).isActive = true
        bigSendButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bigSendButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        bigSendButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        bigSendButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        smallSendButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor).isActive = true
        smallSendButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        smallSendButton.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        smallSendButton.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
    }
    
    public func showSmallButton() {
        textViewTrailingConstraint.constant = -50
        smallSendButton.isHidden = false
        if !isBigButtonHide {
            bigSendButton.isHidden = true
        }
        layoutIfNeeded()
    }
    
    public func hideSmallButton() {
        textViewTrailingConstraint.constant = 0
        smallSendButton.isHidden = true
        if !isBigButtonHide {
            bigSendButton.isHidden = false
        }
        layoutIfNeeded()
    }
    
    public func showCounterLabel() {
        textField.countLabel.isHidden = false
    }
    
    public func hideCounterLabel() {
        textField.countLabel.isHidden = true
    }
    
    public func showLoading() {
        bigSendButton.showLoading()
        smallSendButton.showLoading()
        smallSendButton.setImage(nil, for: .normal)
    }
    
    public func hideLoading() {
        bigSendButton.hideLoading()
        smallSendButton.hideLoading()
        smallSendButton.setImage(UIImage.safeImageLiteral(resourceName: "arrowOnPublishButton"), for: .normal)
    }
    
    public func isTextFieldFirstResponder() -> Bool {
        return textField.textView.isFirstResponder
    }
    
    public func textFieldResignFirstResponder() {
        textField.textView.resignFirstResponder()
    }
}
