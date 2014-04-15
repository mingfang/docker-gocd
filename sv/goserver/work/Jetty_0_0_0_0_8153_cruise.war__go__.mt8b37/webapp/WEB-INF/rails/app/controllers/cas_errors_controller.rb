class CasErrorsController < ApplicationController
  def user_disabled
    @no_tabs = true
  end

  def user_unknown
    @no_tabs = true
  end
end