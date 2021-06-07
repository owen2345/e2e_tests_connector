class Product < ApplicationRecord
  self.table_name = :products
  belongs_to :user
end
