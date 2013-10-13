class Card < ActiveRecord::Base
	validates_presence_of :name
	validates_presence_of :tag
	validates_presence_of :message


def get_tracks(tags='birthday')
  # create client object with app credentials
  client = Soundcloud.new(:client_id => 'AAA', :client_secret => 'AAA', :redirect_uri => 'localhost')

  tag_array = tags.split(",")
  first_tag = tag_array[0]

  tracks = client.get('/tracks', :q=>first_tag)
  random_track = rand(tracks.length)
  track = tracks.at(random_track)
  embed_info = client.get('/oembed', :url => track.permalink_url)
  self.sound = embed_info['html']
  self.track_id = track.id
end


def get_images(tags='birthdaycake, geburtstagskind, baloons')
	EyeEmConnector.configure do |config| config.client_id = 'ZZZ'
		config.client_secret = 'AAA'
		config.access_token = 'AAA'
	end

	items = []
	tag_array = tags.split(",")
	tag_array.each do |query|
		query.strip!
		results = EyeEmConnector.get('search', {:q=>query, :includeAlbums=>1, :limit=>50})
		b = results.env[:body]
		a = b["albums"]
		i = a["items"]
		items.concat(i)
	end

	sorted = items.sort_by {|likes| likes["totalLikers"] }
	nr = 10
	if sorted.length < 10
		nr = sorted.length
	end
	random_image = rand(10)
	item = sorted.at(sorted.length - random_image)
	array = item["thumbUrl"].split("/200/")

	new_string = array[0] + "/500/" + array[1]
	self.image = new_string
end
end
