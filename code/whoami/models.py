from __future__ import unicode_literals

from django.db import models

class Entry(models.Model):
    contents = models.TextField()
    created_on = models.DateTimeField()
