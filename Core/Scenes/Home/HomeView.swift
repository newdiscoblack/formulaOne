//
//  HomeView.swift
//  formula-one
//
//  Created by Kacper Jagiello on 11/04/2021.
//

import SwiftUI
import Utilities

struct HomeView: View {
    @ObservedObject
    var mainTabViewCoordinator: MainTabViewCoordinator
    
    @StateObject
    var viewModel: HomeViewModel
    
    var body: some View {
        ZStack {
            VStack {
                SectionTitle(
                    title: "Next"
                )
                UpcomingRace(
                    mainTabViewCoordinator: mainTabViewCoordinator,
                    viewModel: viewModel
                )
                .isRedacted(
                    viewModel.nextRaceState == .empty
                        || viewModel.nextRaceState == .error
                )
                SectionTitle(
                    title: "Standings"
                )
                DriverRanking(
                    mainTabViewCoordinator: mainTabViewCoordinator,
                    viewModel: viewModel
                )
                .isRedacted(
                    viewModel.standingsState == .empty
                )
                Spacer()
            }
            .modifier(DefaultViewStyleModifier())
            
            if viewModel.standingsState == .empty {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .red))
                    .scaleEffect(2)
            }
        }
    }
}

struct UpcomingRace: View {
    @ObservedObject
    var mainTabViewCoordinator: MainTabViewCoordinator
    
    @ObservedObject
    var viewModel: HomeViewModel
    
    var body: some View {
        let upcomingRace = viewModel.upcomingRace
        let circuitLocationFlag = viewModel
            .dependencies
            .flagProvider
            .country(
                upcomingRace?.circuit.location.country ?? "Unknown"
            )
        let upcomingRaceName = upcomingRace?.name ?? "Unknown"
        let roundNumber = upcomingRace?.round ?? "0"
        let raceDateString = upcomingRace?.getFullDate()
        let circuitID = upcomingRace?.circuit.id.lowercased() ?? "Unknown"
        
        VStack {
            Spacer()
            Circuit(
                id: circuitID
            )
            if let raceDateString = raceDateString {
                if let raceDate = viewModel
                    .dependencies
                    .dateProvider
                    .dateFrom(raceDateString) {
                let dateToPrint = viewModel
                    .dependencies
                    .dateProvider
                    .print(.date, from: raceDate)
                let timeToPrint = viewModel
                    .dependencies
                    .dateProvider
                    .print(.time, from: raceDate)
                    
                    RaceDate(
                        date: dateToPrint,
                        time: timeToPrint
                    )
                }
            }
            RoundNumber(roundNumber)
            RaceName(
                upcomingRaceName,
                locationFlag: circuitLocationFlag,
                mainTabViewCoordinator: mainTabViewCoordinator
            )
        }
        .frame(maxWidth: .infinity, maxHeight: 200.0)
        .background(
            ZStack {
                Image("\(circuitID)_background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                Rectangle()
                    .foregroundColor(
                        Color(
                            .sRGB,
                            red: 0,
                            green: 0,
                            blue: 0,
                            opacity: 0.4
                        )
                    )
                    .background(
                        LinearGradient(
                            gradient: Gradient(
                                colors: [.clear, .gray]
                            ),
                            startPoint: .topTrailing,
                            endPoint: .leading
                        )
                    )
            }
        )
        .cornerRadius(20.0)
        .padding(.horizontal)
    }
    
    private struct Circuit: View {
        let circuitID: String
        
        init(
            id: String
        ) {
            self.circuitID = id
        }
        
        var body: some View {
            HStack {
                Image(circuitID)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(.horizontal)
        }
    }
    
    private struct RaceDate: View {
        let date: String
        let time: String
        
        var body: some View {
            Text("\(date), \(time)")
                .font(.system(size: 15.0, weight: .regular))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal)
                .foregroundColor(.white)
        }
    }
    
    private struct RoundNumber: View {
        let roundNumber: String
        
        init(
            _ roundNumber: String
        ) {
            self.roundNumber = roundNumber
        }
        
        var body: some View {
            HStack {
                Text("Round \(Image(systemName: "\(roundNumber).circle"))")
                    .font(.system(size: 20.0, weight: .semibold))
                    .padding(.horizontal)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private struct RaceName: View {
        @ObservedObject
        var mainTabViewCoordinator: MainTabViewCoordinator
        
        let raceName: String
        let locationFlag: String
        
        init(
            _ raceName: String,
            locationFlag: String,
            mainTabViewCoordinator: MainTabViewCoordinator
        ) {
            self.raceName = raceName
            self.locationFlag = locationFlag
            self.mainTabViewCoordinator = mainTabViewCoordinator
        }
        
        var body: some View {
            HStack {
                Text("\(raceName) \(locationFlag)")
                    .font(.system(size: 20.0, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                Button(action: {
                    mainTabViewCoordinator.selectedTab = .schedule
                }) {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 30.0, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal)
                }
            }
            .padding(.bottom)
        }
    }
}

struct DriverRanking: View {
    @ObservedObject
    var mainTabViewCoordinator: MainTabViewCoordinator
    
    @ObservedObject
    var viewModel: HomeViewModel
    
    var body: some View {
        let standings = viewModel
            .standings?
            .details
            .first?
            .drivers[0...2] ?? []
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(
                    standings.indices,
                    id: \.self
                ) { driver in
                    DriverCell(
                        viewModel: DriverCellViewModel
                            .populateWith(standings[driver]),
                        dependencies: viewModel.dependencies
                    )
                    .padding(.horizontal, 7.0)
                }
                Button(action: {
                    mainTabViewCoordinator.selectedTab = .standings
                }) {
                    Image(systemName: "arrow.right.circle")
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                        .padding(.horizontal)
                }
                .isHidden(
                    viewModel.standingsState == .empty
                    || viewModel.standingsState == .error
                )
            }
        }
        .padding(.leading, 10.0)
    }
}

struct DriverCell: View {
    let viewModel: DriverCellViewModel
    var dependencies: AppDependenciesProtocol
    
    var body: some View {
        VStack {
            Position(
                position: viewModel.position
            )
            Spacer()
            DriverDetails(
                nationality: viewModel.nationality,
                points: viewModel.points,
                name: viewModel.name,
                surname: viewModel.surname,
                constructor: viewModel.constructor,
                flagProvider: dependencies.flagProvider
            )
        }
        .frame(width: 250, height: 250)
        .background(
            Image(viewModel.surname.lowercased())
                .resizable()
                .aspectRatio(contentMode: .fit)
        )
        .cornerRadius(20.0)
    }
    
    private struct Position: View {
        var position: String
        
        var body: some View {
            HStack {
                Image(systemName: "\(position).square")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    private struct DriverDetails: View {
        var nationality: String
        var points: String
        var name: String
        var surname: String
        var constructor: String
        var flagProvider: FlagProviding

        var body: some View {
            Text(constructor)
                .frame(width: 250, height: 20, alignment: .leading)
                .font(.system(size: 18.0, weight: .bold, design: .default))
                .foregroundColor(.white)
                .padding(.leading, 20.0)

            HStack {
                Text("\(flagProvider.nationality(nationality))")
                    .font(.system(size: 30.0, weight: .semibold, design: .default))
                    .padding(.leading, 10.0)
                VStack {
                    Text(name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 12.0, weight: .regular, design: .default))
                        .foregroundColor(.white)
                    Text(surname)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 18.0, weight: .bold, design: .default))
                        .foregroundColor(.white)
                }
                Text("\(points)")
                    .font(.system(size: 30.0, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .padding(.trailing, 10.0)
            }
            .frame(width: 250, height: 60, alignment: .leading)
            .foregroundColor(.black)
            .background(
                LinearGradient(
                    gradient: Gradient(
                        colors: [
                            .black,
                            Color.init(.sRGB, red: 64/255, green: 65/255, blue: 81/255, opacity: 0.7)
                        ]
                    ),
                    startPoint: .bottom,
                    endPoint: .top
                )
            )
        }
    }
}

#if DEBUG
struct CurrentSeasonView_PreviewContainer: View {
    var body: some View {
        HomeView(
            mainTabViewCoordinator: MainTabViewCoordinator(),
            viewModel: HomeViewModel()
        )
    }
}

struct CurrentSeasonView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentSeasonView_PreviewContainer()
    }
}
#endif
