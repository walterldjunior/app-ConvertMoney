//
//  TaxesCalculator.swift
//  ConvertMoney-app
//
//  Created by WalterJunior on 2/15/19.
//  Copyright © 2019 WalterLdJunior. All rights reserved.
//

import Foundation

enum DeclarationStatus: String {
	case declared = "Declarado"
	case noDeclared = "Não Declarado"
	case mulct = "Multado"
}

class TaxesCalculator {
	
	//MARK:- Singleton
	static let shared = TaxesCalculator()
	
	//MARK:- Variables
	var dolar: Double = 3.5
	var iof: Double = 6.34
	var stateTax: Double = 0.0
	var shoppingValue: Double = 0
	let formatter = NumberFormatter()
	var declarationStatus: String = ""
	
	
	var shoppingValueInReal: Double {
		return shoppingValue * dolar
	}
	
	var stateTaxValue: Double {
		return shoppingValue * stateTax/100
	}
	
	var iofValue: Double {
		return (shoppingValue + stateTax) * iof/100
	}
	
	//MARK:- Init
	private init() {
		formatter.usesGroupingSeparator = true
	}
	
	//MARK:- Functions
	func convertToDouble(_ string: String) -> Double {
		if string.isEmpty {
			return 0.0
			
		} else {
			formatter.numberStyle = .none
			return formatter.number(from: string)!.doubleValue}
	}
	
	func calculate(creditCard: Bool) -> Double {
		var finalValue = shoppingValue + stateTaxValue
		if creditCard {
			finalValue += iofValue
		}
		
		if declarationStatus == DeclarationStatus.declared.rawValue {
			let valuePercent = (finalValue * 50)/100
			return (finalValue + valuePercent) * dolar
		} else if declarationStatus == DeclarationStatus.mulct.rawValue {
			let valuePercent = (finalValue * 100)/100
			return (finalValue + valuePercent) * dolar
		} else {
			return finalValue * dolar
		}
		
	}
	
	func getFormatterValue(of value: Double,  withCurrency currency: String) -> String {
		formatter.numberStyle = .currency
		formatter.currencySymbol = currency
		formatter.alwaysShowsDecimalSeparator = true
		
		return formatter.string(for: value)!
	}
	
}
