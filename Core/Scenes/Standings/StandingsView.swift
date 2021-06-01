//
//  StandingsView.swift
//  FormulaOne
//
//  Created by Kacper Jagiełło on 26/05/2021.
//

import SwiftUI
import Utilities

struct StandingsView: View {
    @ObservedObject
    var coordinator: MainTabViewCoordinator
    
    @StateObject
    var viewModel: StandingsViewModel
    
    var body: some View {
        ZStack {
            VStack {
                SectionTitle(
                    title: "Standnings"
                )
                DriverStandingsList(
                    coordinator: coordinator,
                    viewModel: viewModel
                )
                .isRedacted(viewModel.standingsState == .empty)
            }
            .background(
                Color.init(red: 30/255, green: 30/255, blue: 30/255)
                    .ignoresSafeArea()
            )
            if viewModel.standingsState == .empty {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                    .scaleEffect(2)
            }
        }
    }
}

struct DriverStandingsList: View {
    @ObservedObject
    var coordinator: MainTabViewCoordinator
    
    @StateObject
    var viewModel: StandingsViewModel
    
    var body: some View {
        let standings = viewModel
            .standings?
            .details
            .first?
            .drivers ?? []
        List {
            ForEach(
                standings.indices,
                id: \.self
            ) { driver in
                StandingsDriverCell(
                    viewModel: DriverCellViewModel.populateWith(standings[driver]),
                    dependencies: viewModel.dependencies
                )
                .hideRowSeparator(
                    insets: .defaultListRowInsets,
                    background: Color.init(red: 30/255, green: 30/255, blue: 30/255)
                )
            }
        }
        .onAppear {
            UITableView.appearance().backgroundColor = .clear
        }
        .simultaneousGesture(
            DragGesture().onChanged { gesture in
                if gesture.translation.height > 0 {
                    coordinator.shouldDisplayTabBar = true
                  } else {
                    coordinator.shouldDisplayTabBar = false
                  }
            }
        )
    }
}

struct StandingsDriverCell: View {
    let viewModel: DriverCellViewModel
    var dependencies: AppDependenciesProtocol
    
    var body: some View {
        ZStack {
            StandingsCellBackground(
                constructor: viewModel.constructor,
                acumulatedPoints: viewModel.points,
                carProvider: dependencies.carProvider
            )
            DriverDetails(
                position: viewModel.position,
                name: viewModel.name,
                surname: viewModel.surname,
                constructor: viewModel.constructor
            )
        }
        .padding(.vertical, 3.0)
    }
    
    struct StandingsCellBackground: View {
        let constructor: String
        let acumulatedPoints: String
        let carProvider: CarProviding
        
        var body: some View {
            ZStack {
                Rectangle()
                    .foregroundColor(
                        Color.clear
                    )
                    .background(
                        LinearGradient(
                            gradient: Gradient(
                                colors: [
                                    .clear,
                                    Color.init(.sRGB, red: 64/255, green: 65/255, blue: 81/255, opacity: 0.3),
                                    Color.init(.sRGB, red: 64/255, green: 65/255, blue: 81/255, opacity: 0.5),
                                    Color.init(.sRGB, red: 64/255, green: 65/255, blue: 81/255, opacity: 0.7),
                                    Color.init(.sRGB, red: 64/255, green: 65/255, blue: 81/255, opacity: 0.9)
                                ]
                            ),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(20.0)
                VStack {
                    Spacer()
                    carProvider.team(constructor)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150)
                        .padding(.leading, 80.0)
                }
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        Text(acumulatedPoints)
                            .font(.system(size: 35.0, weight: .bold, design: .default))
                            .foregroundColor(.white)
                            .padding(.trailing, 80.0)
                    }
                }
            }
        }
    }
    
    struct DriverDetails: View {
        let position: String
        let name: String
        let surname: String
        let constructor: String
        
        var body: some View {
            HStack {
                Text(position)
                    .font(.system(size: 30.0, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .padding(.leading, 10.0)
                VStack {
                    Text(name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 15.0, weight: .regular, design: .default))
                        .foregroundColor(.white)
                    Text(surname)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 20.0, weight: .bold, design: .default))
                        .foregroundColor(.white)
                    Text(constructor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 15.0, weight: .regular, design: .default))
                        .foregroundColor(.gray)
                }
                ZStack {
                    Image("\(surname.lowercased())_standings")
                        .resizable()
                        .frame(width: 125, height: 100)
                }
            }
            .cornerRadius(20.0)
            .padding(.top, 10.0)
        }
    }
}

#if DEBUG
struct StandingsView_PreviewContainer: View {
    var body: some View {
        StandingsView(
            coordinator: MainTabViewCoordinator(),
            viewModel: StandingsViewModel()
        )
    }
}

struct StandingsView_Previews: PreviewProvider {
    static var previews: some View {
        StandingsView_PreviewContainer()
    }
}
#endif
