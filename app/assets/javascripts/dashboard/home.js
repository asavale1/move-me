function userSelect(user_id){
	$.ajax({
		type: "GET",
		url: "/user_select",
		data: {
			"user_id" : user_id
		},
		success: function (data) {
			var artists = JSON.parse(data["artists"]);
			var albums = JSON.parse(data["albums"]);
			var songs = JSON.parse(data["songs"]);
			replaceArtists(artists);
			replaceAlbums(albums);
			replaceSongs(songs);
		},
		error: function(data){

		}
	});
}

function replaceSongs(playlist_id, playlists_size, playlist_position){

	$.ajax({
		type: "GET",
		url: "/playlists",
		data: { 
			"playlist_id" : playlist_id 
		},
		success:function(data){
			console.log(data);

			var songs = data.songs;
			$('ul#song_list').empty();

			for(var i = 0; i < songs.length; i++){
				$('ul#song_list').append("<li>" + songs[i]["name"] + "</li>");
			}

			for(var j = 0; j < playlists_size; j++){
				if(j == playlist_position ){
					$('#playlist' + j).css("background-color", "#a188fa");
					$('#playlist' + j).attr("data-selected", "true");
				}else{
					$('#playlist' + j).css("background-color", "#21053e");
					$('#playlist' + j).attr("data-selected", "false");
				}
			}

			$('button#add_song').html("Add To " + data.name);

		},		
		error:function(data){}
	});
}

function addToPlaylist(){
	var playlist_id = $("button[data-selected='true']").attr("data-id");
	var songs_id = []

	$("input:checked").each(function (){
		songs_id.push($(this).val());
	});

	$.ajax({
		type: "POST",
		url: "/playlista",
		data: {
			"playlist" : playlist_id,
			"songs" : songs_id
		},
		success: function(data){
			if(data.status){
				var playlist = JSON.parse(data.playlist);
				$('ul#song_list').empty();

				for(var i = 0; i < playlist.songs.length; i++){
					$('ul#song_list').append("<li>" + playlist.songs[i]["name"] + "</li>");
				}
			}else{
				console.log("INVALID");
			}
		},
		error: function(data){}
	});
}


