# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

# pod to check phone number format  with the  given code number
pod 'PhoneNumberKit', '~> 3.1'

# for Firebase
pod 'Firebase/Firestore'
pod 'Firebase/Auth'

# Realm for local storage
#pod 'RealmSwift'

target 'BJ_HouseOwner' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  pod 'RealmSwift'
  # Pods for BJ_HouseOwner
  
  target 'BJ_HouseOwnerTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'RealmSwift'
  end
  
  target 'BJ_HouseOwnerUITests' do
    # Pods for testing
    pod 'RealmSwift'
  end
  
end
