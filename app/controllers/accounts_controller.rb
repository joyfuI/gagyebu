# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :set_account, only: %i[ show edit update destroy ]
  before_action :set_options, only: %i[new edit create update]

  # GET /accounts
  def index
    @accounts = Account.all
  end

  # GET /accounts/1
  def show; end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit; end

  # POST /accounts
  def create
    @account = Account.new(account_params)
    @account.order = Account.where(user: current_user)
                            .where(account_group_id: account_params[:account_group_id])
                            .count

    respond_to do |format|
      if @account.save
        format.html { redirect_to account_url(@account), notice: 'Account was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to account_url(@account), notice: 'Account was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  def destroy
    @account.destroy

    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_account
    @account = Account.find(params[:id])
  end

  def set_options
    account_groups = AccountGroup.where(user: current_user).order(:order)
    @account_group_options = account_groups.map { |account_group| [account_group.name, account_group.id] }
    @account_type_options = [['일반', 0], ['카드', 1], ['저축', 2], ['대출', 3], ['투자', 4]]
  end

  # Only allow a list of trusted parameters through.
  def account_params
    params.require(:account)
          .permit(:user_id, :name, :account_group_id, :order, :enable, :start_date, :start_balance, :account_type, :include, :income, :expense, :memo)
          .merge(user: current_user, account_type: params[:account_type].to_i)
  end
end
