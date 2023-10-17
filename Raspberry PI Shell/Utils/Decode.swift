import Foundation

func decode(file: String) -> [TranslationData] {
    if let url = Bundle.main.url(
        forResource: file,
        withExtension: nil
    ) {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(
                Codons.self, from: data
            ).codons
        } catch {
            let _ = print("error:\(error)")
        }
    }
    return TranslationDataMock
}
