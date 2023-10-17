import SwiftUI

struct Translation: View {
    var translation: Array<TranslationData>
    
    var body: some View {
        VStack {
            Text("Translation"~)
                .fontWeight(.bold)
            let _ = print(translation)
            List(translation, id: \.code) { translation in
                
                let _ = print(translation)
                HStack {
                    Text(translation.code)
                        .font(.system(
                            size: 32,
                            weight: .bold
                        ))
                    Spacer()
                    Text(translation.name)
                    Spacer()
                    Letters(
                        letters: translation.sequence
                    )
                }
            }
        }
    }
}

#Preview {
    Translation(
        translation:
            TranslationDataMock
    )
}
