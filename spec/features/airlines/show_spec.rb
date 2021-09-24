require 'rails_helper'

RSpec.describe 'airlines show page' do
  before :each do
    @airline1 = Airline.create!(name: 'Delta')
    @airline2 = Airline.create!(name: 'American')

    @flight1 = @airline1.flights.create!(number: 1727, date: "08/03/2021", departure_city: "Raleigh", arrival_city: "Denver")
    @flight2 = @airline1.flights.create!(number: 1730, date: "08/05/2021", departure_city: "Charlotte", arrival_city: "Newark")
    @flight3 = @airline2.flights.create!(number: 1750, date: "09/03/2021", departure_city: "Miami", arrival_city: "Las Vegas")
    @flight4 = @airline2.flights.create!(number: 1700, date: "10/03/2021", departure_city: "San Francisco", arrival_city: "Houston")
    @flight5 = @airline1.flights.create!(number: 100, date: "10/4/1998", departure_city: 'PDX', arrival_city: 'RDU')
    @flight6 = @airline1.flights.create!(number: 100, date: "10/4/1998", departure_city: 'LAX', arrival_city: 'PHL')
    @flight7 = @airline1.flights.create!(number: 100, date: "10/4/1998", departure_city: 'SLC', arrival_city: 'DFW')

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
    PassengerFlight.create!(passenger: @passenger3, flight: @flight1)
    PassengerFlight.create!(passenger: @passenger4, flight: @flight1)
    PassengerFlight.create!(passenger: @passenger5, flight: @flight2)
    PassengerFlight.create!(passenger: @passenger6, flight: @flight2)
    PassengerFlight.create!(passenger: @passenger7, flight: @flight2)
    PassengerFlight.create!(passenger: @passenger8, flight: @flight4)

    #this passenger is on two flights for @airline1
    PassengerFlight.create!(passenger: @passenger1, flight: @flight2)
    PassengerFlight.create!(passenger: @passenger1, flight: @flight5)
    PassengerFlight.create!(passenger: @passenger1, flight: @flight6)
    PassengerFlight.create!(passenger: @passenger1, flight: @flight7)

    PassengerFlight.create!(passenger: @passenger2, flight: @flight2)
    PassengerFlight.create!(passenger: @passenger2, flight: @flight5)
    PassengerFlight.create!(passenger: @passenger2, flight: @flight6)

    PassengerFlight.create!(passenger: @passenger6, flight: @flight6)

    visit airline_path(@airline1)
  end

  it 'shows a list of distinct passengers flying on that airline' do
    expect(page).to have_content(@passenger1.name, count: 1)
    expect(page).to have_content(@passenger2.name, count: 1)
    expect(page).to have_content(@passenger5.name, count: 1)
    expect(page).to have_content(@passenger6.name, count: 1)
    expect(page).to_not have_content(@passenger8.name)
  end

  it 'only shows the passengers that are over 18' do
    expect(page).to_not have_content(@passenger3.name)
    expect(page).to_not have_content(@passenger4.name)
    expect(page).to_not have_content(@passenger7.name)
  end

  # it 'orders the passengers by frequent flyers' do
  #   expect(@passenger1.name).to appear_before(@passenger2.name)
  #   expect(@passenger2.name).to appear_before(@passenger6.name)
  #   expect(@passenger6.name).to appear_before(@passenger5.name)
  # end
end
