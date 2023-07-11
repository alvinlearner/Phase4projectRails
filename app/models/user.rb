class User < ApplicationRecord
    has_secure_password
    has_many :events

    validates_presence_of :username, :email 
    validates_uniqueness_of :username, :email

end
