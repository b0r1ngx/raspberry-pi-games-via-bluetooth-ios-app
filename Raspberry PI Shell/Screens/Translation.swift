import SwiftUI

struct Translation: View {
    var translation: Array<TranslationData>
    
    var body: some View {
        VStack {
            Text("Translation"~)
                .fontWeight(.bold)
            List(translation, id: \.sequence) { translation in
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
                        letters: translation
                            .sequence
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
