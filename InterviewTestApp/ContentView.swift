//
//  ContentView.swift
//  InterviewTestApp
//
//  Created by Hari Rait on 19.03.24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var users: [TestUser] = []
    @State private var errorMessage = "Fehler beim Laden der Daten"
    
    var body: some View {
        VStack {
            if users.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
                Button("Daten laden", action: loadData)
                    .padding()
            } else {
                NavigationStack {
                    List(users) { user in
                        NavigationLink {
                            Text("ID: \(user.id)")
                                .font(.headline)
                            Text("Email: \(user.email)")
                                .font(.subheadline)
                            Text("Vorname: \(user.first_name)")
                                .font(.subheadline)
                            Text("Nachname: \(user.last_name)")
                                .font(.subheadline)
                        } label: {
                            AsyncImage(url: URL(string: user.avatar)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(Circle())
                            } placeholder: {
                                Circle()
                                    .foregroundColor(.secondary)
                            }
                            .frame(width: 120, height: 120)
                        }
                        
                    }
                }
            }
        }
        .onAppear {
            loadData()
        }
    }
    /// Networkcall get User from API
    
    func loadData() {
        guard let url = URL(string: "https://reqres.in/api/users?per_page=10") else {
            errorMessage = "Ungültige URL"
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                errorMessage = error.localizedDescription
                return
            }
            
            guard let data = data else {
                errorMessage = "Keine Daten erhalten"
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let apiResponse = try decoder.decode(APIResponse.self, from: data)
                users = apiResponse.data.map { user in
                    TestUser(id: user.id,
                             email: user.email,
                             first_name: user.first_name,
                             last_name: user.last_name,
                             avatar: user.avatar)
                }
            } catch {
                errorMessage = error.localizedDescription
            }
        }.resume()
    }
}

#Preview {
    ContentView()
}
