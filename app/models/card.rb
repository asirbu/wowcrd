class Card < ActiveRecord::Base

	def get_tracks
		# create client object with app credentials
		client = Soundcloud.new(:client_id => 'AAA',
			:client_secret => 'AAA',
			:redirect_uri => 'localhost')

		tracks = client.get('/tracks', :q=>'birthday')
		track = tracks.first
		self.sound = track
	end

end
