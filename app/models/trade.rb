# frozen_string_literal: true

class Trade
  include Mongoid::Document
  MININUM_OFFERS_ON_TRADE = 2
  MAXIMUM_OFFERS_ON_TRADE = 2
  TRADE_FAIRNESS_FACTOR = 0.1

  field :created_at, type: Time, default: Time.now
  embeds_many :trade_offers

  validates_associated :trade_offers
  validate :allowed_trade_offer_quantity
  scope :chronologically_ordered, -> { reorder(created_at: :asc) }

  def fair?
    trade_offer_exp_list = trade_offers.map(&:offer_total_experience)
    highest_exp_from_trade = trade_offer_exp_list.max
    maximum_allowed_difference = highest_exp_from_trade * TRADE_FAIRNESS_FACTOR
    trade_offer_exp_list.select { |exp| (highest_exp_from_trade - exp) > maximum_allowed_difference }.empty?
  end

  def allowed_trade_offer_quantity
    return if (trade_offers.length >= MININUM_OFFERS_ON_TRADE) && (trade_offers.length <= MAXIMUM_OFFERS_ON_TRADE)

    errors.add(:trade_offers, 'Given number of trade offers does not respect the business rule.')
  end
end
