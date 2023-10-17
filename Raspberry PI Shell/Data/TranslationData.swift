struct TranslationData: Decodable {
    let sequence: String
    let name: String
    let code: String
}

struct Codons: Decodable {
    let codons: [TranslationData]
}

let TranslationDataMock = [
    TranslationData(
        sequence: "ATGC",
        name: "Test",
        code: "T"
    )
]
