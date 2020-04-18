from django.urls import path

from . import views

app_name = "manager"

urlpatterns = [
    path('', views.index, name='index'),
    path('chat/<str:room_name>/', views.room, name='room'),
    path('login/', views.default_login, name='login'),
    path('register/', views.default_register, name='register'),
]
