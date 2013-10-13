class Card < ActiveRecord::Base
	validates_presence_of :name
	validates_presence_of :tag
	validates_presence_of :message


	def get_tracks(tags='birthday')
		# create client object with app credentials
		client = Soundcloud.new(:client_id => 'AAA', :client_secret => 'AAA', :redirect_uri => 'localhost')

		tracks = client.get('/tracks', :q=>tags)
		random_track = rand(tracks.length)
		track = tracks.at(random_track)
		embed_info = client.get('/oembed', :url => track.permalink_url)
		self.sound = embed_info['html']
	end

	def get_images(tags='birthday')
		EyeEmConnector.configure do |config| config.client_id = 'ZZZ'
			config.client_secret = 'AAA'
			config.access_token = 'AAA'
		end
		results = EyeEmConnector.get('search', {:q=>"birthday", :includeAlbums=>1, :limit=>50})
		b = results.env[:body]
		a = b["albums"]
		i = a["items"]

		sorted = i.sort_by {|likes| likes["totalLikers"] }
		random_image = rand(10)
		item = sorted.at(sorted.length - random_image)
		array = item["thumbUrl"].split("/200/")

		new_string = array[0] + "/500/" + array[1]

		self.image = new_string

	end
end
