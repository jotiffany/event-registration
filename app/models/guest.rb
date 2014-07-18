class Guest < ActiveRecord::Base
  belongs_to :table

  attr_accessor :event
end
