# frozen_string_literal: true

class AccountGroup < ApplicationRecord
  validates :name, presence: true

  belongs_to :user
  has_many :accounts
end
