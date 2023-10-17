import Foundation

func decode(file: String) -> [TranslationData] {
    if let url = Bundle.main.url(
        forResource: file,
        withExtension: "json"
    ) {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let json = try decoder.decode(Codons.self, from: data)
            return json.codons
        } catch {
            let _ = print("error:\(error)")
        }
    }
    return TranslationDataMock
}
