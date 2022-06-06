# frozen_string_literal: true

class AccountGroupsController < ApplicationController
  before_action :set_account_group, only: %i[update destroy]

  # POST /account_groups
  def create
    @account_group = AccountGroup.new(account_group_params)

    respond_to do |format|
      if @account_group.save
        format.html { redirect_to account_group_url(@account_group), notice: 'Account group was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account_groups/1
  def update
    respond_to do |format|
      if @account_group.update(account_group_params)
        format.html { redirect_to account_group_url(@account_group), notice: 'Account group was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account_groups/1
  def destroy
    @account_group.destroy

    respond_to do |format|
      format.html { redirect_to account_groups_url, notice: 'Account group was successfully destroyed.' }
    end
  end

  private

  def set_account_group
    @account_group = AccountGroup.where(user: current_user).find(params[:id])
  end

  def account_group_params
    params.require(:account_group).permit(:user_id, :name, :order)
  end
end
