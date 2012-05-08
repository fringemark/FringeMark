require 'sinatra'
require 'sinatra/mustache'
require 'couchrest'
require 'pp'
require 'constants'

enable :sessions


get '/next-up/:slot' do
  db = CouchRest.database(FringeMark::DATABASE)
  slot = params[:slot].to_i
  rows = db.view("fringemark/all-performances", :startkey => [slot], :endkey => [slot,{}])["rows"]
  
  data = {:neighborhoods => []}
  
  FringeMark::NEIGHBORHOODS.each do |k,v|
    hood = {:name => k, :venues => []} 
    rows.select {|r| v.include? r["key"][1] }.each do |r| 
      hood[:venues] << {:name => r["key"][1], :show => r["value"][0], :id => r["value"][1]}
    end
    data[:neighborhoods] << hood
  end
  
  data[:neighborhoods].reverse!
  data[:slot] = FringeMark::SLOTS[params[:slot]][1]
    
  mustache :"next-up", :layout=> :basic, :locals => data
end