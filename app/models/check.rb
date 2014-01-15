class Check < ActiveRecord::Base
    validates :uid, presence: true, numericality: { only_integer: true }
    validates :eid, presence: true, numericality: { only_integer: true }
    validates :realname, presence: true
end
