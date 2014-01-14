class Ex < ActiveRecord::Base
    validates :uid, presence: true, numericality: { only_integer: true }
    validates :money, presence: true
    validates :status, numericality: true, presence: true
    validates :capital, presence: true
    validates :step_uid, presence: true, numericality: { only_integer: true }
    validates :step_realname, presence: true        
end
