# frozen_string_literal: true

require 'application_system_test_case'

class AccountGroupsTest < ApplicationSystemTestCase
  setup do
    @account_group = account_groups(:one)
  end

  test 'visiting the index' do
    visit account_groups_url
    assert_selector 'h1', text: 'Account groups'
  end

  test 'should create account group' do
    visit account_groups_url
    click_on 'New account group'

    check 'Enable' if @account_group.enable
    fill_in 'Name', with: @account_group.name
    fill_in 'Order', with: @account_group.order
    fill_in 'User', with: @account_group.user_id
    click_on 'Create Account group'

    assert_text 'Account group was successfully created'
    click_on 'Back'
  end

  test 'should update Account group' do
    visit account_group_url(@account_group)
    click_on 'Edit this account group', match: :first

    check 'Enable' if @account_group.enable
    fill_in 'Name', with: @account_group.name
    fill_in 'Order', with: @account_group.order
    fill_in 'User', with: @account_group.user_id
    click_on 'Update Account group'

    assert_text 'Account group was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Account group' do
    visit account_group_url(@account_group)
    click_on 'Destroy this account group', match: :first

    assert_text 'Account group was successfully destroyed'
  end
end
