# frozen_string_literal: true

class CreateAccountGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :account_groups do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false, comment: '자산그룹 이름'
      t.integer :order, comment: '순서'
      t.boolean :enable, default: true, comment: '사용 여부'

      t.timestamps
    end
  end
end
