from django.db import models
from django.contrib.auth.models import BaseUserManager
from django.contrib.auth.models import AbstractBaseUser
from django.contrib.auth.models import PermissionsMixin
from django.utils.translation import ugettext_lazy as _

class MyUserManager(BaseUserManager):

    def create_user(self, username, email, password, **extra_fields):
        if not username or not email:
            raise ValueError('Debe completar todos los datos')
        user = self.model(username=username, email=email, **extra_fields)
        user.set_password(password)
        user.save()
        return user

    def create_superuser(self, email, password, **extra_fields):
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)
        extra_fields.setdefault('is_active', True)

        if extra_fields.get('is_staff') is not True:
            raise ValueError('Superuser must have is_staff=True.')
        if extra_fields.get('is_superuser') is not True:
            raise ValueError('Superuser must have is_superuser=True.')
        return self.create_user(email, password, **extra_fields)

class User(AbstractBaseUser, PermissionsMixin):
    username = models.CharField(max_length=16, null=True, unique=True, blank=False)
    email = models.EmailField(null=True, blank=False)
    is_staff = models.BooleanField(
        _('staff status'),
        default=False,
        help_text=_('Determina si el usuario puede hacer login en este sitio'),
    )
    is_active = models.BooleanField(
        _('active'),
        default=True,
        help_text=_(
            'Determina si el usuario esta activo. '
            'Deselecciona esto en lugar de borrar cuentas.'
        ),
    )
    USERNAME_FIELD = 'username'
    objects = MyUserManager()

    def __str__(self):
        return self.username