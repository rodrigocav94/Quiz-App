//
//  HomeView.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 23/09/24.
//

import SwiftUI
import SwiftData
import MSwiftUINavigator
import SwiftData

struct HomeView: View, Navigator {
    @Query var profiles: [Profile]
    @StateObject var cachedNetworkResults = NetworkService.shared
    @StateObject var vm = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            contentBody
                .navigationBarBackButtonHidden()
        }
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            cachedNetworkResults.fetchQuestions()
        }
    }
    var contentBody: some View {
        VStack(spacing: 15) {
            NavigationLink {
                RankingView()
            } label: {
                Text("Hall da Fama")
                    .capsuleViewStyle(fontColor: .quizOffBlack, borderColor: .quizGreen)
            }
            .padding(.trailing)
            .frame(height: 44)
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            Group {
                Text("Quem está por aqui?")
                    .font(Font.custom("Kickers-Regular", size: 55))
                    .minimumScaleFactor(0.6)
                Text("Já faz parte da turma ou está criando uma perfil agora?")
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 60)
            
            TabView(selection: $vm.selectedProfile) {
                ForEach(profiles) { profile in
                    ProfileSelection(homeVM: vm, profile: profile)
                        .tag(profile as Profile?)
                }
                ProfileSelection(homeVM: vm)
                    .tag(nil as Profile?)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .onAppear {
                vm.updateProfileSelection(withQuery: profiles)
            }
            
            TabViewIndex(currentIndex: vm.getProfileIndex(query: profiles), total:  profiles.count + 1)
            
            Group {
                if (vm.hasError) && vm.didNotLoadYet {
                    Button("Tentar Novamente") {
                        vm.tryLoadingAgain()
                    }
                    .onAppear {
                        vm.displayingAlert = true
                    }
                } else {
                    NavigationLink {
                        QuizView(profile: vm.selectedProfile)
                    } label: {
                        HStack(spacing: 10) {
                            if vm.didNotLoadYet {
                                ProgressView()
                                    .tint(.white)
                                    .scaleEffect(x: 1.25, y: 1.25)
                            }
                            Text(vm.didNotLoadYet ? "Carregando..." : "Começar Quiz")
                        }
                    }
                }
            }
            .buttonStyle(LargeButtonStyle())
            .padding(.horizontal, 60)
            .padding(.bottom)
            .disabled(vm.cantStartQuiz)
            
        }
        .foregroundStyle(.quizOffBlack)
        .multilineTextAlignment(.center)
        .frame(maxHeight: .infinity)
        .background(
            Color.quizOffWhite
                .ignoresSafeArea(edges: .all)
        )
        .alert(isPresented: $vm.displayingAlert) {
            Alert(title: Text("Ops! Não conseguimos sincronizar as perguntas."), message: Text("Tente novamente em alguns instantes."))
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .modelContainer(for: Profile.self, inMemory: true)
    }
}
