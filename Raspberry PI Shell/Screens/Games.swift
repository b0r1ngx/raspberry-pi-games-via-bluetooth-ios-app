import SwiftUI

struct Games: View {
    var body: some View {
        VStack {
            Text("Games"~)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            List {
                Game(
                    image: "spell-check",
                    title: "Seqle"~,
                    description: "Wordle-like game"~
                )
                Game(
                    image: "virus",
                    title: "Outbreak"~,
                    description: "Prevent the next pandemic"~
                )
                Game(
                    image: "loupe",
                    title: "Blaster"~,
                    description: "See what you can discover"~
                )
            }
        }
    }
}

struct Game: View {
    var image: String
    var title: String
    var description: String
    
    var body: some View {
        HStack {
            Image(image)
                .renderingMode(.template)
                .foregroundColor(Color("Image"))
            VStack(alignment: .leading) {
                Text(title)
                    .fontWeight(.semibold)
                Text(description)
            }
        }
    }
}

#Preview {
    Game(
        image: "virus",
        title: "Outbreak"~,
        description: "Prevent the next pandemic"~
    )
}

#Preview {
    Games()
}
