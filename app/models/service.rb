class Service < ActiveRecord::Base
  has_many :owned_resources, :as => :resource
end
