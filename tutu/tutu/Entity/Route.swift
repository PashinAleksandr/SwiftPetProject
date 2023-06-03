import Foundation

struct Route {
    let dastenation: String
    let departurePoint: String
    let departureDate: Date
    let note: String
    
    func validation() throws  {
        if self.dastenation.isEmpty {
            throw ValidationErrors.emptyDastenation
        }

        if departurePoint.isEmpty {
            throw ValidationErrors.emptyDeparturePoint
        }
        
        if departureDate.description.isEmpty {
            throw ValidationErrors.emptyDepartureDate
        }
    }
}
