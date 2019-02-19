//
//  SettingsViewController.swift
//  ConvertMoney-app
//
//  Created by WalterJunior on 2/14/19.
//  Copyright © 2019 WalterLdJunior. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
	
	//MARK:- Outlets
	@IBOutlet weak var dolarTxt: UITextField!
	@IBOutlet weak var iofTxt: UITextField!
	@IBOutlet weak var stateTaxTxt: UITextField!
	@IBOutlet weak var declarationStatus: UILabel!
	@IBOutlet weak var pickerView: UIPickerView!
	@IBOutlet weak var currentDollarQuotation: UILabel!
	
	//MARK:- Variables
	private let dataSource = ["Declarado", "Não Declarado", "Multado"]
	var dolarQuotation: CurrencyModel?
	
	//MARK:- View Manipulation
    override func viewDidLoad() {
        super.viewDidLoad()
		
		pickerView.dataSource = self
		pickerView.delegate = self
		initialDataScreen()
    }
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		view.endEditing(true)
	}
	
	//MARK:- Functions
	func initialDataScreen() {
		getCurrentCurrencyQuote()
		dolarTxt.text = tc.getFormatterValue(of: tc.dolar, withCurrency: "")
		iofTxt.text = tc.getFormatterValue(of: tc.iof, withCurrency: "")
		stateTaxTxt.text = tc.getFormatterValue(of: tc.stateTax, withCurrency: "")
	}
	
	func setValues() {
		tc.dolar = tc.convertToDouble(dolarTxt.text!)
		tc.iof = tc.convertToDouble(iofTxt.text!)
		tc.stateTax = tc.convertToDouble(stateTaxTxt.text!)
	}
	
	func getCurrentCurrencyQuote() {
		REST.getCurrency(onComplete: { (currencyModel) in
			self.dolarQuotation = currencyModel[0]
			self.currentQuotation()
		}) { (CurrencyError) in
			switch CurrencyError {
			case .url:
				print("Erro ao recuperar a URL")
			case .taskError( _):
				print("Erro na execução da task")
			case .noResponse:
				print("Erro no Response")
			case .responseStatusCode( _):
				print("Erro no Status Code / Diferente de 200")
			}
		}
	}
	
	func currentQuotation() {
		DispatchQueue.main.async(execute: {
			guard let quotationDollar = self.dolarQuotation?.bid else {return}
			self.currentDollarQuotation.text = "Cotação atual do Dólar para compra: R$ \(String(describing: quotationDollar))"
		})
	}
}

//MARK:- Extension UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
	func textFieldDidEndEditing(_ textField: UITextField) {
		setValues()
	}
}

//MARK:- Extension UIPickerViewDelegate, UIPickerViewDelegate
extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return dataSource.count
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		declarationStatus.text = dataSource[row]
		tc.declarationStatus = declarationStatus.text!
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		 return dataSource[row]
	}
}
