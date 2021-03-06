# frozen_string_literal: true

# Controller
class AlwaysDetailsController < ApplicationController
  def toggle
    session[:always_details] ||= false
    session[:always_details] = !session[:always_details]
    render js: "changeAlwaysDetailsSwitch(#{session[:always_details]});"
  end
end
