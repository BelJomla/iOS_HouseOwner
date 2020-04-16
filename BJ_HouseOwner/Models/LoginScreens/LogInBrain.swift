
import Foundation
import PhoneNumberKit


struct LogInBrain {
    static var countryCode: String = ""
    static var phoneNumber: String = ""
    
    
    let phoneNumberKit = PhoneNumberKit()
    
    //Function to check the validatiy of the entered phone number
    static func checkPhoneNumber() -> (Bool,String) {
        let phoneNumberKit = PhoneNumberKit()
        do {
            let combinedNumber = countryCode + phoneNumber
            let parsedNumber = try phoneNumberKit.parse(combinedNumber)
            let intenationalNumber = phoneNumberKit.format(parsedNumber, toType: .international)
            return (true,intenationalNumber)
        }
        catch {
            return (false,"")
        }
    }
    
    static func getNumberString(){
        
    }
    
}
