//
//  REST.swift
//  ConvertMoney-app
//
//  Created by WalterJunior on 2/19/19.
//  Copyright © 2019 WalterLdJunior. All rights reserved.
//

import Foundation

enum CurrencyError {
	case url
	case taskError(error: Error)
	case noResponse
	case responseStatusCode(code: Int)
}

class REST {
	
	//MARK:- Session Context
	private static let configuration: URLSessionConfiguration = {
		let config = URLSessionConfiguration.default
		config.httpAdditionalHeaders = ["Content-Type": "application/json"]
		config.timeoutIntervalForRequest = 30.0
		
		return config
	}()
	
	private static let session = URLSession(configuration: configuration)
	
	//MARK:- Get Currency
	private static let basePath = "https://economia.awesomeapi.com.br/"
	private static let dolar = "USD-BRL/"
	private static let jsonCallback = "1?callback=jsonp_callback"
	
	//MARK:- GET
	class func getCurrency(onComplete: @escaping ([CurrencyModel]) -> Void, onError: @escaping (CurrencyError) -> Void) {
		guard let url = URL(string: basePath + dolar) else {
			onError(.url)
			return
		}
		
		let dataTask = session.dataTask(with: url) { (data, response, error) in
			if error == nil {
				
				guard let response = response as? HTTPURLResponse else {return}
				if response.statusCode == 200 {
					guard let data = data else {return}
					do {
						let currency = try JSONDecoder().decode([CurrencyModel].self, from: data)
						onComplete(currency)

					} catch {
						print(error.localizedDescription)
					}
					
				} else {
					onError(.responseStatusCode(code: response.statusCode))
				}
			} else {
				onError(.taskError(error: error!))
			}
		}
		dataTask.resume()
	}
	
	
}
