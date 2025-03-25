//
//  DSError.swift
//  TVShows
//
//  Created by Diggo Silva on 23/03/25.
//

import Foundation

enum DSError: String, Error {
    case networkError = "Não foi possível concluir sua solicitação. Verifique sua conexão com a internet."
    case failedDecoding = "Não foi possível decodificar os dados."
    case invalidData = "Os dados recebidos do servidor eram inválidos. Tente novamente."
    case showsFailed = "Não foi possível carregar os seriados. Tente novamente."
    case castFailed = "Não foi possível carregar a lista de atores. Tente novamente."
    case seasonFailed = "Não foi possível carregar as temporadas. Tente novamente."
}
