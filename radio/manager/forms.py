from django import forms
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm, PasswordResetForm, UsernameField, \
    UserChangeForm
from django.contrib.auth.models import User


class NewRegisterForm(UserCreationForm):
    email = forms.EmailField(required=True, widget=forms.EmailInput(attrs={'placeholder': 'E-mail'}))
    password1 = forms.CharField(widget=forms.PasswordInput(attrs={'placeholder': 'Password'}))
    password2 = forms.CharField(widget=forms.PasswordInput(attrs={'placeholder': 'Password'}))
    username = UsernameField(widget=forms.TextInput(attrs={'placeholder': 'Username'}))

    class Meta:
        model = User
        fields = ("username", "email", "password1", "password2")


class NewLoginForm(AuthenticationForm, UsernameField):
    username = UsernameField(widget=forms.TextInput(attrs={'placeholder': 'Username'}))
    password = forms.CharField(widget=forms.PasswordInput(attrs={'placeholder': 'Password'}))


class NewForgotForm(PasswordResetForm):
    email = forms.EmailField(required=True)


class EditProfileForm(UserChangeForm):

    class Meta:
        model = User
        fields = ('username', 'email', 'first_name', 'last_name')
        exclude = ()