# frozen_string_literal: true

require 'application_system_test_case'

class AccountsTest < ApplicationSystemTestCase
  setup do
    @account = accounts(:one)
  end

  test 'visiting the index' do
    visit accounts_url
    assert_selector 'h1', text: 'Accounts'
  end

  test 'should create account' do
    visit accounts_url
    click_on 'New account'

    fill_in 'Account group', with: @account.account_group_id
    fill_in 'Account type', with: @account.account_type
    check 'Enable' if @account.enable
    check 'Expense' if @account.expense
    check 'Include' if @account.include
    check 'Income' if @account.income
    fill_in 'Memo', with: @account.memo
    fill_in 'Name', with: @account.name
    fill_in 'Order', with: @account.order
    fill_in 'Start balance', with: @account.start_balance
    fill_in 'Start date', with: @account.start_date
    fill_in 'User', with: @account.user_id
    click_on 'Create Account'

    assert_text 'Account was successfully created'
    click_on 'Back'
  end

  test 'should update Account' do
    visit account_url(@account)
    click_on 'Edit this account', match: :first

    fill_in 'Account group', with: @account.account_group_id
    fill_in 'Account type', with: @account.account_type
    check 'Enable' if @account.enable
    check 'Expense' if @account.expense
    check 'Include' if @account.include
    check 'Income' if @account.income
    fill_in 'Memo', with: @account.memo
    fill_in 'Name', with: @account.name
    fill_in 'Order', with: @account.order
    fill_in 'Start balance', with: @account.start_balance
    fill_in 'Start date', with: @account.start_date
    fill_in 'User', with: @account.user_id
    click_on 'Update Account'

    assert_text 'Account was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Account' do
    visit account_url(@account)
    click_on 'Destroy this account', match: :first

    assert_text 'Account was successfully destroyed'
  end
end
