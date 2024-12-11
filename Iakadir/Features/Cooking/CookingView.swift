import SwiftUI

struct CookingView: View {
    @EnvironmentObject var cookingViewModel: CookingViewModel
    @State private var selectedTab: Int = 0
    @State private var selectedImage: UIImage? = nil
    @State private var showImagePicker: Bool = false
    // @State private var selectedFoods: [String] = []
    // @State private var filters: Filters = Filters()
    @State private var isLoading: Bool = false
    @State private var isPhoto = false
    
    var body: some View {
        ZStack {
            Image("Group 1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(0.3)
                .ignoresSafeArea()
                .clipped()
            
            VStack {
                
                if selectedTab == 0 {
                    
                    Text("Dans mon frigo \nil y a...")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .multilineTextAlignment(.center)
                    
                    // Onglet 1 : Photo ou sélection des aliments
                    VStack {
                        Toggle("Je veux prendre une photo !", isOn: $isPhoto)
                            .padding(.vertical, 20)
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        
                        if isPhoto {
                            Button(action: { showImagePicker = true }) {
                                if let image = selectedImage {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(8)
                                    
                                } else {
                                    VStack {
                                        Spacer()
                                        Image(systemName: "camera.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .font(.title)
                                            .foregroundColor(Color("secondary"))
                                            .frame(width: 100, height: 100)
                                        
                                        Text("Sélectionner une image")
                                        Spacer()
                                    }
                                }
                            }
                            .sheet(isPresented: $showImagePicker) {
                                ImagePicker(selectedImage: $selectedImage)
                            }
                        } else {
                            ScrollView {
                                FoodListView()
                            }
                        }
                    }
                } else if selectedTab == 1 {
                    // Onglet 2 : Filtres
                    
                    Text("Je vais faire \nà manger pour...")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    VStack {
                        FilterView()
                    }
                    
                    Spacer()
                
                    VStack {
                      Button(action: {
                        sendRequestToAPI();
                        cookingViewModel.logData()
                      }) {
                            if isLoading{
                                CustomButton(title: "Attends, ça charge...")
                            }else{
                                CustomButton(title: "Cuisinons !")
                            }
                            
                        }
                        .disabled(isLoading)
                    }
                }
                
                Spacer()
                
                HStack {
                    // Onglet 1
                    Button(action: { selectedTab = 0 }) {
                        Text("Aliments")
                            .foregroundColor(selectedTab == 0 ? .blue : .gray)
                    }
                    .padding()
                    
                    // Onglet 2
                    Button(action: { selectedTab = 1 }) {
                        Text("Filtres")
                            .foregroundColor(selectedTab == 1 ? .blue : .gray)
                    }
                    .padding()
                   
                }
                .background(Color.white)
                .cornerRadius(16)
                .shadow(radius: 5)
            }
            .padding()
            .foregroundStyle(.white)
        }
        .background(Color("primary"))
        .environmentObject(cookingViewModel)
        
    }

    private func sendRequestToAPI() {
        isLoading = true
        // Logique d'appel à l'API ici...
    }
}

struct Filters {
    var numberOfPeople: Int = 1
    var isVegetarian: Bool = false
    var isGlutenFree: Bool = false
}

#Preview {
    HomeView()
}
