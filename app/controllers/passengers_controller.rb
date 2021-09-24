class PassengersController < ApplicationController
  def destroy
    passenger = Passenger.find(params[:id])
    flight = Flight.find(params[:flight_id])
    pass_flight = PassengerFlight.find_by_ids(passenger, flight)
    pass_flight.destroy
    redirect_to flights_path
  end
end
