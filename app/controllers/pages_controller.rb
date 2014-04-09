class PagesController < ApplicationController
  def home
    @leagues = League.all
    @races = Race.all
  end

  def about
  end

  def faqs
  end
end
