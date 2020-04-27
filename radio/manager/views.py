from django.shortcuts import render, redirect
from django.views import generic
from .forms import NewLoginForm, NewRegisterForm
from django.contrib.auth import login, authenticate, logout
from django.contrib.auth.decorators import login_required
from .constants import *
from django.contrib import messages

#@login_required(login_url='login/')
def index(request):
    return render(request, "manager/index.html")


def default_login(request):
    form = NewLoginForm()
    if request.method == "POST":
        form = NewLoginForm(request=request, data=request.POST)
        if form.is_valid():
            username = form.cleaned_data.get("username")
            password = form.cleaned_data.get("password")
            user = authenticate(username=username, password=password)
            if user is not None:
                login(request, user)
                logging.info("Login successful")
                messages.success(request, "Login successful")
                return redirect("manager:index")
            messages.error(request, "Invalid Username or password")
            return render(request, "manager/login.html", {"message": "Invalid Username or Password"})
        messages.error(request, str(form.errors))
    return render(request, "manager/login.html", {"form": form})


def default_register(request):
    form = NewRegisterForm()

    if request.method == "POST":
        form = NewRegisterForm(request.POST)
        if form.is_valid():
            form.save()
            username = form.cleaned_data.get("username")
            password = form.cleaned_data.get("password1")
            user = authenticate(username=username, password=password)
            login(request, user)
            messages.success(request, "Account has been created")
            return redirect("manager:index")
        messages.error(request, str(form.errors))
    return render(request, "manager/register.html", {"form": form})


def room(request):
    room_name = 'main'
    return render(request, 'manager/room.html', {'room_name': room_name})


def podcast(request):
    return render(request, 'manager/podcast.html')


def events(request):
    return render(request, 'manager/events.html')


def profile(request):
    form = NewRegisterForm()

    return render(request, 'manager/profile.html', {"form": form})


def default_logout(request):
    logout(request)
    return render(request, 'manager/index.html')
