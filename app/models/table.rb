class Table < ActiveRecord::Base
  belongs_to :event
  has_many :seats
end
