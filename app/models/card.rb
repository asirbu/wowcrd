class Card < ActiveRecord::Base

	def get_tracks(tags='birthday')
		# create client object with app credentials
		client = Soundcloud.new(:client_id => 'AAA', :client_secret => 'AAA', :redirect_uri => 'localhost')

		tracks = client.get('/tracks', :q=>tags)
		random_track = rand(tracks.length)
		track = tracks.at(random_track)
		embed_info = client.get('/oembed', :url => track.permalink_url)
		self.sound = embed_info['html']
	end

end
