json.array!(@cards) do |card|
  json.extract! card, :name, :tag, :message, :image, :sound
  json.url card_url(card, format: :json)
end