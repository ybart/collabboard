class Passkey < ApplicationRecord
  belongs_to :user

  validates :label, presence: true, uniqueness: { scope: :user }
  validates :external_id, uniqueness: true
  validates :public_key, presence: true, uniqueness: true
end
