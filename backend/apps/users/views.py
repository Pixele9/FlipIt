from rest_framework import viewsets
from django.http import JsonResponse
from .serializers import UserSerializer
from rest_framework.decorators import action
from rest_framework.response import Response
from django.shortcuts import render, redirect
from django.contrib.auth import get_user_model
from rest_framework.permissions import AllowAny
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth import authenticate, login, logout
from rest_framework.decorators import api_view, permission_classes
from rest_framework.status import (
    HTTP_200_OK,
    HTTP_400_BAD_REQUEST,
    HTTP_422_UNPROCESSABLE_ENTITY,
    HTTP_500_INTERNAL_SERVER_ERROR
)

User = get_user_model()

@csrf_exempt
@api_view(["POST"],)
@permission_classes((AllowAny,))
def logIn(request):
    username = request.data.get('username')
    password = request.data.get('password')
    if username is None or password is None:
        return Response({"Error":"Porfavor, complete todos los campos", "status":"no"}, status=HTTP_422_UNPROCESSABLE_ENTITY)

    user = authenticate(username=username, password=password)
    if not user:
        return Response({"Error":"Usuario o contraseña incorrectos", "status":"no"}, status=HTTP_400_BAD_REQUEST)

    login(request, user)
    return Response({"user":user.id, "username":user.username, "email":user.email, "status":"ok"}, status=HTTP_200_OK)

@csrf_exempt
@api_view(["POST"],)
@permission_classes((AllowAny,))
def signUp(request):
    username = request.data.get('username')
    email = request.data.get('email')
    password = request.data.get('password')

    if username is None or password is None or email is None:
        return Response({"Error":"Complete all the fields", "status":"no"}, status=HTTP_422_UNPROCESSABLE_ENTITY)

    try:
        user = User.objects.create_user(username=username, email=email, password=password)
        user.save()
        return Response({"status":"ok"}, status=HTTP_200_OK)    
    except Exception as e:
        return Response({"status":"no"}, status=HTTP_500_INTERNAL_SERVER_ERROR) 

@csrf_exempt
def logOut(request):
    logout(request)
    return redirect('/')

class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    permission_classes = AllowAny