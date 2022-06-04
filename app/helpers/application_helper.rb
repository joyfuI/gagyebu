# frozen_string_literal: true

module ApplicationHelper
  def error_messages_for(model, name)
    render 'shared/error_messages', model:, name:
  end
end
