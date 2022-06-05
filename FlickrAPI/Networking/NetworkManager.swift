//
//  NetworkManager.swift
//  FlickrAPI
//
//  Created by Aleksey on 5/17/22.
//

import Foundation
import UIKit

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
	
	
	// MARK: - Image Download
	
	//TODO: - refactor to dependency injection
	//TODO: - use URL for caching images because id doen't tell what is the image resolution
	static let imageService = ImageService()
	
	enum PhotoError: Error {
		case missingURL
		case imageCreationError
	}
	
	
	class func fetchImage(for photo: FlickrPhoto, then handler: @escaping (Result<UIImage, Error>) -> Void) {
		
		
		if let image = imageService.image(forKey: photo.id) {
			DispatchQueue.main.async {
				handler(.success(image))
			}
			return
		}
		
		guard let photoURL = photo.remoteURL else {
			handler(.failure(PhotoError.missingURL))
			return
		}
		
		let request = URLRequest(url: photoURL)
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			
			let result = self.processImageRequest(data: data, error: error)
			

			switch result {
			case .success(let image):
				imageService.setImage(image, forKey: photo.id)
			case .failure(let error):
				print(Log.error("error during image processing: \(error)"))
			}
			
			DispatchQueue.main.async {
				handler(result)
			}
		}
		task.resume()
	}
	
	
	// are there any benefit of this approach
	class private func processImageRequest(data: Data?, error: Error?) -> Result<UIImage, Error> {
		guard let imageData = data, let image = UIImage(data: imageData) else {
			// couldn't create image
			if data == nil {
				return .failure(error!) // what if it's still nil somehow
			} else {
				return .failure(PhotoError.imageCreationError)
			}
		}
		return .success(image)
	}
}
