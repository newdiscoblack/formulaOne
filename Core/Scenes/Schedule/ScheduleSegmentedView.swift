//
//  ScheduleSegmentedView.swift
//  FormulaOne
//
//  Created by Kacper Jagiełło on 26/05/2021.
//

import Services
import SwiftUI
import Utilities

struct ScheduleSegmentedView: View {
    enum ScheduleType {
        case past
        case upcoming
    }
    
    
    @State
    private var selectedSchedule: ScheduleType = .upcoming
    
    @ObservedObject
    var coordinator: MainTabViewCoordinator
    
    @StateObject
    var viewModel: ScheduleSegmentedViewModel
    
    var body: some View {
        ZStack {
            VStack {
                SectionTitle(
                    title: "Race schedule"
                )
                Picker(
                    selection: $selectedSchedule,
                    label: Text("SchedulePicker")
                ) {
                    Text("Past").tag(ScheduleType.past)
                    Text("Upcoming").tag(ScheduleType.upcoming)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                switch selectedSchedule {
                case .past:
                    RaceSchedule(
                        coordinator: coordinator,
                        dateProvider: viewModel.dependencies.dateProvider,
                        schedule: viewModel.pastSchedule ?? []
                    )
                case .upcoming:
                    RaceSchedule(
                        coordinator: coordinator,
                        dateProvider: viewModel.dependencies.dateProvider,
                        schedule: viewModel.upcomingSchedule ?? []
                    )
                }
                
                Spacer()
            }
            .onAppear {
                UISegmentedControl.appearance().backgroundColor = .gray
            }
            .modifier(DefaultViewStyleModifier())
            
            if viewModel.scheduleState == .empty {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .red))
                    .scaleEffect(2)
            }
        }
    }
}

struct RaceSchedule: View {
    @ObservedObject
    var coordinator: MainTabViewCoordinator
    
    @State
    var dateProvider: DateProviding
    
    let schedule: [Race]
    
    var body: some View {
        List {
            ForEach(
                schedule.indices,
                id: \.self
            ) { index in
                let race = schedule[index]
                let rawDate = dateProvider.dateFrom(race.getFullDate()) ?? Date()
                let date = dateProvider.print(.date, from: rawDate)
                let time = dateProvider.print(.time, from: rawDate)
                RaceScheduleCell(
                    location: race.circuit.location.country,
                    raceName: race.name,
                    date: "\(date) \(time)",
                    round: race.round,
                    circuitID: race.circuit.id
                )
                    .hideRowSeparator(
                        insets: .defaultListRowInsets,
                        background: Color.init(red: 30/255, green: 30/255, blue: 30/255)
                    )
            }
        }
        .onAppear {
            UITableView.appearance().backgroundColor = .clear
            UITableView.appearance().showsVerticalScrollIndicator = false
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
    
    private struct RaceScheduleCell: View {
        let location: String
        let raceName: String
        let date: String
        
        let round: String
        let circuitID: String
        
        var body: some View {
            ZStack {
                RaceScheduleCellBackground(
                    circuitID: circuitID.lowercased()
                )
                HStack {
                    VStack {
                        Text("\(location) 🇦🇿")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(raceName)
                            .font(.system(size: 24.0, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(date)
                            .foregroundColor(.white)
                            .font(.system(size: 12.0, weight: .regular))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    VStack {
                        Text("Round \(round)")
                            .font(.system(size: 18.0, weight: .semibold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top)
                        Image(circuitID.lowercased())
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.bottom)
                    }
                    .background(
                        RoundedCorners(
                            color: .white,
                            opacity: 0.2,
                            topLeft: 0,
                            topRight: 20.0,
                            bottomLeft: 0,
                            bottomRight: 20.0
                        )
                        .frame(height: 140)
                    )
                }
            }
            .frame(height: 140)
            .padding(.vertical, 3.0)
        }
    }

    private struct RaceScheduleCellBackground: View {
        let circuitID: String
        
        var body: some View {
            Rectangle()
                .foregroundColor(
                    Color.clear
                )
                .background(
                    ZStack {
                        Image("\(circuitID)_background")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        LinearGradient(
                            gradient: Gradient(
                                colors: [
                                    Color.init(red: 30/255, green: 30/255, blue: 30/255),
                                    Color.init(.sRGB, red: 64/255, green: 65/255, blue: 81/255, opacity: 0.2)
                                ]
                            ),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    }
                )
                .cornerRadius(20.0)
        }
    }
}

#if DEBUG
struct ScheduleView_PreviewContainer: View {
    var body: some View {
        ScheduleSegmentedView(
            coordinator: MainTabViewCoordinator(),
            viewModel: ScheduleSegmentedViewModel()
        )
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView_PreviewContainer()
    }
}
#endif
