class ApplicationController < ActionController::Base

  private
  def to_boolean(string)
    ActiveRecord::Type::Boolean.new.cast(string)
  end
end
