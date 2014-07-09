class Event < ActiveRecord::Base
    has_many :guests
    has_many :tables
end
