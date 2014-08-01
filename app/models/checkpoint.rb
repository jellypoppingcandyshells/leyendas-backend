class Checkpoint < ActiveRecord::Base
	validates :name, presence: true
end
