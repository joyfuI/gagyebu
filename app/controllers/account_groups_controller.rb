# frozen_string_literal: true

class AccountGroupsController < ApplicationController
  before_action :set_account_groups, only: %i[create up down]
  before_action :set_account_group, only: %i[update destroy up down]

  # POST /account_groups
  def create
    @account_group = AccountGroup.new(account_group_params)
    @account_group.order = @account_groups.last.order + 1
    @account_group.save

    respond_to do |format|
      format.html { redirect_to new_account_url }
    end
  end

  # PATCH/PUT /account_groups/1
  def update
    @account_group.update(account_group_params)
    respond_to do |format|
      format.html { redirect_to new_account_url }
    end
  end

  # DELETE /account_groups/1
  def destroy
    @account_group.destroy

    respond_to do |format|
      format.html { redirect_to new_account_url }
    end
  end

  # PATCH/PUT /account_groups/1/up
  def up
    prev_account_group = @account_groups.where('"order" < ?', @account_group.order).last
    return if prev_account_group.blank?

    @account_group.order, prev_account_group.order = prev_account_group.order, @account_group.order
    @account_group.save && prev_account_group.save

    respond_to do |format|
      format.html { redirect_to new_account_url }
    end
  end

  # PATCH/PUT /account_groups/1/down
  def down
    next_account_group = @account_groups.where('"order" > ?', @account_group.order).first
    return if next_account_group.blank?

    @account_group.order, next_account_group.order = next_account_group.order, @account_group.order
    @account_group.save && next_account_group.save

    respond_to do |format|
      format.html { redirect_to new_account_url }
    end
  end

  private

  def set_account_groups
    @account_group = AccountGroup.new
    @account_groups = AccountGroup.where(user: current_user).order(:order)
    @account_groups_enable = @account_groups.where(enable: true)
    @account_groups_disable = @account_groups.where(enable: false)
  end

  def set_account_group
    @account_group = AccountGroup.where(user: current_user).find(params[:id])
  end

  def account_group_params
    params.require(:account_group)
          .permit(:user_id, :name, :order)
          .merge(user: current_user)
  end
end
