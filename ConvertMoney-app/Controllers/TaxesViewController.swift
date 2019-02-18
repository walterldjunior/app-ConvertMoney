//
//  TaxesViewController.swift
//  ConvertMoney-app
//
//  Created by WalterJunior on 2/14/19.
//  Copyright © 2019 WalterLdJunior. All rights reserved.
//

import UIKit

class TaxesViewController: UIViewController {

	//MARK:- Outlets
	@IBOutlet weak var dolarTxt: UILabel!
	@IBOutlet weak var stateTaxTxt: UILabel!
	@IBOutlet weak var iofTxt: UILabel!
	@IBOutlet weak var creditCardSwitch: UISwitch!
	@IBOutlet weak var realTxt: UILabel!
	@IBOutlet weak var declarationStatus: UILabel!
	
	@IBOutlet weak var stateTaxesDescriptionLabel: UILabel!
	@IBOutlet weak var iofDescriptionLabel: UILabel!
	
	//MARK:- View Manipulation
    override func viewDidLoad() {
        super.viewDidLoad()

    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		calculteTaxes()
	}
	
	//MARK:- Functions
	func calculteTaxes() {
		stateTaxesDescriptionLabel.text = "Imposto do Estado \(tc.getFormatterValue(of: tc.stateTax, withCurrency: ""))"
		iofDescriptionLabel.text = "IOF \(tc.getFormatterValue(of: tc.iof, withCurrency: ""))"
		
		dolarTxt.text = tc.getFormatterValue(of: tc.shoppingValue, withCurrency: "US$ ")
		stateTaxTxt.text = tc.getFormatterValue(of: tc.stateTaxValue, withCurrency: "US$ ")
		iofTxt.text = tc.getFormatterValue(of: tc.iofValue, withCurrency: "US$ ")
		
		let real = tc.calculate(creditCard: creditCardSwitch.isOn)
		
		realTxt.text = tc.getFormatterValue(of: real, withCurrency: "R$ ")
		
		declarationStatus.text = tc.declarationStatus
	}
	
	//MARK:- Acitons
	@IBAction func changeIOF(_ sender: UISwitch) {
		calculteTaxes()
	}
}
