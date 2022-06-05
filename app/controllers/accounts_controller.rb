# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :set_account, only: %i[edit update destroy]
  before_action :set_options, only: %i[new edit create update]

  # GET /accounts
  def index
    accounts = Account.where(user: current_user).joins(:account_group)
    @accounts_enable = accounts.where(enable: true)
                               .order('"account_groups"."order", "accounts"."order"')
    @accounts_disable = accounts.where(enable: false)
                                .order('"account_groups"."order", "accounts"."order"')
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
    @account.order = Account.where(user: current_user)
                            .where(account_group_id: account_params[:account_group_id])
                            .last.order + 1

    respond_to do |format|
      if @account.save
        format.html { redirect_to accounts_url }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to accounts_url }
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
    @account_type_options = [
      ['일반', Account.account_types[:general]],
      ['카드', Account.account_types[:card]],
      ['저축', Account.account_types[:savings]],
      ['대출', Account.account_types[:loans]],
      ['투자', Account.account_types[:invest]]
    ]
  end

  # Only allow a list of trusted parameters through.
  def account_params
    params.require(:account)
          .permit(:user_id, :name, :account_group_id, :order, :enable, :start_date, :start_balance, :account_type, :include, :income, :expense, :memo)
          .merge(user: current_user, account_type: params[:account_type].to_i)
  end
end
