# Generated by Django 3.0.2 on 2020-05-31 13:42

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('manager', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='livestream',
            name='part',
            field=models.CharField(default='', max_length=255),
        ),
    ]