# frozen_string_literal: true

class AccountGroupsController < ApplicationController
  before_action :set_account_groups, only: %i[create up down]
  before_action :set_account_group, only: %i[update destroy up down]

  # POST /account_groups
  def create
    @account_group = AccountGroup.new(account_group_params)
    @account_group.order = (@account_groups.last&.order || -1) + 1

    respond_to do |format|
      if @account_group.save
        format.html { redirect_to new_account_url }
      else
        format.html { redirect_to new_account_url, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account_groups/1
  def update
    respond_to do |format|
      if @account_group.update(account_group_params)
        format.html { redirect_to new_account_url }
      else
        format.html { redirect_to new_account_url, status: :unprocessable_entity }
      end
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

    respond_to do |format|
      if @account_group.save && prev_account_group.save
        format.html { redirect_to new_account_url }
      else
        format.html { redirect_to new_account_url, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account_groups/1/down
  def down
    next_account_group = @account_groups.where('"order" > ?', @account_group.order).first
    return if next_account_group.blank?

    @account_group.order, next_account_group.order = next_account_group.order, @account_group.order

    respond_to do |format|
      if @account_group.save && next_account_group.save
        format.html { redirect_to new_account_url }
      else
        format.html { redirect_to new_account_url, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_account_groups
    @account_group = AccountGroup.new
    @account_groups = AccountGroup.where(user: current_user).order(:order)
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
