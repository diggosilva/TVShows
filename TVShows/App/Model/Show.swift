class Show: CustomStringConvertible {
    let image: String
    let name: String
    let rating: Double?
    
    init(image: String, name: String, rating: Double?) {
        self.image = image
        self.name = name
        self.rating = rating
    }
    
    var description: String {
        return "Show: image: \(image), name: \(name), rating: \(String(describing: rating ?? 0.0))"
    }
}