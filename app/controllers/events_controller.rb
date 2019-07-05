# frozen_string_literal: true

# EventsController Class
class EventsController < ApplicationController
  def index
    search_params = get_search_params(
      params, %w[location title_or_description]
    )
    query = Event.list
    if search_params.present?
      search_params.keys.each do |param|
        query = query.send("search_by_#{param}", search_params[param])
      end
    end

    @events = query.all
  end

  def search_by_location
    query = Event.list
    if params[:location].present?
      query = query.search_by_location(params[:location])
    end
    @events = query.all
    render json: @events
  end

  def search_by_title_or_description
    query = Event.list
    if params[:title_or_description].present?
      query = query.search_by_title_or_description(
        params[:title_or_description]
      )
    end
    @events = query.all
    render json: @events
  end

  # date format for start_date or end_date is not precise enough
  def date_filter
    query = Event.list
    if params.present? &&
       params[:start_date].present? &&
       params[:end_date].present?
      query = query.between_dates(params[:start_date], params[:end_date])
    end
    @events = query.all
    render json: @events
  end

  private

  def get_search_params(params, specific_keys = [])
    return nil if params.nil? || params[:search].nil?

    params[:search].tap do |parameters|
      parameters.keep_if do |key, value|
        Event::ALLOWED_SEARCH_KEYS.include?(key.to_s) && value.present?
      end
    end.tap do |parameters|
      parameters.keep_if do |key, value|
        specific_keys.include? key.to_s
      end if specific_keys.present?
    end
  end
end
