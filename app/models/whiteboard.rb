class Whiteboard < ApplicationRecord
  has_many :post_its, dependent: :destroy
end
