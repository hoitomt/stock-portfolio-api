class StocksController < ApplicationController
  def quote

  end

  def lookup
    render json: formatted_results(params[:query])
  end

  def formatted_results(query)
    results = Api::Securities.lookup(params[:query])
    results.map{ |r| {value: "#{r["Symbol"]} - #{r["Name"]}"} }
  end
end