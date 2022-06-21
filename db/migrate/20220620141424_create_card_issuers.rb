# frozen_string_literal: true

class CreateCardIssuers < ActiveRecord::Migration[7.0]
  def change
    create_table :card_issuers do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false, comment: '카드사 이름'
      t.integer :order, comment: '순서'
      t.integer :payment_date, null: false, comment: '결제일'
      t.date :payment_start, null: false, comment: '일시불/할부 시작월일'
      t.date :payment_end, null: false, comment: '일시불/할부 종료월일'
      t.date :cash_service_start, null: false, comment: '단기카드대출 시작월일'
      t.date :cash_service_end, null: false, comment: '단기카드대출 종료월일'

      t.timestamps
    end
  end
end
