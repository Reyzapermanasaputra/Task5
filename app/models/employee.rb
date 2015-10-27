class Employee < ActiveRecord::Base
  has_many :motors, class_name: "Bikes"
end
