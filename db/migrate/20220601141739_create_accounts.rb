# frozen_string_literal: true

class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false, comment: '자산 이름'
      t.references :account_group, null: false, foreign_key: true
      t.integer :order, comment: '순서'
      t.boolean :enable, default: true, comment: '사용 여부'
      t.datetime :start_date, null: false, comment: '잔액 시작일'
      t.integer :start_balance, default: 0, comment: '시작 잔액'
      t.integer :account_type, default: 0, comment: '타입'
      t.boolean :include, default: true, comment: '자산합계 포함 여부'
      t.boolean :income, default: true, comment: '수입 사용 여부'
      t.boolean :expense, default: true, comment: '지출 사용 여부'
      t.text :memo, comment: '메모'

      t.timestamps
    end
  end
end
