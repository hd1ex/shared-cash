from django.conf import settings
from django.contrib.auth.decorators import login_required
from django.http import HttpResponse
from django.shortcuts import redirect

if settings.DEBUG:
    @login_required
    def file_download(request, filename):
        return redirect(f'{settings.PROTECTED_MEDIA}{filename}')
else:
    @login_required
    def file_download(request, filename):
        response = HttpResponse()
        response['Content-Type'] = 'application/pdf'
        response['X-Accel-Redirect'] = f'{settings.PROTECTED_MEDIA}{filename}'
        response['Content-Disposition'] = f'inline;filename={filename}'

        return response
