//
//  SavedGroupsView.swift
//  UberClone
//
//  Created by Pankaj Kumar Rana on 9/5/25.
//

import SwiftUI


struct Group: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var members: [String]
}


struct SavedGroupsView: View {
    @State private var groupName: String = ""
    @State private var memberName: String = ""
    @State private var groups: [Group] = []
    @State private var selectedGroup: Group?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                
                HStack {
                    TextField("Enter group name", text: $groupName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Add") {
                        guard !groupName.isEmpty else { return }
                        let newGroup = Group(name: groupName, members: [])
                        groups.append(newGroup)
                        groupName = ""
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding(.horizontal)
                
                
                List {
                    ForEach(groups) { group in
                        Section(header: Text(group.name).font(.headline)) {
                            ForEach(group.members, id: \.self) { member in
                                Label(member, systemImage: "person.fill")
                            }
                            
                            
                            HStack {
                                TextField("Add member", text: Binding(
                                    get: { selectedGroup?.id == group.id ? memberName : "" },
                                    set: { memberName = $0; selectedGroup = group }
                                ))
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                
                                Button("Add") {
                                    if let index = groups.firstIndex(where: { $0.id == group.id }), !memberName.isEmpty {
                                        groups[index].members.append(memberName)
                                        memberName = ""
                                    }
                                }
                                .buttonStyle(.bordered)
                            }
                        }
                    }
                }
                .listStyle(.insetGrouped)
                
                Spacer()
            }
            .navigationTitle("Saved Groups")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview {
    SavedGroupsView()
}
