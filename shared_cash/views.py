import mimetypes
import markdown

from django.conf import settings
from django.contrib.auth.decorators import login_required
from django.http import HttpResponse
from django.shortcuts import redirect, render

if settings.DEBUG:
    @login_required
    def file_download(request, filename):
        return redirect(f'{settings.PROTECTED_MEDIA}{filename}')
else:
    @login_required
    def file_download(request, filename):
        response = HttpResponse()
        response['Content-Type'] = mimetypes.guess_type(filename)[0]
        response['X-Accel-Redirect'] = f'{settings.PROTECTED_MEDIA}{filename}'
        response['Content-Disposition'] = f'inline;filename={filename}'

        return response


def index(request):
    with open(settings.MARKDOWN_INDEX_PAGE, 'r') as file:
        html = markdown.markdown(file.read())
        return render(request, 'markdown-site.html', {'content': html})
