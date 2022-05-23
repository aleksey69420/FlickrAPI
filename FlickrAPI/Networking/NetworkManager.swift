//
//  NetworkManager.swift
//  FlickrAPI
//
//  Created by Aleksey on 5/17/22.
//

import Foundation

// class or struct in this case?

class NetworkManager {
	
	// class - can't override, static can
	
	class func request<ResponseType: Codable>(endpoint: EndPoint, then handler: @escaping (Result<ResponseType, Error>) -> Void) {
		
		print(#function)
		
		var components = URLComponents()
		components.scheme = endpoint.scheme
		components.host = endpoint.baseURL
		components.path = endpoint.path
		components.queryItems = endpoint.parameters
		
		guard let url = components.url else {
			print("invalid url")
			return
		}
		
		var request = URLRequest(url: url)
		request.httpMethod = endpoint.method
		
		// why not to use shared urlsession?
		let session = URLSession(configuration: .default)
		
		let dataTask = session.dataTask(with: request) { data, response, error in
			
			guard error == nil else {
				handler(.failure(error!))
				print(error?.localizedDescription ?? "Unknown error")
				return
			}
			
			// better way to handle response
			guard response != nil, let data = data else { return }
			
			// can data be decoded in the main queue (ex. do whole do-catch in the main queue)
			
			// alternative implementation
			do {
				let dateFormatter = DateFormatter()
				dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
				dateFormatter.locale = Locale(identifier: "en_US_POSIX")
				dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
				
				let decoder = JSONDecoder()
				decoder.dateDecodingStrategy = .formatted(dateFormatter)
				
				let responseObject = try decoder.decode(ResponseType.self, from: data)
				
				
				
				DispatchQueue.main.async {
					handler(.success(responseObject))
				}
			} catch {
				DispatchQueue.main.async {
					handler(.failure(error))
				}
			}
			
		}
		dataTask.resume()
	}
}
