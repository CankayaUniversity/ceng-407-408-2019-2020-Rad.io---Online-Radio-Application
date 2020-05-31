from django.test import TestCase
from django.contrib.auth.models import User
from .integration_handler import *

# Create your tests here.

fetch_metadata('https://www.youtube.com/watch?v=6_b7RDuLwcI')

user_obj = User.objects.get(username="rka95bvpwqj7v447g48z0he0j")
create_playlist(user_obj)
