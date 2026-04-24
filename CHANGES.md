# User List App

## Issues Identified

## Explanation (bugs, fixes, decisions)
**Bug 1 — JSON decode mismatch (critical):** UserAPIClient.fetchUsers() tried to decode the response as { "users": [...] } but the API returns a bare array. Every fetch threw a DecodingError, so the list never displayed. Fixed by decoding directly as [User].self.

**Bug 2 — User not Identifiable:** List(users) { ... } requires elements to be Identifiable. Without it the code won't compile. Added Identifiable to User; the existing let id: Int satisfies the protocol automatically.

**Bug 3 — @ObservedObject instead of @State:** @ObservedObject does not own the object — SwiftUI can recreate the ViewModel on view re-renders, losing state and firing duplicate loads. Adopted newer Swift's observation framework and changed to @State so the ViewModel lifetime is tied to the view.

**Bug 4 — No @MainActor on ViewModel:** @Published state mutations from an async context must happen on the main thread. Without @MainActor, the state = .loading / .loaded / .failed assignments can cross threads and cause runtime warnings or crashes.

**Design decisions:** Implemented APIClientProvider so the ViewModel takes a protocol, not the concrete struct — this is the only way to inject a MockAPIClient in unit tests without hitting the network. Used MVVM as a design pattern.