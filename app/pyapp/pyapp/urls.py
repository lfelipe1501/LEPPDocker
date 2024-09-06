from django.contrib import admin
from django.urls import path
from . import views

urlpatterns = [
    path('', views.main),
    path('admin/', admin.site.urls),
]
