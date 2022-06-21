# frozen_string_literal: true

class CardIssuer < ApplicationRecord
  validates :name, :payment_date, :payment_start, :payment_end, :cash_service_start, :cash_service_end, presence: true

  belongs_to :user
end
