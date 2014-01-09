class Expose < ActiveRecord::Base
    has_many :posts
    validdates :money, presence: true
end
