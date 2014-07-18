class Event < ActiveRecord::Base
    has_many :tables
    has_many :guests, :through => :tables

    def total_seats
      Table.select("SUM(tables.max_seats) AS value").where(:event => self).take.value
    end

    def total_guests
      Guest.joins(:table).where("tables.event_id = ?", self.id).select("SUM(guests.assigned_seats) AS value").take.value ||= 0
    end

    def registered_guests
      Guest.joins(:table).where("tables.event_id = ? AND guests.registered = ?", self.id, :t).select("SUM(guests.assigned_seats) AS value").take.value ||= 0
    end
end
