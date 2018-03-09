class Launch < ApplicationRecord
  belongs_to :credential
  belongs_to :enrollment
end
