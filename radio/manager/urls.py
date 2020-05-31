from django.urls import path, include

from . import views

app_name = "manager"

urlpatterns = [
    path('', views.room, name='index'),
    path('podcast/', views.podcast, name='podcast'),
    path('events/', views.events, name='events'),
    path('profile/', views.profile, name='profile'),
    path('login/', views.default_login, name='login'),
    path('register/', views.default_register, name='register'),
    path('logout/', views.default_logout, name='logout'),
    path('spotify_handler/<str:song_name>', views.spotify_handler, name='spotify_handler'),
]
