class Table < ActiveRecord::Base
  belongs_to :event
  has_many :guests

  def unassigned_seats
    Table.joins("LEFT JOIN guests ON guests.table_id = tables.id").where("tables.id = ?", self.id).select("tables.max_seats - SUM(guests.assigned_seats) AS value").take.value ||= self.max_seats
  end

  def occupied_seats
    Guest.select("SUM(guests.assigned_seats) AS value").where(:table => self, :registered => :t).take.value ||= 0
  end
end
