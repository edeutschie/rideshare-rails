class Driver < ApplicationRecord
  has_many :trips
  validates :name, presence: true, length: { minimum: 2 }
  validates :vin, presence: true, uniqueness: true, length: { is: 17 }

  # dont need this method - has_many builds this method for me :)
  # def get_trips
  #   trips = Trip.all
  #   trips_of_driver = trips.map { |trip| trip if trip.driver_id == id}.compact
  #   trips_of_driver.empty? ? nil : trips_of_driver
  # end

  def calculate_average_rating()
    # could possible return "NA" instead of nil - mostly cause you aren't including
    # any testing with this application
    return nil if trips.empty?
    ratings = trips.map { |trip| trip.rating }
    average = (ratings.sum.to_f) / (ratings.length)
    average.round(2)
  end

  def calculate_earnings
    return nil if trips.empty?
    total_cost_in_cents = trips.map { |trip| trip.cost_in_cents.to_f }.sum
    total_cost_in_dollars = total_cost_in_cents / 100
    drivers_earnings = total_cost_in_dollars * 0.85
    drivers_earnings.round(2)
  end

end
