//
//  JSONSchemea.swift
//  Mausom
//
//  Created by Siddharth on 11/09/20.
//  Copyright © 2020 SP. All rights reserved.
//

import Foundation
// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()

    return encoder
}
