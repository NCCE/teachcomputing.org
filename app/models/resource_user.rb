class ResourceUser < ApplicationRecord
    belongs_to :user
    belongs_to :resource_users
    
    has_many :resource_users
end
