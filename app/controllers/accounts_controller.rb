# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :set_accounts, only: %i[index create up down]
  before_action :set_account, only: %i[edit update destroy up down]
  before_action :set_options, only: %i[new edit create update]

  @@account_types = {
    general: '일반',
    card: '카드',
    savings: '저축',
    loans: '대출',
    invest: '투자'
  }

  # GET /accounts
  def index
    @accounts_enable = @accounts.where(enable: true)
    @accounts_disable = @accounts.where(enable: false)
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit; end

  # POST /accounts
  def create
    @account = Account.new(account_params)
    @account.order = (@accounts.where(account_group_id: account_params[:account_group_id])
                               .last&.order || -1) + 1
    @account.save

    respond_to do |format|
      format.html { redirect_to accounts_url }
    end
  end

  # PATCH/PUT /accounts/1
  def update
    @account.update(account_params)
    respond_to do |format|
      format.html { redirect_to accounts_url }
    end
  end

  # DELETE /accounts/1
  def destroy
    @account.destroy

    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
    end
  end

  # PATCH/PUT /accounts/1/up
  def up
    accounts = @accounts.where(enable: @account.enable)
    prev_account = accounts.where('"accounts"."order" < ?', @account.order).last
    return if prev_account.blank?

    @account.order, prev_account.order = prev_account.order, @account.order
    @account.save && prev_account.save

    respond_to do |format|
      format.html { redirect_to accounts_url }
    end
  end

  # PATCH/PUT /accounts/1/down
  def down
    accounts = @accounts.where(enable: @account.enable)
    next_account = accounts.where('"accounts"."order" > ?', @account.order).first
    return if next_account.blank?

    @account.order, next_account.order = next_account.order, @account.order
    @account.save && next_account.save

    respond_to do |format|
      format.html { redirect_to accounts_url }
    end
  end

  private

  def set_accounts
    @accounts = Account.where(user: current_user)
                       .joins(:account_group)
                       .order('"account_groups"."order", "accounts"."order"')
  end

  def set_account
    @account = Account.where(user: current_user).find(params[:id])
  end

  def set_account_groups
    @account_group = AccountGroup.new
    @account_groups = AccountGroup.where(user: current_user).order(:order)
  end

  def set_options
    set_account_groups
    @account_group_options = @account_groups.map { |account_group| [account_group.name, account_group.id] }
    @account_type_options = Account.account_types.to_a.map { |k, v| [@@account_types[k.to_sym], v] }
  end

  def account_params
    params.require(:account)
          .permit(:user_id, :name, :account_group_id, :order, :enable, :start_date, :start_balance, :account_type, :include, :income, :expense, :memo)
          .merge(user: current_user, account_type: params[:account_type].to_i)
  end
end
