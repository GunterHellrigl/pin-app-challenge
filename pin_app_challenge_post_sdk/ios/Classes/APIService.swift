import Foundation

public class APIService {
    static let shared = APIService()

    public func fetchComments(for postId: Int, completion: @escaping ([Comment]?) -> Void) {
        let urlString = "https://jsonplaceholder.typicode.com/comments?postId=\(postId)"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Failed to fetch comments")
                completion(nil)
                return
            }
            do {
                let comments = try JSONDecoder().decode([Comment].self, from: data)
                completion(comments)
            } catch {
                print("Failed to decode JSON")
                completion(nil)
            }
        }.resume()
    }
}

public struct Comment: Codable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
