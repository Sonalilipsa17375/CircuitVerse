# frozen_string_literal: true

class ProfileDecorator < SimpleDelegator
  include ActionView::Helpers::DateHelper

  def profile
    __getobj__
  end

  def member_since
    distance_of_time_in_words(Time.now.to_i, profile.created_at.to_i, include_seconds: true)
  end

  def country_name
    country = ISO3166::Country[profile.country]
    country ? country.translations[I18n.locale.to_s] || country.name : nil
  end

  def mail_subscription
    profile.subscribed? ? "Subscribed" : "Not Subscribed"
  end

  def total_circuits
    profile.projects.count
  end
end
