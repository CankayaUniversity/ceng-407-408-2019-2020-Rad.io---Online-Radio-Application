import requests
import youtube_dl
from social_django.models import UserSocialAuth 
from social_django.utils import load_strategy
from django.contrib.auth.models import User
from .models import *
from radio.settings import SOCIAL_AUTH_SPOTIFY_KEY


def fetch_metadata(url):
    print("fetching metedata")
    #url = 'https://www.youtube.com/watch?v=6_b7RDuLwcI'
    ydl = youtube_dl.YoutubeDL({})
    with ydl:
        video = ydl.extract_info(url, download=False)

    print('{} - {}'.format(video['artist'], video['track']))
    return video['artist'], video['track']

def refresh_access_token(user):
    print("refresh access token")
    social = user.social_auth.get(provider='spotify')
    access_token = social.get_access_token(load_strategy())


def check_playlist(user):
    """
    return playlist_id
    """
    print("checking playlist")

    playlist_id = SpotifyData.objects.filter(username=user).values('playlist_id')
    if playlist_id  != "":
        return playlist_id
    return None


def create_playlist(user):
    print("creating playlist")
    username = user.username
    refresh_access_token(user)
    spotify_users_data = UserSocialAuth.objects.all()
    spotify_user = spotify_users_data.filter(uid=username)
    access_token = spotify_users_data.values('extra_data').filter(uid=username)[0]
    print("Fetched access_token = ", access_token)
    access_token = access_token['extra_data']['access_token']
    print("Access token", access_token)
    headers = {
        'Authorization': 'Bearer {}'.format(access_token),
        'Content-Type': 'application/json',
    }

    data = '{"name":"Liked from RAD.IO", "public":false}'
    response = requests.post('https://api.spotify.com/v1/users/{}/playlists'.format(username), headers=headers, data=data)
    print(response.text)
    return response.json()["id"]


def find_song_uri(user, song_name, artist):
    print("finding song uri")
    username = user.username
    refresh_access_token(user)
    spotify_users_data = UserSocialAuth.objects.all()
    spotify_user = spotify_users_data.filter(uid=username)
    access_token = spotify_users_data.values('extra_data').filter(uid=username)[0]
    print("Fetched access_token = ", access_token)
    access_token = access_token['extra_data']['access_token']

    headers = {
        'Authorization': 'Bearer {}'.format(access_token),
    }

    query = "https://api.spotify.com/v1/search?query=track%3A{}+artist%3A{}&type=track&offset=0&limit=1".format(
        song_name,
        artist
    )
    response = requests.get(query,headers=headers).json()
    print("Response: ", response)
    uri = response["tracks"]["items"][0]["uri"]
    return uri


def add_to_playlist(user, uri, playlist_id):
    print("add to playlist")

    username = user.username
    #playlist_id = SpotifyData.objects.filter(username=user).values('playlist_id')
    playlist_id = playlist_id
    refresh_access_token(user)
    spotify_users_data = UserSocialAuth.objects.all()
    spotify_user = spotify_users_data.filter(uid=username)
    access_token = spotify_users_data.values('extra_data').filter(uid=username)[0]
    access_token = access_token['extra_data']['access_token']
    
    headers = {
        'Authorization': 'Bearer {}'.format(access_token),
        'Accept': 'application/json',
    }

    params = (
        ('uris', uri),
    )

    response = requests.post('https://api.spotify.com/v1/playlists/{}/tracks'.format(playlist_id), headers=headers, params=params)
    print(response.text)
    