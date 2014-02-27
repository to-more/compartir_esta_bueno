class WelcomeController < ApplicationController
  def index
    @mapa = Mapa.new
  end
end
