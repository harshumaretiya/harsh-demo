# frozen_string_literal: true
class Merchant < ApplicationRecord
  #Association
  belongs_to :user
end
