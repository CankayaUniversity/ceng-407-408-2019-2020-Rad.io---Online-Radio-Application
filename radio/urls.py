from django.contrib import admin
from django.urls import path
from rest_framework import routers
from django.conf.urls import url, include
from radio.manager import api_views

router = routers.DefaultRouter()
router.register(r'users', api_views.UserViewSet)
router.register(r'groups', api_views.GroupViewSet)

# Wire up our API using automatic URL routing.
# Additionally, we include login URLs for the browsable API.
urlpatterns = [
    path('', include('radio.manager.urls')),
    url('social/', include('social_django.urls', namespace='social')),
    path('api/', include(router.urls)),
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    path('admin/', admin.site.urls)
]
