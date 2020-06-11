from rest_framework import serializers
from django.contrib.auth import get_user_model

User = get_user_model()

class UserSerializer(serializers.ModelSerializer):
    class Meta():
        model = User
        fields = '__all__'
        read_only_fields = ('id', )
        extra_kwargs = {
            'password': {'write_only': True},
            'last_login': {'write_only': True},
            'email': {'write_only': True},
            'is_superuser': {'write_only': True},
            'is_staff': {'write_only': True},
            'is_active': {'write_only': True},
            'groups': {'write_only': True},
            'user_permissions': {'write_only': True},
        }