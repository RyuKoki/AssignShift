class User < ApplicationRecord

	has_secure_password

	has_many :actuals

	has_many :plans, :through => :actuals

end
