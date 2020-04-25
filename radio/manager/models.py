from django.db import models
from django.contrib.auth import get_user_model

User = get_user_model()


class Friend(models.Model):
    name = models.CharField(max_length=100)


class Message(models.Model):
    author = models.ForeignKey(User, related_name='author_messages', on_delete=models.CASCADE)
    content = models.TextField()
    timestamp = models.DateTimeField(auto_now_add=True)

    def last_ten_messages(self):
        return Message.objects.order_by('-timestamp').all()[:10]

    def __str__(self):
        return self.author.username
