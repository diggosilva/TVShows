class EpisodesViewModel: EpisodesViewModelProtocol {
    private(set) var state: Bindable<EpisodesViewControllerStates> = Bindable(value: .loading)
    
    var show: Show!
    private var episodes: [Episode] = []
    private let service: ServiceProtocol
    
    init(show: Show, service: ServiceProtocol = Service()) {
        self.service = service
        self.show = show
    }
    
    func numberOfRowsInSection() -> Int {
        return episodes.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> Episode {
        return episodes[indexPath.row]
    }
    
    func fetchEpisodes() {
        state.value = .loading
        
        service.getEpisodes(id: show.id) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let episodes):
                self.episodes.append(contentsOf: episodes)
                state.value = .loaded
                
            case .failure(let error):
                print("Error: \(error.rawValue)")
                state.value = .error
            }
        }
    }
}