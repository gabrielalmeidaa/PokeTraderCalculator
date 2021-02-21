# frozen_string_literal: true

class TradesController < ApplicationController

  def new
    @pokemon_list = Pokemon.all
  end

  def create
    trade_offers = parse_trade_offers_from_params
    @trade = Trade.new(trade_offers: trade_offers)
    if @trade.save
      redirect_to :new, notice: "Trade was successfully created."
    else
      redirect_to :new, status: :unprocessable_entity
    end
  end

  def parse_trade_offers_from_params
    trade_offers = []
    trade_params.fetch('trade_offers').each do |_, pokemon_id_list|
      pokemon_ids = pokemon_id_list.select(&:present?)
      trade_offers.append(TradeOffer.new(pokemons: pokemon_ids.map { |id| Pokemon.get_by_id(id.to_i) }))
    end
    trade_offers
  end

  def historic
    @trades = Trade.all.chronologically_ordered
  end

  private

  # Only allow a trusted parameter "white list" through.
  def trade_params
    params.permit(trade_offers: {})
  end
end
