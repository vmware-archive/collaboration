class App < ActiveRecord::Base
  has_many :owned_resources, :as => :resource
end
