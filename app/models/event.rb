class Event < ApplicationRecord
    has_many :posts
    has_many :attendees
end
