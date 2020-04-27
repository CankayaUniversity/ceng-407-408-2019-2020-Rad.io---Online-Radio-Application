from django.db import models
from django.contrib.auth import get_user_model
from datetime import datetime

User = get_user_model()


class Podcast(models.Model):
    title = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    url = models.CharField(max_length=255)
    description = models.CharField(max_length=255)
    date = models.DateTimeField(default=datetime.now, blank=True)
    view_count = models.IntegerField(default=0)

    def __str__(self):
        return "{}: {}".format(self.name, self.title)


class Event(models.Model):
    name = models.CharField(max_length=255)
    description = models.CharField(max_length=255)
    location = models.CharField(max_length=255)
    date = models.DateTimeField(default=datetime.now, blank=True)
    image = models.CharField(max_length=255)
    event_type = models.CharField(max_length=255)

    def __str__(self):
        return "{}: {}".format(self.name, self.location)


class LiveStream(models.Model):
    url = models.CharField(max_length=255)

    def __str__(self):
        return "{}".format(self.url)
