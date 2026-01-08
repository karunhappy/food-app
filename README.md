# Mobile Food Ordering Application (SwiftUI)
The app allows users to browse food items, add them to a cart, place an order, and view submitted orders.

The project focuses on **clean architecture, MVVM, local persistence, and Firestore integration**, without user authentication.

## Technologies Used

### UI & Architecture

* **SwiftUI** – Declarative UI framework
* **MVVM** – Clear separation of View, ViewModel, and Data layer

### Local Storage

* **SwiftData** – Used to persist cart items locally

  * Cart remains available across app restarts
  * Cart updates automatically reflect in UI

### Remote Backend

* **Firebase Firestore**

  * Used only for **order submission and order history**
  * No authentication required
  * Orders stored as documents in Firestore

## App Modules

### Home

* Displays list of food items
* Allows increment/decrement of item quantity
* Shows bottom summary bar (items count + total price)
* Bottom bar hides automatically when cart is empty

### Cart

* Displays cart items from SwiftData
* Allows:

  * Increase / decrease quantity
  * Delete individual items
* Checkout form (Name & Phone Number)
* Animated checkout form
* Progress indicator while placing order
* Clears cart after successful order

### Orders

* Fetches submitted orders from Firestore
* Displays order list sorted by latest first


## How to Run the App

### Prerequisites

* Xcode **15+**
* iOS **17+**
* Swift **5.9+**
* A Firebase project with Firestore enabled


### Steps

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   ```

2. **Open the project**

   ```bash
   open FoodOrderingApp.xcodeproj
   ```

3. **Add Firebase**

   * Add `GoogleService-Info.plist` to the project
   * Ensure it is added to the app target

4. **Install Firebase via Swift Package Manager**

   * FirebaseFirestore

5. **Run the app**

   * Select a simulator or device
   * Press ▶️ Run

## Assumptions Made

* No user authentication is required
* Cart data is stored **locally using SwiftData**
* Orders are stored **remotely in Firestore**
* Prices are static and defined locally
