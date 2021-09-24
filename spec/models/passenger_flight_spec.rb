require "rails_helper"

RSpec.describe PassengerFlight, type: :model do
  describe 'relationships' do
    it { should belong_to(:passenger)}
    it { should belong_to(:flight)}
  end

  before :each do
    @airline1 = Airline.create!(name: 'Delta')
    @airline2 = Airline.create!(name: 'American')

    @flight1 = @airline1.flights.create!(number: 1727, date: "08/03/2021", departure_city: "Raleigh", arrival_city: "Denver")
    @flight2 = @airline1.flights.create!(number: 1730, date: "08/05/2021", departure_city: "Charlotte", arrival_city: "Newark")
    @flight3 = @airline2.flights.create!(number: 1750, date: "09/03/2021", departure_city: "Miami", arrival_city: "Las Vegas")
    @flight4 = @airline2.flights.create!(number: 1700, date: "10/03/2021", departure_city: "San Francisco", arrival_city: "Houston")

    @passenger1 = Passenger.create!(name: "Andrew", age: 23)
    @passenger2 = Passenger.create!(name: "Jamison", age: 28)
    @passenger3 = Passenger.create!(name: "Kevin", age: 15)
    @passenger4 = Passenger.create!(name: "Henry", age: 10)
    @passenger5 = Passenger.create!(name: "Khoi", age: 35)
    @passenger6 = Passenger.create!(name: "Josh", age: 40)
    @passenger7 = Passenger.create!(name: "Sean", age: 10)
    @passenger8 = Passenger.create!(name: "Sarah", age: 8)

    @pf1 = PassengerFlight.create!(passenger: @passenger1, flight: @flight1)
    @pf2 = PassengerFlight.create!(passenger: @passenger2, flight: @flight1)
    @pf3 = PassengerFlight.create!(passenger: @passenger3, flight: @flight2)
    @pf4 = PassengerFlight.create!(passenger: @passenger4, flight: @flight2)
    @pf5 = PassengerFlight.create!(passenger: @passenger5, flight: @flight3)
    @pf6 = PassengerFlight.create!(passenger: @passenger6, flight: @flight3)
    @pf7 = PassengerFlight.create!(passenger: @passenger7, flight: @flight4)
    @pf8 = PassengerFlight.create!(passenger: @passenger8, flight: @flight4)
  end


  describe 'class methods' do
    it '#find_by_ids' do
      expect(PassengerFlight.find_by_ids(@passenger2, @flight1)).to eq(@pf2)
    end
  end
end
