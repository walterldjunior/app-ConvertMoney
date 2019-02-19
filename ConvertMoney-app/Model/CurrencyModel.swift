//
//  CurrencyModel.swift
//  ConvertMoney-app
//
//  Created by WalterJunior on 2/19/19.
//  Copyright © 2019 WalterLdJunior. All rights reserved.
//

import Foundation

struct Root: Codable {
	let  data: [CurrencyModel]
}

class CurrencyModel: Codable {
	var varBid: String
	var code: String
	var codein: String
	var name: String
	var high: String
	var low: String
	var pctChange: String
	var bid: String
	var ask: String
	var timestamp: String
	var create_date: String
}

