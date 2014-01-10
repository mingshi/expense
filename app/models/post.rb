class Post < ActiveRecord::Base
    belongs_to :exposes
    validates :uid, presence: true, numericality: { only_integer: true }
    validates :realname, presence: true
    validates :department, presence: true
    validates :project, presence: true
    validates :type, presence: true
    validates :money, presence: true, numericality: true
    validates :eid, presence: true, numericality: { only_integer: true }
end
