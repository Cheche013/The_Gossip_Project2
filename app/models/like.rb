class Like < ApplicationRecord
  belongs_to :user
  belongs_to :gossip
  validates :user_id, uniqueness: { scope: :gossip_id }  # Empêche un même user de liker plusieurs fois le même potin
end
