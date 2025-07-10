# GodSufficient

## Architecture & Tech Stack

### Clean Architecture Layers

#### Data Layer
- **Responsibilities**: Handles how data is fetched/stored and maps to simple model objects.

#### Domain Layer
- **Responsibilities**: Business logic, entity definitions, abstract contracts

#### Presentation Layer
- **Responsibilities**: UI rendering, state management, navigation

### Directory Structure
```plaintext
example:
lib/
├── features/
│   └── auth/
│       ├── data/
│       │   ├── datasources/    # Firebase implementations
│       │   ├── models/         # Data models
│       │   └── repositories/   # Concrete repos
│       ├── domain/
│       │   ├── entities/       # Business objects
│       │   ├── repositories/   # Abstract interfaces
│       │   └── usecases/       # Business logic
│       └── presentation/
│           ├── cubit/          # State management
│           ├── widgets/        # Shared components
│           └── screens/        # UI pages
├── common/                     # Shared resources
└── theme/                      # Design system
```

### Tech Stack

| Category           | Technologies/Packages       | Version   |
|--------------------|-----------------------------|-----------|
| Core Framework     | Flutter                     | 3.x       |
| Language           | Dart                        | 3.8.1     |
| State Management   | flutter_bloc + Cubit        | ^9.1.1    |
| Dependency Injection | get_it                    | ^8.0.3    |
| Firebase Services  | firebase_core + firebase_auth | ^3.15.1 / ^5.6.2 |
| Navigation         | go_router                   | ^16.0.0   |
| Validation         | validateit                  | Git       |

### State Management Flow
```mermaid
sequenceDiagram
    participant UI as Presentation Layer
    participant Cubit
    participant UseCase
    participant Repository
    participant Firebase
    
    UI->>Cubit: User Interaction (Event)
    Cubit->>UseCase: Execute business logic
    UseCase->>Repository: Call repository method
    Repository->>Firebase: Access data source
    Firebase-->>Repository: Raw data
    Repository-->>UseCase: Domain entity
    UseCase-->>Cubit: Processed result
    Cubit->>UI: New state
```

This architecture ensures separation of concerns, testability, and maintainability while leveraging Firebase for backend services and BLoC/Cubit for predictable state management.
