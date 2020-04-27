from .models import *
from datetime import datetime


def create_live_stream(url):
    LiveStream.objects.create(url=url)


def create_event(name, description, location, image, event_type):
    Event.objects.create(name=name, description=description, location=location, image=image, event_type=event_type)


def create_podcast(title, name, url, description):
    Podcast.objects.create(title=title, name=name, url=url, description=description)


if __name__ == '__main__':
create_live_stream("https://www.youtube.com/embed/tNkZsRW7h2c")
create_event("Metallica", "Ankara", "Ankara", "https://hyperpix.net/wp-content/uploads/2019/08/metallica-logo-font-download.jpg",
             "Concert")
create_podcast("Joe Rogan Experience #1169 - Elon Musk", "JRE", "https://www.youtube.com/embed/ycPr5-27vSI",
               "Elon Musk is a business magnet, investor and engineer.")
create_event("Megadeth", "Istanbul", "Istanbul", "https://i.pinimg.com/originals/92/a1/cc/92a1cce1b1dd779295c28b2e8fcda687.jpg",
             "Concert")
create_event("AC/DC", "Ankara", "Ankara", "https://tonimarino.co.uk/wp-content/uploads/2018/08/ac-dc-logo.png",
             "Concert")
create_podcast("Joe Rogan Experience #1368 - Edward Snowden", "JRE", "https://www.youtube.com/embed/efs3QRr8LWw",
               "Edward Snowden is an American whistleblower who copied and leaked highly classified information from the National Security Agency ")
create_podcast("Amanda Rousseau, Endgame - Hack Naked News #124", "Security Weekly", "https://www.youtube.com/embed/I3ISFPbVgVw",
               "Amanda Rousseau (aka Malware Unicorn) of Endgame joins us to discuss ransomware and malware protection on this episode of Hack Naked News!")
