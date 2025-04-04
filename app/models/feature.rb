class Feature < ApplicationRecord
  has_many :place_features, dependent: :destroy
  has_many :places, through: :place_features

end
