import requests
import youtube_dl
from social_django.models import UserSocialAuth 
from social_django.utils import load_strategy
from django.contrib.auth.models import User
from .models import *
from radio.manager.settings import SOCIAL_AUTH_SPOTIFY_KEY

def fetch_metadata(url):
    url = 'https://www.youtube.com/watch?v=6_b7RDuLwcI'
    ydl = youtube_dl.YoutubeDL({})
    with ydl:
        video = ydl.extract_info(url, download=False)

    print('{} - {}'.format(video['artist'], video['track']))


def refresh_access_token(user):
    social = user.social_auth.get(provider='spotify')
    access_token = social.get_access_token(load_strategy())


def check_playlist(user):
    """
    return playlist_id
    """
    playlist_id = SpotifyData.objects.filter(user=user).values('playlist_id')
    if playlist_id  != "":
        return playlist_id
    return None


def create_playlist(user):
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


def find_song_uri(song_name, artist):
    headers = {
        'Authorization': 'Bearer {}'.format(SOCIAL_AUTH_SPOTIFY_KEY),
    }

    params = (
        ('q', song_name),
        ('type', artist),
        ('offset', '20'),
        ('limit', '2'),
    )

    response = requests.get('https://api.spotify.com/v1/search', headers=headers, params=params).json()
    uri = response["tracks"]["items"][0]["uri"]
    return uri


def add_to_playlist(user, song):
    username = user.username
    playlist_id = SpotifyData.objects.filter(user=user).values('playlist_id')
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
        ('uris', 'spotify:track:4iV5W9uYEdYUVa79Axb7Rh,spotify:track:1301WleyT98MSxVHPZCA6M'),
    )

    response = requests.post('https://api.spotify.com/v1/playlists/{}/tracks'.format(playlist_id), headers=headers, params=params)

