# frozen_string_literal: true

class Account < ApplicationRecord
  validates :name, :start_date, presence: true

  belongs_to :user
  belongs_to :account_group

  # 0-일반, 1-카드, 2-저축, 3-대출, 4-투자
  enum :account_type, %i[general card savings loans invest]
end
