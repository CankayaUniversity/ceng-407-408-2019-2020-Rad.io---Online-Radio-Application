import requests
import youtube_dl
from social_django.models import UserSocialAuth 
from social_django.utils import load_strategy
from django.contrib.auth.models import User

def fetch_metadata(url):
    url = 'https://www.youtube.com/watch?v=6_b7RDuLwcI'
    ydl = youtube_dl.YoutubeDL({})
    with ydl:
        video = ydl.extract_info(url, download=False)

    print('{} - {}'.format(video['artist'], video['track']))


def refresh_access_token(user):
    social = user.social_auth.get(provider='spotify')
    access_token = social.get_access_token(load_strategy())


def create_playlist(user):
    username = user.username
    refresh_access_token(user)
    spotify_users_data = UserSocialAuth.objects.all()
    spotify_users = spotify_users_data.filter(uid=username)
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


