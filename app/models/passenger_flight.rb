class PassengerFlight < ApplicationRecord
  belongs_to :passenger
  belongs_to :flight

  def self.find_by_ids(passenger, flight)
     where("passenger_id = ?", passenger.id)
    .where("flight_id = ?", flight.id)
    .first
  end
end
