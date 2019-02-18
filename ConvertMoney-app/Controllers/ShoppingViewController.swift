//
//  ViewController.swift
//  ConvertMoney-app
//
//  Created by WalterJunior on 2/14/19.
//  Copyright © 2019 WalterLdJunior. All rights reserved.
//

import UIKit

class ShoppingViewController: UIViewController {
	
	@IBOutlet weak var cashDolarTxt: UITextField!
	@IBOutlet weak var cashReaisLabel: UILabel!
	@IBOutlet weak var valueRealDescriptionLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		setAmmount()
	}
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		cashDolarTxt.resignFirstResponder()
		setAmmount()
	}
	
	func setAmmount() {
		tc.shoppingValue = tc.convertToDouble(cashDolarTxt.text ?? "0")
		cashReaisLabel.text = tc.getFormatterValue(of: tc.shoppingValue * tc.dolar, withCurrency: "R$ ")
		let dolar = tc.getFormatterValue(of: tc.dolar, withCurrency: "R$ ")
		valueRealDescriptionLabel.text = "Valor sem impostos ~ Dólar \(dolar)"
	}


}

