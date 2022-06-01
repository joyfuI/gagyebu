# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    @@default_account_group = [
      { name: '현금' },
      { name: '예적금' },
      { name: '카드' },
      { name: '대출' },
      { name: '저축성 보험' },
      { name: '바우처' },
      { name: '대여금' },
      { name: '투자' }
    ]

    # POST /resource
    def create
      super do |resource|
        @@default_account_group.each_with_index do |account_group, i|
          AccountGroup.create(user: resource, name: account_group[:name], order: i)
        end
      end
    end

    # DELETE /resource
    def destroy
      AccountGroup.destroy_by(user: current_user)
      super
    end
  end
end
