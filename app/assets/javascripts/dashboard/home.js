function userSelect(user_id){
	console.log(user_id);
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

function artistSelect(artist_id){
	$.ajax({
		type: "GET",
		url: "/artist_select",
		data: { 
			"artist_id" : artist_id 
		},
		success:function(data){
			var albums = JSON.parse(data["albums"]);
			replaceAlbums(albums);

			var songs = JSON.parse(data["songs"]);
      		replaceSongs(songs);
      	},
		error:function(data){}
    });
}

function albumSelect(album_id){
	console.log("IN ALBUM SELECT");
	$.ajax({
		type: "GET",
		url: "/album_select",
		data: {
			"album_id" : album_id
		},
		success: function(data){
			replaceSongs(data);
		},
		error: function(data){}
	})
}

function replaceArtists(artist_array){
	$('#artist_list').empty();
	for(var i = 0; i < artist_array.length; i++){
		$('#artist_list').append("<button onclick='artistSelect('"+artist_array[i]['id']+")'>" + artist_array[i]["name"] + "</button><br>");
	}
}

function replaceAlbums(album_array){
	$('#album_list').empty();
	for(var i = 0; i < album_array.length; i++){
		$('#album_list').append("<button onclick='albumSelect("+album_array[i]['id']+")'>" + album_array[i]["title"] + "</button><br>");
	}
}

function replaceSongs(song_array){
	$('#song_list').empty();
	for(var i = 0; i < song_array.length; i++){
		$('#song_list').append("<h4>" + song_array[i]["title"] + "</h4>");
	}
}

