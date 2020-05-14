//
//  CountryFacts.swift
//  ConsolidationCountries
//
//  Created by Daniel Gx on 14/05/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import Moya

public enum CountryFacts {
    case countries
}

extension CountryFacts: TargetType {
    public var baseURL: URL {
        return URL(string: "https://restcountries.eu/rest/v2")!
    }
    public var path: String {
        switch self {
        case .countries:
            return "/all"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .countries: return .get
        }
    }
    public var sampleData: Data {
        return Data()
    }
    public var task: Task {
        return .requestPlain
    }
    public var headers: [String : String]? {
        return ["Content-Type" : "application/json"]
    }
    public var validationType: ValidationType {
        return .successCodes
    }
}
