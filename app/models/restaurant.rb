require "data_fetch/main.rb"
class Restaurant
  def self.get_details
    response = DataFetch::Main.get_restaurents
    if response["message"]["text"].eql?("OK")
      response_to_send = []
      response["businesses"].each do |data_hash|
        response_to_send.push({ 
          "restaurant_name" => data_hash["name"],
          "review_count" => data_hash["review_count"],
          "address" => {
            "latitude" => data_hash["latitude"],
            "longitude" => data_hash["longitude"],
            "city" => data_hash["city"],
            "state" => data_hash["state"],
            "zipcode" => data_hash["zip"]
          },
          "rating" => data_hash["avg_rating"]
        })
      end
      { "status" => true, "data" => (response_to_send.sort_by{ |k| k["review_count"] } rescue []) }
    else
      { "status" => false, "data" => nil }
    end
  end
end