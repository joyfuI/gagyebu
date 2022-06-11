# frozen_string_literal: true

class AccountGroup < ApplicationRecord
  belongs_to :user
  has_many :accounts
end
