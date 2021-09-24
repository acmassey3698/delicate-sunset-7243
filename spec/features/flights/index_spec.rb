require "rails_helper"

RSpec.describe 'flights index' do
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

    PassengerFlight.create!(passenger: @passenger1, flight: @flight1)
    PassengerFlight.create!(passenger: @passenger2, flight: @flight1)
    PassengerFlight.create!(passenger: @passenger3, flight: @flight2)
    PassengerFlight.create!(passenger: @passenger4, flight: @flight2)
    PassengerFlight.create!(passenger: @passenger5, flight: @flight3)
    PassengerFlight.create!(passenger: @passenger6, flight: @flight3)
    PassengerFlight.create!(passenger: @passenger7, flight: @flight4)
    PassengerFlight.create!(passenger: @passenger8, flight: @flight4)

    visit flights_path
  end

  it 'shows all flight numbers and the name of the airline' do
    within "#flight-#{@flight1.id}" do
      expect(page).to have_content(@flight1.number)
      expect(page).to have_content(@flight1.airline.name)
    end

    within "#flight-#{@flight2.id}" do
      expect(page).to have_content(@flight2.number)
      expect(page).to have_content(@flight2.airline.name)
    end

    within "#flight-#{@flight3.id}" do
      expect(page).to have_content(@flight3.number)
      expect(page).to have_content(@flight3.airline.name)
    end

    within "#flight-#{@flight4.id}" do
      expect(page).to have_content(@flight4.number)
      expect(page).to have_content(@flight4.airline.name)
    end
  end

  it 'shows the names of all the flights passengers' do
    within "#flight-#{@flight1.id}" do
      expect(page).to have_content(@passenger1.name)
      expect(page).to have_content(@passenger2.name)
      expect(page).to_not have_content(@passenger3.name)
    end

    within "#flight-#{@flight2.id}" do
      expect(page).to have_content(@passenger3.name)
      expect(page).to have_content(@passenger4.name)
      expect(page).to_not have_content(@passenger1.name)
    end

    within "#flight-#{@flight3.id}" do
      expect(page).to have_content(@passenger5.name)
      expect(page).to have_content(@passenger6.name)
      expect(page).to_not have_content(@passenger3.name)
    end

    within "#flight-#{@flight4.id}" do
      expect(page).to have_content(@passenger7.name)
      expect(page).to have_content(@passenger8.name)
      expect(page).to_not have_content(@passenger5.name)
    end
  end
end
