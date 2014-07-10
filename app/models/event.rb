class Event < ActiveRecord::Base
    has_many :tables
    has_many :guests, :through => :tables
end
