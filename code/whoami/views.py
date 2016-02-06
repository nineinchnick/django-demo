from django.http import HttpResponse
from .models import Entry
import socket
import datetime

def index(request):
    current_hostname = socket.gethostname()
    current_host = socket.gethostbyname(current_hostname)
    entry = Entry(contents=u"%s (%s)" % (current_host, current_hostname), created_on=datetime.datetime.now()).save()

    entries = Entry.objects.order_by('-created_on')[:25]
    output = '<br/>'.join([str(e.id) + ' ' + e.contents for e in entries])
    return HttpResponse(output)
