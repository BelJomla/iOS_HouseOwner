
import Foundation
import PhoneNumberKit


struct LogInBrain {
    static var countryCode: String = ""
    static var phoneNumber: String = "" 
    
    let phoneNumberKit = PhoneNumberKit()
    
    //Function to check the validatiy of the entered phone number
    static func checkPhoneNumber() -> Bool {
        let phoneNumberKit = PhoneNumberKit()
        do {
            _ = try phoneNumberKit.parse(countryCode + phoneNumber)
            return true
        }
        catch {
            return false
        }
    }
    
}
